#include <stdio.h>
#include <stdlib.h>

#define _CONCAT_IMPL(x,y) x##y
#define CONCAT(x,y) _CONCAT_IMPL(x,y)
#define GENSYM(prefix) CONCAT(prefix,__COUNTER__)

#define ANY_NAN_BOXING
#include "any.h"

typedef struct any value_t;

struct proc {
  void *addr;
  struct frame *env;
  int nargs;
  int frame_size;
};

value_t make_proc(void *addr, struct frame *fp, int nargs, int flags, int frame_size) {
  struct proc *proc = malloc(sizeof *proc);
  proc->addr = addr;
  proc->env = fp;
  proc->nargs = nargs;
  proc->frame_size = frame_size;
  return ptr_any(ANY_TAG0, proc);
}

struct proc *proc_ptr(value_t v) {
  return any_ptr(v);
}

value_t make_int(int i) {
  return int_any(ANY_TAG1, i);
}

value_t __add(value_t a, value_t b) {
  return make_int(any_int(a) + any_int(b));
}

struct frame {
  value_t args[1];
  int nargs;
  void *ret_addr;
  struct frame *dynamic_link;
  struct frame *static_link;
  value_t regs[];
};

value_t *sp;
struct frame *fp;

void init_stack(void) {
  sp = malloc(4096);
  fp = (struct frame *) sp;
}

#define PUSH(v) (*sp++ = (v))
#define REG(n) (fp->regs[n])
#define ARG(n) (fp->args[-(n)])

void push_frame(int nargs, void *ret_addr, struct frame *ret_fp) {
  struct proc *proc = proc_ptr(sp[-1]);
  //check_args();
  struct frame *newfp = (struct frame *) (sp - 1);
  newfp->nargs = nargs;
  newfp->ret_addr = ret_addr;
  newfp->dynamic_link = ret_fp;
  newfp->static_link = proc->env;
  fp = newfp;
  sp = &fp->regs[proc->frame_size];
}

#define CALL(nargs) CALL_HELP(nargs, GENSYM(L_))
#define CALL_HELP(nargs, label)			\
  ({						\
    push_frame(nargs, &&label, fp);		\
    goto *proc_ptr(fp->args[0])->addr;		\
  label:;					\
  })

#define RET()					\
  ({						\
    void *ret_addr = fp->ret_addr;		\
    fp = fp->dynamic_link;			\
    goto *ret_addr;				\
  })  

#define TAILCALL(nargs)					\
  ({							\
    push_frame(nargs, fp->ret_addr, fp->dynamic_link);	\
    goto *proc_ptr(fp->args[0])->addr;			\
  })

value_t add;
value_t f;

/*
(begin
  (define f
    (lambda (x)
      (add (add (add x 3) 2) (add x 1))))
  (f 2))
*/

int main(int argc, char *argv[]) {
  value_t val0;

  init_stack();

  add = make_proc(&&L_add, fp, 2, 0, 0);

  PUSH(make_proc(&&start, fp, 1, 0, 0));
  CALL(1);
  printf("%d\n", any_int(val0));
  return 0;

 start:
  f = make_proc(&&L_f, fp, 2, 0, 1);
  PUSH(make_int(2));
  PUSH(f);
  TAILCALL(2);

 L_f:
  PUSH(make_int(1));
  PUSH(ARG(1));
  PUSH(add);
  CALL(3);
  REG(0) = val0;
  PUSH(make_int(3));
  PUSH(ARG(1));
  PUSH(add);
  CALL(3);
  PUSH(make_int(2));
  PUSH(val0);
  PUSH(add);
  CALL(3);
  PUSH(REG(0));
  PUSH(val0);
  PUSH(add);
  TAILCALL(3);

 L_add:
  val0 = __add(ARG(1), ARG(2));
  RET();
}
