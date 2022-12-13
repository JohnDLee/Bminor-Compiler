.text
.globl strdup
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
.data
.SL0:
	.string	"sssss"
.text
	LEAQ .SL0, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL strdup
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ -8(%rbp), %rbx
	MOVQ -16(%rbp), %r10
	CMPQ %r10, %rbx
	JE .L3
	MOVQ $0, %rbx
	JMP .L4
.L3:
	MOVQ $1, %rbx
.L4:
	CMPQ $0, %rbx
	JE .L1
	MOVQ $22, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
	JMP .L2
.L1:
	MOVQ $11, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
.L2:
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
