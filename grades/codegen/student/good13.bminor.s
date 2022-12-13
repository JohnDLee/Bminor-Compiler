.text
.globl f
.text
.globl t
t:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	PUSHQ %rsi
	PUSHQ %rdx
	PUSHQ %rcx
	SUBQ $0, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ -24(%rbp), %rbx
	MOVQ %rbx, %rax
	JMP .t_epilogue
.t_epilogue:
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
	SUBQ $32, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $10, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ $0, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ $99, %rbx
	MOVQ %rbx, -24(%rbp)
.data
.SL0:
	.string	"string"
.text
	LEAQ .SL0, %rbx
	MOVQ %rbx, -32(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ -16(%rbp), %r10
	MOVQ -8(%rbp), %r11
	MOVQ -16(%rbp), %r12
	MOVQ -24(%rbp), %r13
	MOVQ -32(%rbp), %r14
	MOVQ %r11, %rdi
	MOVQ %r12, %rsi
	MOVQ %r13, %rdx
	MOVQ %r14, %rcx
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL t
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %r11
	MOVQ -32(%rbp), %r12
	MOVQ %rbx, %rdi
	MOVQ %r10, %rsi
	MOVQ %r11, %rdx
	MOVQ %r12, %rcx
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
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
.text
.globl f
f:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	PUSHQ %rsi
	PUSHQ %rdx
	PUSHQ %rcx
	SUBQ $8, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $10, %rbx
	MOVQ %rbx, -40(%rbp)
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
	MOVQ -16(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_boolean
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
	CALL print_character
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
	MOVQ -32(%rbp), %rbx
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
	JMP .f_epilogue
.f_epilogue:
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
