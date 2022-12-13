.global fb
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
	movq $0,%rbx
	mov %rbx, -8(%rbp)
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
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_integer
	popq %r11
	popq %r10
	movq $32,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_character
	popq %r11
	popq %r10
	movq -8(%rbp),%rbx
	mov %rbx, %rdi
	pushq %r10
	pushq %r11
	call fb
	popq %r11
	popq %r10
	movq %rax, %rbx
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
.text

.global fb
fb:
	pushq %rbp
	movq  %rsp, %rbp
	pushq %rdi
	subq $8,%rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq -8(%rbp),%rbx
	movq $3,%r10
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
	movq -8(%rbp),%r10
	movq $5,%r11
	mov %r10, %rax
	cqo
	idiv %r11
	mov %rdx, %r11
	movq $0,%r10
	cmp %r10, %r11
	je .L9
	mov $0, %r10
	jmp .L10
.L9:
	mov $1, %r10
.L10:
	and %rbx, %r10
	cmp $0, %r10
	jz .L5
.data
.S0:	.string "fizzbuzz"
.text
	leaq .S0,%rbx
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
	movq -8(%rbp),%rbx
	movq $5,%r10
	mov %rbx, %rax
	cqo
	idiv %r10
	mov %rdx, %r10
	movq $0,%rbx
	cmp %rbx, %r10
	je .L13
	mov $0, %rbx
	jmp .L14
.L13:
	mov $1, %rbx
.L14:
	cmp $0, %rbx
	jz .L11
.data
.S1:	.string "buzz"
.text
	leaq .S1,%rbx
	movq %rbx,%rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp .L12
.L11:
	movq -8(%rbp),%rbx
	movq $3,%r10
	mov %rbx, %rax
	cqo
	idiv %r10
	mov %rdx, %r10
	movq $0,%rbx
	cmp %rbx, %r10
	je .L17
	mov $0, %rbx
	jmp .L18
.L17:
	mov $1, %rbx
.L18:
	cmp $0, %rbx
	jz .L15
.data
.S2:	.string "fizz"
.text
	leaq .S2,%rbx
	movq %rbx,%rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp .L16
.L15:
.data
.S3:	.string "PLUS"
.text
	leaq .S3,%rbx
	movq %rbx,%rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
.L16:
.L12:
.L6:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	movq  %rbp, %rsp
	popq %rbp
	ret
