.data
.SL0:
	.quad 1
	.quad 1
	.quad 1
	.quad 1
	.quad 1
.globl y
y:
	.quad .SL0
.text
.globl main
main:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $16, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ y, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ y, %rbx
	MOVQ $0, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ y, %r10
	MOVQ $0, %r11
	ADDQ $1, (%r10,%r11,8)
	MOVQ %rbx, -16(%rbp)
	MOVQ y, %rbx
	MOVQ $1, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ y, %r10
	MOVQ $1, %r11
	ADDQ $1, (%r10,%r11,8)
	MOVQ y, %rbx
	MOVQ $2, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ y, %r10
	MOVQ $2, %r11
	ADDQ $1, (%r10,%r11,8)
	MOVQ y, %rbx
	MOVQ $1, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ y, %r10
	MOVQ $1, %r11
	SUBQ $1, (%r10,%r11,8)
	MOVQ y, %rbx
	MOVQ $0, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ y, %rbx
	MOVQ $1, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ y, %rbx
	MOVQ $2, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ y, %rbx
	MOVQ $3, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ y, %rbx
	MOVQ $4, %r10
	MOVQ (%rbx,%r10,8), %rbx
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
	MOVQ $21211, %rbx
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
	MOVQ -16(%rbp), %rbx
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
	MOVQ $1, %rbx
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
