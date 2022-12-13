.data
.globl a
a:
	.quad 0
.text
.globl main
main:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $0, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $60, %rbx
	MOVQ $2, %r10
	MOVQ a, %r11
	MOVQ %rbx, (%r11,%r10,8)
	MOVQ a, %rbx
	MOVQ $2, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ a, %r10
	MOVQ $2, %r11
	MOVQ (%r10,%r11,8), %r10
	MOVQ $20, %r11
	MOVQ %r10, %rax
	CQO
	IDIVQ %r11
	MOVQ %rax, %r11
	MOVQ $3, %r10
	MOVQ %r11, %rax
	IMULQ %r10
	MOVQ %rax, %r10
	ADDQ %r10, %rbx
	MOVQ a, %r10
	MOVQ $1, %r11
	MOVQ (%r10,%r11,8), %r10
	SUBQ %r10, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
.main_epilogue:
	POPQ %r15
	POPQ %r14
	POPQ %r13
	POPQ %r12
	POPQ %r11
	POPQ %r10
	POPQ %rbx
	MOVQ %rbp, %rsp
	POPQ %rbp
	RET
