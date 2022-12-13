.text
.globl abs
.data
.SL0:
	.quad 14
	.quad 8
	.quad 6168
	.quad 42
	.quad 0
	.quad 74546
.globl digits
digits:
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
	MOVQ $468, %rbx
	NOTQ %rbx
	ADDQ $1, %rbx
	MOVQ $4, %r10
	MOVQ digits, %r11
	MOVQ %rbx, (%r11,%r10,8)
	MOVQ $0, %rbx
	MOVQ %rbx, -8(%rbp)
.L1:
	MOVQ digits, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL abs
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ digits, %r10
	MOVQ -8(%rbp), %r11
	MOVQ (%r10,%r11,8), %r10
	CMPQ %r10, %rbx
	JE .L3
	MOVQ $0, %rbx
	JMP .L4
.L3:
	MOVQ $1, %rbx
.L4:
	CMPQ $0, %rbx
	JE .L2
	MOVQ digits, %rbx
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
	MOVQ -8(%rbp), %rbx
	MOVQ $1, %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ $32, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_character
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	JMP .L1
.L2:
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
