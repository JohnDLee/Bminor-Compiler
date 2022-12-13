.text

.global D
D:
	pushq %rbp
	movq  %rsp, %rbp
	subq $64,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $5,%rbx
	movq %rbx, -8(%rbp)
	movq -8(%rbp),%rbx
	movq $1,%r10
	add %rbx, %r10
	movq %r10, -16(%rbp)
	movq $9,%rbx
	movq %rbx, -24(%rbp)
	movq -24(%rbp),%rbx
	movq -8(%rbp),%r10
	add %rbx, %r10
	movq $3,%rbx
	sub %rbx, %r10
	movq %r10, -32(%rbp)
	movq $1,%rbx
	neg %rbx
	movq %rbx, -40(%rbp)
	movq -32(%rbp),%rbx
	movq -24(%rbp),%r10
	add %rbx, %r10
	mov %r10, -32(%rbp)
	movq -32(%rbp),%rbx
	movq -40(%rbp),%r10
	sub %r10, %rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
.data
.S0:	.string "\n"
.text
	leaq .S0,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $16,%rbx
	movq %rbx, -48(%rbp)
	movq -16(%rbp),%rbx
	movq -48(%rbp),%r10
	sub %r10, %rbx
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
	movq $2,%rbx
	neg %rbx
	movq %rbx, -56(%rbp)
	movq $1000,%rbx
	movq %rbx, -64(%rbp)
	movq -64(%rbp),%rbx
	movq $10,%r10
	add %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_integer
	popq %r11
	popq %r10
.data
.S1:	.string "\n"
.text
	leaq .S1,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq -56(%rbp),%rbx
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
	movq -48(%rbp),%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
	movq $3,%rbx
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
	call D
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
