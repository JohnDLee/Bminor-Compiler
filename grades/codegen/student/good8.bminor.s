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
	SUBQ $16, %rsp
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
	MOVQ $2, %r10
	CMPQ %r10, %rbx
	JGE .L0
	MOVQ $0, %rbx
	JMP .L1
.L0:
	MOVQ $1, %rbx
.L1:
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_boolean
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL2:
	.string	" | "
.text
	LEAQ .SL2, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL3:
	.string	"true"
.text
	LEAQ .SL3, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
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
	MOVQ $3, %r10
	CMPQ %r10, %rbx
	JG .L4
	MOVQ $0, %rbx
	JMP .L5
.L4:
	MOVQ $1, %rbx
.L5:
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_boolean
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL6:
	.string	" | "
.text
	LEAQ .SL6, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL7:
	.string	"false"
.text
	LEAQ .SL7, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
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
	MOVQ $1, %r10
	CMPQ %r10, %rbx
	JL .L8
	MOVQ $0, %rbx
	JMP .L9
.L8:
	MOVQ $1, %rbx
.L9:
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_boolean
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL10:
	.string	" | "
.text
	LEAQ .SL10, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL11:
	.string	"false"
.text
	LEAQ .SL11, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
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
	MOVQ $2, %r10
	CMPQ %r10, %rbx
	JLE .L12
	MOVQ $0, %rbx
	JMP .L13
.L12:
	MOVQ $1, %rbx
.L13:
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_boolean
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL14:
	.string	" | "
.text
	LEAQ .SL14, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL15:
	.string	"true"
.text
	LEAQ .SL15, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
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
	MOVQ y, %r10
	CMPQ %r10, %rbx
	JE .L16
	MOVQ $0, %rbx
	JMP .L17
.L16:
	MOVQ $1, %rbx
.L17:
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_boolean
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL18:
	.string	" | "
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
.data
.SL19:
	.string	"true"
.text
	LEAQ .SL19, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
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
	MOVQ y, %r10
	CMPQ %r10, %rbx
	JNE .L20
	MOVQ $0, %rbx
	JMP .L21
.L20:
	MOVQ $1, %rbx
.L21:
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_boolean
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL22:
	.string	" | "
.text
	LEAQ .SL22, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL23:
	.string	"false"
.text
	LEAQ .SL23, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
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
	MOVQ $1, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ -16(%rbp), %rbx
	MOVQ $3, %r10
	CMPQ %r10, %rbx
	JL .L24
	MOVQ $0, %rbx
	JMP .L25
.L24:
	MOVQ $1, %rbx
.L25:
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_boolean
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL26:
	.string	" | "
.text
	LEAQ .SL26, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL27:
	.string	"true"
.text
	LEAQ .SL27, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
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
