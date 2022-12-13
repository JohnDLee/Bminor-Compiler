.data

.global y
y:
	.quad 1
	.quad 1
	.quad 1
	.quad 1
	.quad 1
.text

.global main
main:
	pushq %rbp
	movq  %rsp, %rbp
	subq $16,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
