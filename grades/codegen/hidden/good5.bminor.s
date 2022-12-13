.text
.globl A
.text
.globl B
.text
.globl C
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
	MOVQ $100, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL B
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $1, %r10
	SUBQ %r10, %rbx
	MOVQ $10, %r10
	MOVQ %rbx, %rdi
	MOVQ %r10, %rsi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL A
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	CMPQ $0, %rbx
	JE .L0
	MOVQ $3, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ $2, %rbx
	MOVQ $33, %r10
	MOVQ %r10, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL B
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %r10
	MOVQ %rbx, %rax
	IMULQ %r10
	MOVQ %rax, %r10
	MOVQ -8(%rbp), %rbx
	ADDQ %rbx, %r10
	MOVQ %r10, %rax
	JMP .main_epilogue
	JMP .L1
.L0:
.L1:
.data
.SL2:
	.string	"hello"
.text
	LEAQ .SL2, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL C
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL B
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $3, %r10
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r10
	MOVQ %rdx, %r10
	MOVQ %r10, %rax
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
.globl A
A:
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
	MOVQ -16(%rbp), %r10
	CMPQ %r10, %rbx
	JE .L3
	MOVQ $0, %rbx
	JMP .L4
.L3:
	MOVQ $1, %rbx
.L4:
	MOVQ %rbx, %rax
	JMP .A_epilogue
.A_epilogue:
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
.globl B
B:
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
	MOVQ $33, %r10
	CMPQ %r10, %rbx
	JE .L7
	MOVQ $0, %rbx
	JMP .L8
.L7:
	MOVQ $1, %rbx
.L8:
	CMPQ $0, %rbx
	JE .L5
	MOVQ $10, %rbx
	MOVQ %rbx, %rax
	JMP .B_epilogue
	JMP .L6
.L5:
	MOVQ $11, %rbx
	MOVQ %rbx, %rax
	JMP .B_epilogue
.L6:
.B_epilogue:
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
.globl C
C:
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
	MOVQ $33, %rbx
	MOVQ %rbx, %rax
	JMP .C_epilogue
.C_epilogue:
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
