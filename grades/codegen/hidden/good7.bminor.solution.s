.text

.global f
f:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rdi
	subq $8,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $0,%rbx
	mov %rbx, -16(%rbp)
.L1:
	movq -8(%rbp),%rbx
	movq $0,%r10
	cmp %r10, %rbx
	jg .L3
	mov $0, %rbx
	jmp .L4
.L3:
	mov $1, %rbx
.L4:
	cmp $0, %rbx
	jz .L2
	movq -16(%rbp),%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
	movq -16(%rbp),%rbx
	movq $1,%r10
	add %rbx, %r10
	mov %r10, -16(%rbp)
	leaq -8(%rbp), %rbx
	mov (%rbx), %r10
	mov %r10, %r11
	sub $1, %r10
	mov %r10, (%rbx)
	jmp .L1
.L2:
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
	subq $8,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $6,%rbx
	movq %rbx, -8(%rbp)
.L5:
	movq -8(%rbp),%rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call f
	popq %r11
	popq %r10
	movq %rax, %rbx
	movq $10,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_character
	popq %r11
	popq %r10
	movq -8(%rbp),%rbx
	movq $0,%r10
	cmp %r10, %rbx
	je .L9
	mov $0, %rbx
	jmp .L10
.L9:
	mov $1, %rbx
.L10:
	cmp $0, %rbx
	jz .L7
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
	jmp .L8
.L7:
.L8:
	leaq -8(%rbp), %rbx
	mov (%rbx), %r10
	mov %r10, %r11
	sub $1, %r10
	mov %r10, (%rbx)
	jmp .L5
.L6:
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
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq  %rbp, %rsp
	popq %rbp
	ret
