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
	movq $4,%rbx
	movq $9,%r10
	movq $2,%r11
	neg %r11
	movq $5,%r12
	neg %r12
	sub %r12, %r11
	mov %r10, %rax
	cqo
	idiv %r11
	mov %rax, %r11
	add %rbx, %r11
	movq $2,%rbx
	movq $1,%r10
	add %rbx, %r10
	movq $4,%rbx
	mov %r10, %rax
	imul %rbx
	mov %rax, %rbx
	movq $1,%r10
	sub %r10, %rbx
	movq $3,%r10
	mov %rbx, %rax
	cqo
	idiv %r10
	mov %rdx, %r10
	movq $7,%rbx
	mov %r10, %rax
	imul %rbx
	mov %rax, %rbx
	add %r11, %rbx
	movq $2,%r10
	movq $3,%r11
	movq %r10, %rdi
	movq %r11, %rsi
	pushq %r10
	pushq %r11
	call integer_power
	popq %r11
	popq %r10
	movq %rax, %r10
	sub %r10, %rbx
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
