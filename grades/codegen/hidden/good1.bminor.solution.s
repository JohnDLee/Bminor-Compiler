.global strlen
.global f
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
.data
.S0:	.string "hi"
.text
	leaq .S0,%rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call strlen
	popq %r11
	popq %r10
	movq %rax, %rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call f
	popq %r11
	popq %r10
	movq %rax, %rbx
.data
.S1:	.string "there"
.text
	leaq .S1,%r10
	mov %r10, %rdi
	pushq %r10
	pushq %r11
	call strlen
	popq %r11
	popq %r10
	movq %rax, %r10
	cmp %r10, %rbx
	jg .L3
	mov $0, %rbx
	jmp .L4
.L3:
	mov $1, %rbx
.L4:
	cmp $0, %rbx
	jz .L1
.data
.S2:	.string "no\n"
.text
	leaq .S2,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	jmp .L2
.L1:
.L2:
.data
.S3:	.string "hi"
.text
	leaq .S3,%rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call strlen
	popq %r11
	popq %r10
	movq %rax, %rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call f
	popq %r11
	popq %r10
	movq %rax, %rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call f
	popq %r11
	popq %r10
	movq %rax, %rbx
.data
.S4:	.string "there"
.text
	leaq .S4,%r10
	mov %r10, %rdi
	pushq %r10
	pushq %r11
	call strlen
	popq %r11
	popq %r10
	movq %rax, %r10
	cmp %r10, %rbx
	jg .L7
	mov $0, %rbx
	jmp .L8
.L7:
	mov $1, %rbx
.L8:
	cmp $0, %rbx
	jz .L5
.data
.S5:	.string "ok\n"
.text
	leaq .S5,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	jmp .L6
.L5:
.L6:
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
.text

.global f
f:
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
	movq $2,%r10
	mov %rbx, %rax
	imul %r10
	mov %rax, %r10
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
