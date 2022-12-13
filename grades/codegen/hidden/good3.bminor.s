.data
.SL0:
	.quad 2
	.quad 1
	.quad 1
	.quad 2
	.quad 1
	.quad 2
	.quad 0
	.quad 3
.globl T
T:
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
	MOVQ $0, %rbx
	MOVQ %rbx, -8(%rbp)
.L1:
	MOVQ T, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ $0, %r10
	CMPQ %r10, %rbx
	JE .L5
	MOVQ $0, %rbx
	JMP .L6
.L5:
	MOVQ $1, %rbx
.L6:
	CMPQ $0, %rbx
	JE .L3
	MOVQ T, %rbx
	MOVQ $5, %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ $10, %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
	JMP .L4
.L3:
	MOVQ T, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ $1, %r10
	CMPQ %r10, %rbx
	JE .L9
	MOVQ $0, %rbx
	JMP .L10
.L9:
	MOVQ $1, %rbx
.L10:
	CMPQ $0, %rbx
	JE .L7
	MOVQ -8(%rbp), %rbx
	ADDQ $1, -8(%rbp)
	JMP .L8
.L7:
	MOVQ T, %rbx
	MOVQ -8(%rbp), %r10
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ $2, %r10
	CMPQ %r10, %rbx
	JE .L13
	MOVQ $0, %rbx
	JMP .L14
.L13:
	MOVQ $1, %rbx
.L14:
	CMPQ $0, %rbx
	JE .L11
	MOVQ T, %rbx
	MOVQ -8(%rbp), %r10
	ADDQ $1, -8(%rbp)
	MOVQ (%rbx,%r10,8), %rbx
	MOVQ T, %r10
	MOVQ -8(%rbp), %r11
	ADDQ $1, -8(%rbp)
	SUBQ $1, (%r10,%r11,8)
	JMP .L12
.L11:
	MOVQ $1, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
.L12:
.L8:
.L4:
	JMP .L1
.L2:
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
