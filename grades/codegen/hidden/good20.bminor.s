.text
.globl D
D:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $64, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $5, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ $1, %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ $9, %rbx
	MOVQ %rbx, -24(%rbp)
	MOVQ -24(%rbp), %rbx
	MOVQ -8(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ $3, %r10
	SUBQ %r10, %rbx
	MOVQ %rbx, -32(%rbp)
	MOVQ $1, %rbx
	NOTQ %rbx
	ADDQ $1, %rbx
	MOVQ %rbx, -40(%rbp)
	MOVQ -32(%rbp), %rbx
	MOVQ -24(%rbp), %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -32(%rbp)
	MOVQ -32(%rbp), %rbx
	MOVQ -40(%rbp), %r10
	SUBQ %r10, %rbx
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
	.string	"\n"
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
	MOVQ $16, %rbx
	MOVQ %rbx, -48(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ -48(%rbp), %r10
	SUBQ %r10, %rbx
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
	MOVQ $2, %rbx
	NOTQ %rbx
	ADDQ $1, %rbx
	MOVQ %rbx, -56(%rbp)
	MOVQ $1000, %rbx
	MOVQ %rbx, -64(%rbp)
	MOVQ -64(%rbp), %rbx
	MOVQ $10, %r10
	ADDQ %r10, %rbx
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
	.string	"\n"
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
	MOVQ -56(%rbp), %rbx
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
	MOVQ -48(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $3, %rbx
	MOVQ %rbx, %rax
	JMP .D_epilogue
.D_epilogue:
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
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL D
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
