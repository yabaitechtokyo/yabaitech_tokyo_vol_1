	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	_make_proc              ## -- Begin function make_proc
	.p2align	4, 0x90
_make_proc:                             ## @make_proc
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi0:
	.cfi_def_cfa_offset 16
Lcfi1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi2:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
Lcfi3:
	.cfi_offset %rbx, -48
Lcfi4:
	.cfi_offset %r12, -40
Lcfi5:
	.cfi_offset %r14, -32
Lcfi6:
	.cfi_offset %r15, -24
	movl	%ecx, %r14d
	movl	%edx, %r15d
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movl	$24, %edi
	callq	_malloc
	movq	%rbx, (%rax)
	movq	%r12, 8(%rax)
	movl	%r15d, 16(%rax)
	movl	%r14d, 20(%rax)
	movabsq	$281474976710655, %rcx  ## imm = 0xFFFFFFFFFFFF
	andq	%rcx, %rax
	movabsq	$9219149912204115968, %rcx ## imm = 0x7FF1000000000000
	orq	%rcx, %rax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_proc_ptr               ## -- Begin function proc_ptr
	.p2align	4, 0x90
_proc_ptr:                              ## @proc_ptr
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi7:
	.cfi_def_cfa_offset 16
Lcfi8:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi9:
	.cfi_def_cfa_register %rbp
	movabsq	$281474976710655, %rcx  ## imm = 0xFFFFFFFFFFFF
	andq	%rdi, %rcx
	movabsq	$-281474976710656, %rax ## imm = 0xFFFF000000000000
	orq	%rdi, %rax
	btq	$47, %rdi
	cmovaeq	%rcx, %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_make_int               ## -- Begin function make_int
	.p2align	4, 0x90
_make_int:                              ## @make_int
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi10:
	.cfi_def_cfa_offset 16
Lcfi11:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi12:
	.cfi_def_cfa_register %rbp
	movslq	%edi, %rax
	movabsq	$281474976710655, %rcx  ## imm = 0xFFFFFFFFFFFF
	andq	%rax, %rcx
	movabsq	$9219431387180826624, %rax ## imm = 0x7FF2000000000000
	orq	%rcx, %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	___add                  ## -- Begin function __add
	.p2align	4, 0x90
___add:                                 ## @__add
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi13:
	.cfi_def_cfa_offset 16
Lcfi14:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi15:
	.cfi_def_cfa_register %rbp
	addl	%edi, %esi
	movslq	%esi, %rax
	movabsq	$281474976710655, %rcx  ## imm = 0xFFFFFFFFFFFF
	andq	%rax, %rcx
	movabsq	$9219431387180826624, %rax ## imm = 0x7FF2000000000000
	orq	%rcx, %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_make_undef             ## -- Begin function make_undef
	.p2align	4, 0x90
_make_undef:                            ## @make_undef
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi16:
	.cfi_def_cfa_offset 16
Lcfi17:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi18:
	.cfi_def_cfa_register %rbp
	movabsq	$9219149912204116085, %rax ## imm = 0x7FF1000000000075
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_push_frame             ## -- Begin function push_frame
	.p2align	4, 0x90
_push_frame:                            ## @push_frame
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi19:
	.cfi_def_cfa_offset 16
Lcfi20:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi21:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
Lcfi22:
	.cfi_offset %rbx, -24
	movq	(%rdi), %rax
	leaq	-8(%rax), %r9
	movq	-8(%rax), %r10
	movabsq	$281474976710655, %r11  ## imm = 0xFFFFFFFFFFFF
	andq	%r10, %r11
	movabsq	$-281474976710656, %rbx ## imm = 0xFFFF000000000000
	orq	%r10, %rbx
	btq	$47, %r10
	cmovaeq	%r11, %rbx
	movl	%edx, (%rax)
	movq	%rcx, 8(%rax)
	movq	%r8, 16(%rax)
	movq	8(%rbx), %rcx
	movq	%rcx, 24(%rax)
	movq	%r9, (%rsi)
	movslq	20(%rbx), %rcx
	leaq	32(%rax,%rcx,8), %rax
	movq	%rax, (%rdi)
	popq	%rbx
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Lcfi23:
	.cfi_def_cfa_offset 16
Lcfi24:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Lcfi25:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
Lcfi26:
	.cfi_offset %rbx, -56
Lcfi27:
	.cfi_offset %r12, -48
