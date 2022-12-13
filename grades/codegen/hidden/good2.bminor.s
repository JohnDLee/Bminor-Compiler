.data
.SL0:
	.quad 11
	.quad 30
	.quad 22
	.quad 0
.globl X
X:
	.quad .SL0
.text
.globl main
main:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $8, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $0, %rbx
	MOVQ %rbx, -8(%rbp)
.L1:
	MOVQ X, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ $0, %r10
	CMPQ %r10, %rbx
	JNE .L3
	MOVQ $0, %rbx
	JMP .L4
.L3:
	MOVQ $1, %rbx
.L4:
	CMPQ $0, %rbx
	JE .L2
	MOVQ X, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $32, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_character
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ X, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ $3, %r10
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r10
	MOVQ %rdx, %r10
	MOVQ %r10, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $10, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_character
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ -8(%rbp), %rbx
	ADDQ $1, -8(%rbp)
	JMP .L1
.L2:
	MOVQ $0, %rbx
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
