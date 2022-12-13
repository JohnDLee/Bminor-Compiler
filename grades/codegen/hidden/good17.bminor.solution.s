.data

.global a1
a1:
.data

.global a2
a2:
	.quad 111
.data

.global a3
a3:
	.quad 0
.text

.global A
A:
	pushq %rbp
	movq  %rsp, %rbp
	subq $8,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq a3,%rbx
	cmp $0, %rbx
	jz .L1
	movq a1,%rbx
	movq a2,%r10
	mov %rbx, %rax
	imul %r10
	mov %rax, %r10
	movq %r10,%rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp .L2
.L1:
.L2:
	movq $3,%rbx
	movq %rbx, -8(%rbp)
	movq a3,%rbx
	not %rbx
	not %rbx
	not %rbx
	cmp $0, %rbx
	jz .L3
	movq a1,%rbx
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
	jmp .L4
.L3:
.L4:
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
	pushq %r10
	pushq %r11
	call A
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
