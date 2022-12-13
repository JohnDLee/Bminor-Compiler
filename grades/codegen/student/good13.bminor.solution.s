.global f
.text

.global t
t:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rdi
	pushq %rsi
	pushq %rdx
	pushq %rcx
	subq $0,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq -24(%rbp),%rbx
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
	subq $32,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $10,%rbx
	movq %rbx, -8(%rbp)
	movq $0,%rbx
	movq %rbx, -16(%rbp)
	movq $99,%rbx
	movq %rbx, -24(%rbp)
.data
.S0:	.string "string"
.text
	leaq .S0,%rbx
	movq %rbx, -32(%rbp)
	movq -8(%rbp),%rbx
	movq -16(%rbp),%r10
	movq -8(%rbp),%r11
	movq -16(%rbp),%r12
	movq -24(%rbp),%r13
	movq -32(%rbp),%r14
	mov %r11, %rdi
	mov %r12, %rsi
	mov %r13, %rdx
	mov %r14, %rcx
	pushq %r10
	pushq %r11
	call t
	popq %r11
	popq %r10
	movq %rax, %r11
	movq -32(%rbp),%r12
	mov %rbx, %rdi
	mov %r10, %rsi
	mov %r11, %rdx
	mov %r12, %rcx
	pushq %r10
	pushq %r11
	call f
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
.text

.global f
f:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rdi
	pushq %rsi
	pushq %rdx
	pushq %rcx
	subq $8,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $10,%rbx
	movq %rbx, -40(%rbp)
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
	movq -16(%rbp),%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_boolean
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
	call print_character
	popq %r11
	popq %r10
	movq $10,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_character
	popq %r11
	popq %r10
	movq -32(%rbp),%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
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