Lcfi28:
	.cfi_offset %r13, -40
Lcfi29:
	.cfi_offset %r14, -32
Lcfi30:
	.cfi_offset %r15, -24
	movabsq	$9219431387180826626, %r12 ## imm = 0x7FF2000000000002
	movabsq	$9219149912204115968, %r14 ## imm = 0x7FF1000000000000
	movabsq	$281474976710655, %r13  ## imm = 0xFFFFFFFFFFFF
	movl	$4096, %edi             ## imm = 0x1000
	callq	_malloc
	movq	%rax, %rbx
	movl	$24, %edi
	callq	_malloc
	leaq	Ltmp0(%rip), %rcx
	movq	%rcx, (%rax)
	movq	%rbx, 8(%rax)
	movq	$2, 16(%rax)
	andq	%r13, %rax
	orq	%r14, %rax
	movq	_add@GOTPCREL(%rip), %r15
	movq	%rax, (%r15)
	movl	$24, %edi
	callq	_malloc
	movq	%r15, %r9
	movabsq	$140737488355328, %r8   ## imm = 0x800000000000
	movabsq	$-281474976710656, %rdi ## imm = 0xFFFF000000000000
	leaq	Ltmp1(%rip), %rcx
	movq	%rcx, (%rax)
	movq	%rbx, 8(%rax)
	movq	$1, 16(%rax)
	movq	%rax, %rcx
	andq	%r13, %rcx
	leaq	(%rcx,%r14), %rdx
	movq	%rdx, (%rbx)
	movq	%rax, %rsi
	orq	%rdi, %rsi
	btq	$47, %rax
	cmovaeq	%rcx, %rsi
	movl	$1, 8(%rbx)
	leaq	Ltmp2(%rip), %rax
	movq	%rax, 16(%rbx)
	movq	%rbx, 24(%rbx)
	movq	8(%rsi), %rax
	movq	%rax, 32(%rbx)
	movslq	20(%rsi), %rax
	leaq	40(%rbx,%rax,8), %r15
	leaq	117(%r14), %r14
	movq	%rdx, %rax
	andq	%r13, %rax
	movq	%rdx, %rcx
	orq	%rdi, %rcx
	testq	%r8, %rdx
	cmoveq	%rax, %rcx
	jmpq	*(%rcx)
Ltmp2:                                  ## Block address taken
LBB6_1:
	leaq	L_.str(%rip), %rdi
	xorl	%eax, %eax
	movl	%r14d, %esi
	callq	_printf
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.p2align	4, 0x90
Ltmp0:                                  ## Block address taken
LBB6_2:                                 ## =>This Inner Loop Header: Depth=1
	movl	-16(%rbx), %eax
	addl	-8(%rbx), %eax
	cltq
	andq	%r13, %rax
	leaq	-2(%r12), %r14
	orq	%rax, %r14
	movq	%rbx, %rax
	movq	24(%rbx), %rbx
	addq	$16, %rax
	jmpq	*(%rax)
Ltmp1:                                  ## Block address taken
LBB6_3:                                 ## =>This Inner Loop Header: Depth=1
	movl	$24, %edi
	callq	_malloc
	movq	_add@GOTPCREL(%rip), %r9
	movabsq	$140737488355328, %r8   ## imm = 0x800000000000
	movabsq	$-281474976710656, %rdi ## imm = 0xFFFF000000000000
	leaq	Ltmp3(%rip), %rcx
	movq	%rcx, (%rax)
	movq	%rbx, 8(%rax)
	movabsq	$12884901889, %rcx      ## imm = 0x300000001
	movq	%rcx, 16(%rax)
	andq	%r13, %rax
	movabsq	$9219149912204115968, %rcx ## imm = 0x7FF1000000000000
	orq	%rcx, %rax
	movq	_f@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
	movq	%r12, (%r15)
	movq	(%rcx), %rax
	movq	%rax, 8(%r15)
	movups	16(%rbx), %xmm0
	leaq	8(%r15), %rbx
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	movl	$2, 16(%r15)
	movups	%xmm0, 24(%r15)
	movl	$6, %eax
	movl	$5, %ecx
	movq	8(%rdx), %rsi
	movq	%rsi, (%r15,%rcx,8)
	leaq	(%r15,%rax,8), %rax
	movslq	20(%rdx), %rcx
	leaq	(%rax,%rcx,8), %r15
	movq	(%rbx), %rax
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	jmpq	*(%rdx)
	.p2align	4, 0x90
