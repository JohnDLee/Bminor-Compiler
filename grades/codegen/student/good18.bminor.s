.data
.SL0:
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
.globl y
y:
	.quad .SL0
.data
.globl p
p:
	.quad 0
.data
.globl s
s:
	.quad 0
.data
.SL1:
	.string "test_global\n"
.globl q
q:
	.quad .SL1
.text
.globl main
main:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $32, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $0, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ $0, %rbx
	MOVQ %rbx, -8(%rbp)
.L2:
	MOVQ -8(%rbp), %rbx
	MOVQ $10, %r10
	CMPQ %r10, %rbx
	JL .L4
	MOVQ $0, %rbx
	JMP .L5
.L4:
	MOVQ $1, %rbx
.L5:
	CMPQ $0, %rbx
	JE .L3
	MOVQ -8(%rbp), %rbx
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
	MOVQ -8(%rbp), %rbx
	ADDQ $1, -8(%rbp)
	JMP .L2
.L3:
	MOVQ $0, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ $1, %rbx
	MOVQ %rbx, -16(%rbp)
.L6:
	MOVQ -16(%rbp), %rbx
	MOVQ $10, %r10
	CMPQ %r10, %rbx
	JL .L8
	MOVQ $0, %rbx
	JMP .L9
.L8:
	MOVQ $1, %rbx
.L9:
	CMPQ $0, %rbx
	JE .L7
	MOVQ $0, %rbx
	MOVQ %rbx, -24(%rbp)
	MOVQ $1, %rbx
	MOVQ %rbx, -24(%rbp)
.L10:
	MOVQ -24(%rbp), %rbx
	MOVQ -16(%rbp), %r10
	CMPQ %r10, %rbx
	JL .L12
	MOVQ $0, %rbx
	JMP .L13
.L12:
	MOVQ $1, %rbx
.L13:
	CMPQ $0, %rbx
	JE .L11
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
	MOVQ -24(%rbp), %rbx
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
	ADDQ $1, -24(%rbp)
	JMP .L10
.L11:
	MOVQ -16(%rbp), %rbx
	ADDQ $1, -16(%rbp)
	JMP .L6
.L7:
	MOVQ $0, %rbx
	MOVQ %rbx, -8(%rbp)
.L14:
	MOVQ -8(%rbp), %rbx
	MOVQ $5, %r10
	CMPQ %r10, %rbx
	JL .L16
	MOVQ $0, %rbx
	JMP .L17
.L16:
	MOVQ $1, %rbx
.L17:
	CMPQ $0, %rbx
	JE .L15
	MOVQ -8(%rbp), %rbx
	MOVQ -8(%rbp), %r10
	MOVQ y, %r11
	MOVQ %rbx, (%r11,%r10,8)
	MOVQ -8(%rbp), %rbx
	ADDQ $1, -8(%rbp)
	JMP .L14
.L15:
	MOVQ $0, %rbx
	MOVQ %rbx, -32(%rbp)
	MOVQ y, %rbx
	MOVQ $4, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ %rbx, -32(%rbp)
	MOVQ -32(%rbp), %rbx
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
.data
.SL18:
	.string	"01234\n"
.text
	LEAQ .SL18, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
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
