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
	movq $20,%rbx
	movq %rbx, -8(%rbp)
	movq -8(%rbp),%rbx
	movq %rbx, -16(%rbp)
	movq $10,%rbx
	movq %rbx, -24(%rbp)
	movq -16(%rbp),%rbx
	movq -24(%rbp),%r10
	add %rbx, %r10
	mov %r10, -16(%rbp)
	movq -16(%rbp),%rbx
	movq -8(%rbp),%r10
	add %rbx, %r10
	mov %r10, -16(%rbp)
	movq $2,%rbx
	movq %rbx, -32(%rbp)
	movq -16(%rbp),%rbx
	movq -32(%rbp),%r10
	add %rbx, %r10
	mov %r10, -16(%rbp)
	movq -16(%rbp),%rbx
	movq -8(%rbp),%r10
	add %rbx, %r10
	mov %r10, -16(%rbp)
	movq $3,%rbx
	movq %rbx, -40(%rbp)
	movq -16(%rbp),%rbx
	movq -40(%rbp),%r10
	add %rbx, %r10
	mov %r10, -16(%rbp)
	movq -16(%rbp),%rbx
	movq -8(%rbp),%r10
	add %rbx, %r10
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
