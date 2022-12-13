.data
.globl x
x:
	.quad 1
.data
.globl y
y:
	.quad 2
.text
.globl main
main:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $24, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $2, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ y, %r10
	MOVQ %rbx, %rdi
	MOVQ %r10, %rsi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL integer_power
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ y, %r10
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r10
	MOVQ %rdx, %r10
	MOVQ %r10, -24(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL0:
	.string	" | "
.text
	LEAQ .SL0, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $4, %rbx
	MOVQ %rbx, %rdi
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
	MOVQ -24(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL1:
	.string	" | "
.text
	LEAQ .SL1, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $0, %rbx
	MOVQ %rbx, %rdi
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
