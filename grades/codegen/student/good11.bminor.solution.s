.data

.global arr
arr:
	.quad 1
	.quad 2
	.quad 3
.data

.global s
s:
	.string "string\n"
.text

.global main
main:
	pushq %rbp
	movq  %rsp, %rbp
	subq $40,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
