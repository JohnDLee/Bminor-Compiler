.data

.global a
a:
	.quad 0
	.quad 0
	.quad 0
	.quad 0
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
	movq $60,%rbx
	leaq a, %r10
	movq $2,%r11
	leaq (%r10,%r11,8), %r11
	mov %rbx, (%r11)
	leaq a,%rbx
	movq $2,%r10
	mov (%rbx,%r10,8), %r11
	leaq a,%rbx
	movq $2,%r10
	mov (%rbx,%r10,8), %r12
	movq $20,%rbx
	mov %r12, %rax
	cqo
	idiv %rbx
	mov %rax, %rbx
	movq $3,%r10
	mov %rbx, %rax
	imul %r10
	mov %rax, %r10
	add %r11, %r10
	leaq a,%rbx
	movq $1,%r11
	mov (%rbx,%r11,8), %r12
	sub %r12, %r10
	movq %r10,%rax
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
