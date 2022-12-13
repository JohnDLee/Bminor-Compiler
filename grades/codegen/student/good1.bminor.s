.data
.globl x
x:
	.quad 1
.data
.globl y
y:
	.quad 10
.data
.globl w
w:
	.quad 1
.data
.SL0:
	.string "compilers\n"
.globl z
z:
	.quad .SL0
.data
.SL1:
	.quad 1
	.quad 2
	.quad 3
.globl b
b:
	.quad .SL1
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
