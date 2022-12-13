.data

.global y
y:
	.quad 1
	.quad 2
	.quad 3
.data

.global z
z:
	.quad 0
	.quad 0
	.quad 0
.text

.global main
main:
	pushq %rbp
	movq  %rsp, %rbp
	subq $8,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
