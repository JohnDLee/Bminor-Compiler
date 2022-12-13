.data

.global T
T:
	.quad 2
	.quad 1
	.quad 1
	.quad 2
	.quad 1
	.quad 2
	.quad 0
	.quad 3
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
	movq $0,%rbx
	movq %rbx, -8(%rbp)
.L1:
	leaq T,%rbx
	movq -8(%rbp),%r10
	mov (%rbx,%r10,8), %r11
	movq $0,%rbx
	cmp %rbx, %r11
	je .L5
	mov $0, %rbx
	jmp .L6
.L5:
	mov $1, %rbx
.L6:
	cmp $0, %rbx
	jz .L3
	leaq T,%rbx
	movq $5,%r10
	mov (%rbx,%r10,8), %r11
	movq $10,%rbx
	add %r11, %rbx
	movq %rbx,%rax
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
	leaq T,%rbx
	movq -8(%rbp),%r10
	mov (%rbx,%r10,8), %r11
	movq $1,%rbx
	cmp %rbx, %r11
	je .L9
	mov $0, %rbx
	jmp .L10
.L9:
	mov $1, %rbx
.L10:
	cmp $0, %rbx
	jz .L7
	leaq -8(%rbp), %rbx
	mov (%rbx), %r10
	mov %r10, %r11
	add $1, %r10
	mov %r10, (%rbx)
	jmp .L8
.L7:
	leaq T,%rbx
	movq -8(%rbp),%r10
	mov (%rbx,%r10,8), %r11
	movq $2,%rbx
	cmp %rbx, %r11
	je .L13
	mov $0, %rbx
	jmp .L14
.L13:
	mov $1, %rbx
.L14:
	cmp $0, %rbx
	jz .L11
	leaq T, %rbx
	leaq -8(%rbp), %r10
	mov (%r10), %r11
	mov %r11, %r12
	add $1, %r11
	mov %r11, (%r10)
	leaq (%rbx,%r12,8), %r12
	mov (%r12), %rbx
	mov %rbx, %r10
	sub $1, %rbx
	mov %rbx, (%r12)
	jmp .L12
.L11:
	movq $1,%rbx
	movq %rbx,%rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
.L12:
.L8:
.L4:
	jmp .L1
.L2:
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
