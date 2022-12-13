.text
.globl f
f:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	SUBQ $8, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $0, %rbx
	MOVQ %rbx, -16(%rbp)
.L0:
	MOVQ -8(%rbp), %rbx
	MOVQ $0, %r10
	CMPQ %r10, %rbx
	JG .L2
	MOVQ $0, %rbx
	JMP .L3
.L2:
	MOVQ $1, %rbx
.L3:
	CMPQ $0, %rbx
	JE .L1
	MOVQ -16(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ -16(%rbp), %rbx
	MOVQ $1, %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, -16(%rbp)
	MOVQ -8(%rbp), %rbx
	SUBQ $1, -8(%rbp)
	JMP .L0
.L1:
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
	MOVQ $6, %rbx
	MOVQ %rbx, -8(%rbp)
.L4:
	MOVQ -8(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
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
	MOVQ $0, %r10
	CMPQ %r10, %rbx
	JE .L8
	MOVQ $0, %rbx
	JMP .L9
.L8:
	MOVQ $1, %rbx
.L9:
	CMPQ $0, %rbx
	JE .L6
	MOVQ $0, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
	JMP .L7
.L6:
.L7:
	MOVQ -8(%rbp), %rbx
	SUBQ $1, -8(%rbp)
	JMP .L4
.L5:
	MOVQ $1, %rbx
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
