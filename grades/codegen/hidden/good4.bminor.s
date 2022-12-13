.text
.globl collatz
collatz:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	PUSHQ %rsi
	SUBQ $0, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
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
	MOVQ $1, %r10
	CMPQ %r10, %rbx
	JE .L2
	MOVQ $0, %rbx
	JMP .L3
.L2:
	MOVQ $1, %rbx
.L3:
	CMPQ $0, %rbx
	JE .L0
	MOVQ -16(%rbp), %rbx
	MOVQ %rbx, %rax
	JMP .collatz_epilogue
	JMP .L1
.L0:
.L1:
	MOVQ -8(%rbp), %rbx
	MOVQ $2, %r10
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r10
	MOVQ %rdx, %r10
	MOVQ $0, %rbx
	CMPQ %rbx, %r10
	JE .L6
	MOVQ $0, %r10
	JMP .L7
.L6:
	MOVQ $1, %r10
.L7:
	CMPQ $0, %r10
	JE .L4
	MOVQ -8(%rbp), %rbx
	MOVQ $2, %r10
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r10
	MOVQ %rax, %r10
	MOVQ -16(%rbp), %rbx
	MOVQ $1, %r11
	ADDQ %r11, %rbx
	MOVQ %r10, %rdi
	MOVQ %rbx, %rsi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL collatz
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rax
	JMP .collatz_epilogue
	JMP .L5
.L4:
	MOVQ $3, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ %rbx, %rax
	IMULQ %r10
	MOVQ %rax, %r10
	MOVQ $1, %rbx
	ADDQ %rbx, %r10
	MOVQ -16(%rbp), %rbx
	MOVQ $1, %r11
	ADDQ %r11, %rbx
	MOVQ %r10, %rdi
	MOVQ %rbx, %rsi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL collatz
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rax
	JMP .collatz_epilogue
.L5:
.collatz_epilogue:
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
	MOVQ $27, %rbx
	MOVQ $0, %r10
	MOVQ %rbx, %rdi
	MOVQ %r10, %rsi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL collatz
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