Ltmp3:                                  ## Block address taken
LBB6_4:                                 ## =>This Inner Loop Header: Depth=1
	leaq	-1(%r12), %rax
	movq	%rax, (%r15)
	movq	-8(%rbx), %rax
	movq	%rax, 8(%r15)
	movq	(%r9), %rax
	movq	%rax, 16(%r15)
	movl	$3, 24(%r15)
	leaq	Ltmp4(%rip), %rcx
	movq	%rcx, 32(%r15)
	movq	%rbx, 40(%r15)
	leaq	16(%r15), %rbx
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	movl	$7, %eax
	movl	$6, %ecx
	movq	8(%rdx), %rsi
	movq	%rsi, (%r15,%rcx,8)
	leaq	(%r15,%rax,8), %rax
	movslq	20(%rdx), %rcx
	leaq	(%rax,%rcx,8), %r15
	movq	(%rbx), %rax
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	jmpq	*(%rdx)
	.p2align	4, 0x90
Ltmp4:                                  ## Block address taken
LBB6_5:                                 ## =>This Inner Loop Header: Depth=1
	movq	%r14, 56(%rbx)
	leaq	1(%r12), %rax
	movq	%rax, (%r15)
	movq	-8(%rbx), %rax
	movq	%rax, 8(%r15)
	movq	(%r9), %rax
	movq	%rax, 16(%r15)
	movl	$3, 24(%r15)
	leaq	Ltmp5(%rip), %rcx
	movq	%rcx, 32(%r15)
	movq	%rbx, 40(%r15)
	leaq	16(%r15), %rbx
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	movl	$7, %eax
	movl	$6, %ecx
	movq	8(%rdx), %rsi
	movq	%rsi, (%r15,%rcx,8)
	leaq	(%r15,%rax,8), %rax
	movslq	20(%rdx), %rcx
	leaq	(%rax,%rcx,8), %r15
	movq	(%rbx), %rax
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	jmpq	*(%rdx)
	.p2align	4, 0x90
Ltmp5:                                  ## Block address taken
LBB6_6:                                 ## =>This Inner Loop Header: Depth=1
	movq	%r14, 48(%rbx)
	movq	%r12, (%r15)
	movq	48(%rbx), %rax
	movq	%rax, 8(%r15)
	movq	(%r9), %rax
	movq	%rax, 16(%r15)
	movl	$3, 24(%r15)
	leaq	Ltmp6(%rip), %rcx
	movq	%rcx, 32(%r15)
	movq	%rbx, 40(%r15)
	leaq	16(%r15), %rbx
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	movl	$7, %eax
	movl	$6, %ecx
	movq	8(%rdx), %rsi
	movq	%rsi, (%r15,%rcx,8)
	leaq	(%r15,%rax,8), %rax
	movslq	20(%rdx), %rcx
	leaq	(%rax,%rcx,8), %r15
	movq	(%rbx), %rax
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	jmpq	*(%rdx)
	.p2align	4, 0x90
Ltmp6:                                  ## Block address taken
LBB6_7:                                 ## =>This Inner Loop Header: Depth=1
	movq	%r14, 40(%rbx)
	movq	56(%rbx), %rax
	movq	%rax, (%r15)
	movq	40(%rbx), %rax
	movq	%rax, 8(%r15)
	movq	(%r9), %rax
	movq	%rax, 16(%r15)
	movups	16(%rbx), %xmm0
	leaq	16(%r15), %rbx
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	movl	$3, 24(%r15)
	movups	%xmm0, 32(%r15)
	movl	$7, %eax
	movl	$6, %ecx
	movq	8(%rdx), %rsi
	movq	%rsi, (%r15,%rcx,8)
	leaq	(%r15,%rax,8), %rax
	movslq	20(%rdx), %rcx
	leaq	(%rax,%rcx,8), %r15
	movq	(%rbx), %rax
	movq	%rax, %rcx
	andq	%r13, %rcx
	movq	%rax, %rdx
	orq	%rdi, %rdx
	testq	%r8, %rax
	cmoveq	%rcx, %rdx
	jmpq	*(%rdx)
	.cfi_endproc
                                        ## -- End function
	.comm	_add,8,3                ## @add
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%d\n"

	.comm	_f,8,3                  ## @f

.subsections_via_symbols
