.global abs
.data

.global digits
digits:
	.quad 14
	.quad 8
	.quad 6168
	.quad 42
	.quad 0
	.quad 74546
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
	movq $468,%rbx
	neg %rbx
	leaq digits, %r10
	movq $4,%r11
	leaq (%r10,%r11,8), %r11
	mov %rbx, (%r11)
	movq $0,%rbx
	movq %rbx, -8(%rbp)
.L1:
	leaq digits,%rbx
	movq -8(%rbp),%r10
	mov (%rbx,%r10,8), %r11
	mov %r11, %rdi
	pushq %r10
	pushq %r11
	call abs
	popq %r11
	popq %r10
	movq %rax, %rbx
	leaq digits,%r10
	movq -8(%rbp),%r11
	mov (%r10,%r11,8), %r12
	cmp %r12, %rbx
	je .L3
	mov $0, %rbx
	jmp .L4
.L3:
	mov $1, %rbx
.L4:
	cmp $0, %rbx
	jz .L2
	leaq digits,%rbx
	movq -8(%rbp),%r10
	mov (%rbx,%r10,8), %r11
	pushq %r10
	pushq %r11
	mov %r11, %rdi
	call print_integer
	popq %r11
	popq %r10
	movq -8(%rbp),%rbx
	movq $1,%r10
	add %rbx, %r10
	mov %r10, -8(%rbp)
	movq $32,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_character
	popq %r11
	popq %r10
	jmp .L1
.L2:
	movq $10,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_character
	popq %r11
	popq %r10
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
