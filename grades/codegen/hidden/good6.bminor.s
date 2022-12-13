.text
.globl f
f:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	SUBQ $0, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ -8(%rbp), %rbx
	CMPQ $0, %rbx
	JE .L0
	MOVQ $0, %rbx
	JMP .L1
.L0:
	MOVQ $1, %rbx
.L1:
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
.data
.globl x
x:
	.quad 4
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
	MOVQ $10, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ x, %rbx
	MOVQ -8(%rbp), %r10
	CMPQ %r10, %rbx
	JLE .L4
	MOVQ $0, %rbx
	JMP .L5
.L4:
	MOVQ $1, %rbx
.L5:
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	CMPQ $0, %rbx
	JE .L2
	MOVQ $1, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
	JMP .L3
.L2:
	MOVQ x, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ x, %r11
	MOVQ -8(%rbp), %r12
	MOVQ %r11, %rax
	IMULQ %r12
	MOVQ %rax, %r12
	SUBQ %r12, %r10
	CMPQ %r10, %rbx
	JL .L8
	MOVQ $0, %rbx
	JMP .L9
.L8:
	MOVQ $1, %rbx
.L9:
	CMPQ $0, %rbx
	JE .L6
	MOVQ $4, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
	JMP .L7
.L6:
	MOVQ $2, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
.L7:
.L3:
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
