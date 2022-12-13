.text

.global main
main:
	pushq %rbp
	movq  %rsp, %rbp
	subq $32,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $0,%rbx
	movq %rbx, -8(%rbp)
.L1:
	movq -8(%rbp),%rbx
	movq $100,%r10
	cmp %r10, %rbx
	jl .L3
	mov $0, %rbx
	jmp .L4
.L3:
	mov $1, %rbx
.L4:
	cmp $0, %rbx
	jz .L2
	movq -8(%rbp),%rbx
	movq $50,%r10
	cmp %r10, %rbx
	jl .L7
	mov $0, %rbx
	jmp .L8
.L7:
	mov $1, %rbx
.L8:
	cmp $0, %rbx
	jz .L5
	movq $0,%rbx
	movq %rbx, -16(%rbp)
	movq -8(%rbp),%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
	movq $10,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_character
	popq %r11
	popq %r10
	jmp .L6
.L5:
	movq -8(%rbp),%rbx
	movq $75,%r10
	cmp %r10, %rbx
	jl .L11
	mov $0, %rbx
	jmp .L12
.L11:
	mov $1, %rbx
.L12:
	cmp $0, %rbx
	jz .L9
	movq $0,%rbx
	movq %rbx, -24(%rbp)
	movq -8(%rbp),%rbx
	neg %rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
	movq $10,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_character
	popq %r11
	popq %r10
	jmp .L10
.L9:
	movq $0,%rbx
	movq %rbx, -32(%rbp)
	movq -32(%rbp),%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
	movq $10,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_character
	popq %r11
	popq %r10
.L10:
.L6:
	movq -8(%rbp),%rbx
	movq $80,%r10
	cmp %r10, %rbx
	je .L15
	mov $0, %rbx
	jmp .L16
.L15:
	mov $1, %rbx
.L16:
	cmp $0, %rbx
	jz .L13
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
	jmp .L14
.L13:
.L14:
	leaq -8(%rbp), %rbx
	mov (%rbx), %r10
	mov %r10, %r11
	add $1, %r10
	mov %r10, (%rbx)
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
