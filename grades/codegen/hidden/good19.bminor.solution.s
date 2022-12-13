.data

.global c1
c1:
	.quad 1
.data

.global c3
c3:
	.quad 100
.text

.global C
C:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rdi
	pushq %rsi
	subq $24,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $11,%rbx
	movq %rbx, -24(%rbp)
	movq $12,%rbx
	movq %rbx, -32(%rbp)
	movq $13,%rbx
	movq %rbx, -40(%rbp)
	movq -8(%rbp),%rbx
	movq -16(%rbp),%r10
	add %rbx, %r10
	movq -24(%rbp),%rbx
	add %r10, %rbx
	movq -32(%rbp),%r10
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
	movq $1,%rbx
	movq $2,%r10
	mov %rbx, %rdi
	mov %r10, %rsi
	pushq %r10
	pushq %r11
	call C
	popq %r11
	popq %r10
	movq %rax, %rbx
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
