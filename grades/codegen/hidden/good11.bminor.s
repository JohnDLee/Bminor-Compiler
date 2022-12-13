.text
.globl main
main:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $40, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $20, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ $10, %rbx
	MOVQ %rbx, -24(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ -24(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ -8(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ $2, %rbx
	MOVQ %rbx, -32(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ -32(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ -8(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ $3, %rbx
	MOVQ %rbx, -40(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ -40(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ -8(%rbp), %r10
	ADDQ %r10, %rbx
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
