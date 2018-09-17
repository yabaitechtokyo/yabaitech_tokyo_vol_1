(define (anf-transform expr)
  (let ((commands '()))
    (define (add-command! cmd)
      (set! commands (cons cmd commands)))
    (define make-variable!
      (let ((counter 0))
        (lambda ()
          (let ((t (string->symbol
                    (string-append
                     "%"
                     (number->string counter)))))
            (set! counter (+ counter 1))
            t))))
    (add-command!
     (let go ((expr expr) (tail-pos? #t))
       (if (not (list? expr))
           expr
           (case (car expr)
             ((lambda)
              `(lambda ,(cadr expr) ,(anf-transform (caddr expr))))
             ((define set!)
              (let ((a (go (caddr expr) #f)))
                (add-command! `(,(car expr) ,(cadr expr) ,a)))
              #f)
             ((begin)
              (let ((es (reverse (cdr expr))))
                (let ((last (car es)) (seq (reverse (cdr es))))
                  (for-each (lambda (e) (go e #f)) seq)
                  (go last tail-pos?))))
             ((if)
              (let ((v (go (cadr expr) #f)))
                `(if ,v
                     ,(anf-transform (caddr expr))
                     ,(anf-transform (cadddr expr)))))
             (else
              (let ((seq (reverse (map (lambda (e) (go e #f)) (reverse expr)))))
                (if tail-pos?
                    seq
                    (let ((v (make-variable!)))
                      (add-command! `(let ,v ,seq))
                      v))))))))
    `(begin ,@(reverse commands))))

(anf-transform
 '(begin
    (define f
      (lambda (x)
      (add (add (add x 3) 2) (add x 1))))
    (f 2)))

;; (let t0 (lambda (x)
;;        (let t1 (add x 1)
;;          (let t2 (add x 3)
;;            (let t3 (add t2 2)
;;              (let t4 (add t3 t1)
;;                t4)))))
;;   (define f t0)
;;   (f 2))

;; =>
;; ((define f
;;    (lambda (x)
;;      ((let t0 (add x 1))
;;       (let t1 (add x 3))
;;       (let t2 (add t1 2))
;;       (add t2 t0))))
;;  (f 2))

;; (anf-transform
;;  '(if a
;;       (add (if x y z))
;;       b))

(define indent-level 0)
(define (indent n)
  (set! indent-level (+ indent-level n)))
(define (emit-indent)
  (do ((i 0 (+ i 1)))
      ((= i (* 2 indent-level)))
    (display "  ")))
(define (emit . args)
  (emit-indent)
  (for-each display args)
  (newline))
(define (emit-label l)
  (set! indent-level (- indent-level 1))
  (emit l ":")
  (set! indent-level (+ indent-level 1)))

(define (emit-value tail-pos? c)
  (if tail-pos?
      (emit "val0 = " c ";")
      c))

(define (c-name sym)
  (list->string
   (map
    (lambda (c) (if (char=? c #\-) #\_ c))
    (string->list (symbol->string sym)))))

(define delayed '())
(define (push-delayed! c)
  (set! delayed (cons c delayed)))

(define make-label
  (let ((n 0))
    (lambda ()
      (let ((l (string-append "L_" (number->string n))))
        (set! n (+ n 1))
        l))))

(define (lookup var env)
  (let loop ((env env) (i 0))
    (if (null? env)
        #f
        (let ((frame (car env)))
          (cond
           ((assq var frame) => (lambda (x) (cons i (cdr x))))
           (else (loop (cdr env) (+ i 1))))))))

(define (gen-body expr)
  (set! indent-level 1)
  (let gen-body ((expr expr) (env '()) (reg-map '()))
    (let go ((expr expr) (tail-pos? #t))
      (if (not (list? expr))
          (emit-value
           tail-pos?
           (cond
            ((symbol? expr)
             (let ((it (assq expr reg-map)))
               (if it
                   (string-append
                    "REG(" (number->string (cdr it)) ")")
                   (let ((it (lookup expr env)))
                     (if it
                         (string-append
                          "ARG(" (number->string (car it)) ", " (number->string (cdr it)) ")")
                         (c-name expr))))))
            ((integer? expr)
             (string-append
              "make_int(" (number->string expr) ")"))
            (else
             (error "unknown type"))))
          (case (car expr)
            ((define)
             (let ((x (go (cadr expr) #f))
                   (v (go (caddr expr) #f)))
               (emit x " = " v ";"))
             "make_undef()")
            ((lambda)
             (let ((l (make-label)))
               (push-delayed!
                (delay
                  (begin
                    (emit-label l)
                    (gen-body
                     (caddr expr)
                     (cons (let loop ((vars (cadr expr)) (i 1))
                             (if (null? vars)
                                 '()
                                 (cons (cons (car vars) i) (loop (cdr vars) (+ i 1)))))
                           env)
                     (let ((seq (cdr (caddr expr))))
                       (let ((regs '()))
                         (do ((seq seq (cdr seq)))
                             ((null? seq))
                           (let ((cmd (car seq)))
                             (when (and (pair? cmd) (eq? (car cmd) 'let))
                               (set! regs (cons (cadr cmd) regs)))))
                         (let loop ((i 0) (regs regs))
                           (if (null? regs)
                               '()
                               (cons (cons (car regs) i) (loop (+ i 1) (cdr regs)))))))))))
               (emit-value tail-pos?
                           (string-append
                            "PROC(" l ", "
                            (number->string (length (cadr expr))) ", "
                            (number->string (length expr)) ")"))))
            ;; ((set!))
            ((begin)
             (let ((es (reverse (cdr expr))))
               (let ((last (car es))
                     (seq (reverse (cdr es))))
                 (for-each (lambda (e) (go e #f)) seq)
                 (go last tail-pos?))))
            ;; ((if)
            ;;  (let ((v (go (cadr expr) #f)))
            ;;    (emit "if (! false_p(" v ")) {")
            ;;    (indent +1)
            ;;    (let ((w (go (caddr expr) tail-pos?)))
            ;;      (unless tail-pos?
            ;;        (emit "val0 = " w ";")))
            ;;    (indent -1)
            ;;    (emit "} else {")
            ;;    (indent +1)
            ;;    (let ((w (go (cadddr expr) tails-pos?)))
            ;;      (unless tail-pos?
            ;;        (emit "val0 = " w ";")))
            ;;    (indent -1)
            ;;    (emit "}")
            ;;    "val0"))
            ((let)
             (emit (go (cadr expr) #f) " = " (go (caddr expr) #f) ";")
             'dont-use)
            (else
             (let ((len (length expr)))
               (for-each
                (lambda (x)
                  (let ((c (go x #f)))
                    (emit "PUSH(" c ");")))
                (reverse expr))
               (if tail-pos?
                   (begin
                     (emit "TAILCALL(" (number->string len) ");")
                     'dont-use)
                   (begin
                     (emit "CALL(" (number->string len) ");")
                     "val0")))))))
    (emit))
  (let loop ()
    (unless (null? delayed)
      (let ((p (car delayed)))
        (set! delayed (cdr delayed))
        (force p))))
  (set! indent-level 0))

(define (codegen e)
  (emit "#include \"acryl.h\"")
  (emit "")
  (emit "ACRYL_BEGIN")
  (gen-body e)
  (emit "ACRYL_END"))

(define (compile e)
  (codegen (anf-transform e)))

(define (compile-to-file filename e)
  (with-output-to-file filename
    (lambda ()
      (compile e))))

(define sample1
  '(begin
     (define f
       (lambda (x)
         (add (add (add x 3) 2) (add x 1))))
     (f 2)))

(compile-to-file "a.c" sample1)

(codegen
 (anf-transform
  '(begin
     (define f
       (lambda (x)
         (add (add (add x 3) 2) (add x 1))))
     (f 2))))

(define (optimize-command-seq commands)
  commands) ; TODO

; ((let t0 (add x 1))
;  (let t1 (add x 3))
;  (let t2 (add t1 2))
;  (add t2 t0))

; ((move val0 (add x 1))
;  (move t0 val0)
;  (move val0 (add x 3))
;  (move t1 val0)
;  (move val0 (add t1 2))
;  (move t2 val0)
;  (add t2 t0))

; ((move val0 (add x 1))
;  (move t0 val0)
;  (move val0 (add x 3))
;  (move t1 val0)
;  (move val0 (add val0 2))
;  (move t2 val0)
;  (add val0 t0))

; ((move val0 (add x 1))
;  (move t0 val0)
;  (move val0 (add x 3))
;  (move val0 (add val0 2))
;  (add val0 t0))

