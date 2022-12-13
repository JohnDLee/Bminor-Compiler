.text

.global collatz
collatz:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rdi
	pushq %rsi
	subq $0,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
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
	movq -8(%rbp),%rbx
	movq $1,%r10
	cmp %r10, %rbx
	je .L3
	mov $0, %rbx
	jmp .L4
.L3:
	mov $1, %rbx
.L4:
	cmp $0, %rbx
	jz .L1
	movq -16(%rbp),%rbx
	movq %rbx,%rax
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
	movq -8(%rbp),%rbx
	movq $2,%r10
	mov %rbx, %rax
	cqo
	idiv %r10
	mov %rdx, %r10
	movq $0,%rbx
	cmp %rbx, %r10
	je .L7
	mov $0, %rbx
	jmp .L8
.L7:
	mov $1, %rbx
.L8:
	cmp $0, %rbx
	jz .L5
	movq -8(%rbp),%rbx
	movq $2,%r10
	mov %rbx, %rax
	cqo
	idiv %r10
	mov %rax, %r10
	movq -16(%rbp),%rbx
	movq $1,%r11
	add %rbx, %r11
	mov %r10, %rdi
	mov %r11, %rsi
	pushq %r10
	pushq %r11
	call collatz
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
	jmp .L6
.L5:
	movq $3,%rbx
	movq -8(%rbp),%r10
	mov %rbx, %rax
	imul %r10
	mov %rax, %r10
	movq $1,%rbx
	add %r10, %rbx
	movq -16(%rbp),%r10
	movq $1,%r11
	add %r10, %r11
	mov %rbx, %rdi
	mov %r11, %rsi
	pushq %r10
	pushq %r11
	call collatz
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
.L6:
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
	movq $27,%rbx
	movq $0,%r10
	mov %rbx, %rdi
	mov %r10, %rsi
	pushq %r10
	pushq %r11
	call collatz
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
