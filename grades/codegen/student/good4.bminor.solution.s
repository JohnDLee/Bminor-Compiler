.data

.global x
x:
	.quad 10
.data

.global y
y:
	.quad 20
.text

.global main
main:
	pushq %rbp
	movq  %rsp, %rbp
	subq $24,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $20,%rbx
	movq %rbx, -8(%rbp)
	movq -8(%rbp),%rbx
	movq y,%r10
	add %rbx, %r10
	movq %r10, -16(%rbp)
	movq -8(%rbp),%rbx
	movq y,%r10
	sub %r10, %rbx
	movq %rbx, -24(%rbp)
	movq -16(%rbp),%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
.data
.S0:	.string " | "
.text
	leaq .S0,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $40,%rbx
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
	movq -24(%rbp),%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
.data
.S1:	.string " | "
.text
	leaq .S1,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $0,%rbx
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
