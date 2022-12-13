.data

.global x
x:
	.quad 1
.data

.global y
y:
	.quad 10
.data

.global w
w:
	.quad 1
.data

.global z
z:
	.string "compilers\n"
.data

.global b
b:
	.quad 1
	.quad 2
	.quad 3
.text

.global main
main:
	pushq %rbp
	movq  %rsp, %rbp
	subq $0,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $0,%rbx
	movq %rbx,%rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq  %rbp, %rsp
	popq %rbp
	ret
