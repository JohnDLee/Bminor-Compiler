.data
.globl c1
c1:
	.quad 1
.data
.globl c3
c3:
	.quad 100
.text
.globl C
C:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	PUSHQ %rsi
	SUBQ $24, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $11, %rbx
	MOVQ %rbx, -24(%rbp)
	MOVQ $12, %rbx
	MOVQ %rbx, -32(%rbp)
	MOVQ $13, %rbx
	MOVQ %rbx, -40(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ -16(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ -24(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ -32(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, %rax
	JMP .C_epilogue
.C_epilogue:
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
	MOVQ $1, %rbx
	MOVQ $2, %r10
	MOVQ %rbx, %rdi
	MOVQ %r10, %rsi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL C
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
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
