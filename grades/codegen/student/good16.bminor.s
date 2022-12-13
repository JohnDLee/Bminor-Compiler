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
.L0:
	MOVQ -8(%rbp), %rbx
	MOVQ $100, %r10
	CMPQ %r10, %rbx
	JL .L2
	MOVQ $0, %rbx
	JMP .L3
.L2:
	MOVQ $1, %rbx
.L3:
	CMPQ $0, %rbx
	JE .L1
	MOVQ -8(%rbp), %rbx
	MOVQ $50, %r10
	CMPQ %r10, %rbx
	JL .L6
	MOVQ $0, %rbx
	JMP .L7
.L6:
	MOVQ $1, %rbx
.L7:
	CMPQ $0, %rbx
	JE .L4
	MOVQ $0, %rbx
	MOVQ %rbx, -16(%rbp)
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
	JMP .L5
.L4:
	MOVQ -8(%rbp), %rbx
	MOVQ $75, %r10
	CMPQ %r10, %rbx
	JL .L10
	MOVQ $0, %rbx
	JMP .L11
.L10:
	MOVQ $1, %rbx
.L11:
	CMPQ $0, %rbx
	JE .L8
	MOVQ $0, %rbx
	MOVQ %rbx, -24(%rbp)
	MOVQ -8(%rbp), %rbx
	NOTQ %rbx
	ADDQ $1, %rbx
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
	JMP .L9
.L8:
	MOVQ $0, %rbx
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
.L9:
.L5:
	MOVQ -8(%rbp), %rbx
	MOVQ $80, %r10
	CMPQ %r10, %rbx
	JE .L14
	MOVQ $0, %rbx
	JMP .L15
.L14:
	MOVQ $1, %rbx
.L15:
	CMPQ $0, %rbx
	JE .L12
	MOVQ $1, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
	JMP .L13
.L12:
.L13:
	MOVQ -8(%rbp), %rbx
	ADDQ $1, -8(%rbp)
	JMP .L0
.L1:
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
