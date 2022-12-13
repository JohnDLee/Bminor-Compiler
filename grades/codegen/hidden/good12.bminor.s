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
	MOVQ $4, %rbx
	MOVQ $9, %r10
	MOVQ $2, %r11
	NOTQ %r11
	ADDQ $1, %r11
	MOVQ $5, %r12
	NOTQ %r12
	ADDQ $1, %r12
	SUBQ %r12, %r11
	MOVQ %r10, %rax
	CQO
	IDIVQ %r11
	MOVQ %rax, %r11
	ADDQ %r11, %rbx
	MOVQ $2, %r10
	MOVQ $1, %r11
	ADDQ %r11, %r10
	MOVQ $4, %r11
	MOVQ %r10, %rax
	IMULQ %r11
	MOVQ %rax, %r11
	MOVQ $1, %r10
	SUBQ %r10, %r11
	MOVQ $3, %r10
	MOVQ %r11, %rax
	CQO
	IDIVQ %r10
	MOVQ %rdx, %r10
	MOVQ $7, %r11
	MOVQ %r10, %rax
	IMULQ %r11
	MOVQ %rax, %r11
	ADDQ %r11, %rbx
	MOVQ $2, %r10
	MOVQ $3, %r11
	MOVQ %r10, %rdi
	MOVQ %r11, %rsi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL integer_power
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %r10
	SUBQ %r10, %rbx
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
