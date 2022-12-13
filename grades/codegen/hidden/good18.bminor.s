.data
.globl b1
b1:
	.quad 3
.data
.globl b2
b2:
	.quad 6
.data
.globl b3
b3:
	.quad 9
.text
.globl B
B:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	PUSHQ %rsi
	SUBQ $0, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ b1, %rbx
	MOVQ b2, %r10
	MOVQ %rbx, %rax
	IMULQ %r10
	MOVQ %rax, %r10
	MOVQ -8(%rbp), %rbx
	MOVQ -16(%rbp), %r11
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r11
	MOVQ %rdx, %r11
	ADDQ %r11, %r10
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
	MOVQ $37, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ %rbx, %rax
	JMP .B_epilogue
.B_epilogue:
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
	MOVQ $5, %rbx
	MOVQ $3, %r10
	MOVQ %rbx, %rdi
	MOVQ %r10, %rsi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL B
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ b3, %rbx
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
