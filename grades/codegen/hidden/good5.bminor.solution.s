.global A
.global B
.global C
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
	movq $100,%rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call B
	popq %r11
	popq %r10
	movq %rax, %rbx
	movq $1,%r10
	sub %r10, %rbx
	movq $10,%r10
	mov %rbx, %rdi
	mov %r10, %rsi
	pushq %r10
	pushq %r11
	call A
	popq %r11
	popq %r10
	movq %rax, %rbx
	cmp $0, %rbx
	jz .L1
	movq $3,%rbx
	movq %rbx, -8(%rbp)
	movq $2,%rbx
	movq $33,%r10
	mov %r10, %rdi
	pushq %r10
	pushq %r11
	call B
	popq %r11
	popq %r10
	movq %rax, %r10
	mov %rbx, %rax
	imul %r10
	mov %rax, %r10
	movq -8(%rbp),%rbx
	add %r10, %rbx
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
.data
.S0:	.string "hello"
.text
	leaq .S0,%rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call C
	popq %r11
	popq %r10
	movq %rax, %rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call B
	popq %r11
	popq %r10
	movq %rax, %rbx
	movq $3,%r10
	mov %rbx, %rax
	cqo
	idiv %r10
	mov %rdx, %r10
	movq %r10,%rax
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

.global A
A:
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
	movq -16(%rbp),%r10
	cmp %r10, %rbx
	je .L3
	mov $0, %rbx
	jmp .L4
.L3:
	mov $1, %rbx
.L4:
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

.global B
B:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rdi
	subq $0,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq -8(%rbp),%rbx
	movq $33,%r10
	cmp %r10, %rbx
	je .L7
	mov $0, %rbx
	jmp .L8
.L7:
	mov $1, %rbx
.L8:
	cmp $0, %rbx
	jz .L5
	movq $10,%rbx
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
	movq $11,%rbx
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

.global C
C:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rdi
	subq $0,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq $33,%rbx
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
