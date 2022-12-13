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
	movq $1,%rbx
	not %rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_boolean
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
.data
.S1:	.string "false"
.text
	leaq .S1,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S2:	.string "\n"
.text
	leaq .S2,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $0,%rbx
	not %rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S3:	.string " | "
.text
	leaq .S3,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S4:	.string "true"
.text
	leaq .S4,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S5:	.string "\n"
.text
	leaq .S5,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $1,%rbx
	movq $0,%r10
	or %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S6:	.string " | "
.text
	leaq .S6,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S7:	.string "true"
.text
	leaq .S7,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S8:	.string "\n"
.text
	leaq .S8,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $0,%rbx
	movq $1,%r10
	or %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S9:	.string " | "
.text
	leaq .S9,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S10:	.string "true"
.text
	leaq .S10,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S11:	.string "\n"
.text
	leaq .S11,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $0,%rbx
	movq $0,%r10
	or %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S12:	.string " | "
.text
	leaq .S12,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S13:	.string "false"
.text
	leaq .S13,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S14:	.string "\n"
.text
	leaq .S14,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $1,%rbx
	movq $1,%r10
	or %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S15:	.string " | "
.text
	leaq .S15,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S16:	.string "true"
.text
	leaq .S16,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S17:	.string "\n"
.text
	leaq .S17,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $0,%rbx
	movq $1,%r10
	and %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S18:	.string " | "
.text
	leaq .S18,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S19:	.string "false"
.text
	leaq .S19,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S20:	.string "\n"
.text
	leaq .S20,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $0,%rbx
	movq $0,%r10
	and %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S21:	.string " | "
.text
	leaq .S21,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S22:	.string "false"
.text
	leaq .S22,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S23:	.string "\n"
.text
	leaq .S23,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $1,%rbx
	movq $1,%r10
	and %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S24:	.string " | "
.text
	leaq .S24,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S25:	.string "true"
.text
	leaq .S25,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S26:	.string "\n"
.text
	leaq .S26,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
	movq $1,%rbx
	movq $0,%r10
	and %rbx, %r10
	pushq %r10
	pushq %r11
	mov %r10, %rdi
	call print_boolean
	popq %r11
	popq %r10
.data
.S27:	.string " | "
.text
	leaq .S27,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S28:	.string "false"
.text
	leaq .S28,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
	popq %r11
	popq %r10
.data
.S29:	.string "\n"
.text
	leaq .S29,%rbx
	pushq %r10
	pushq %r11
	mov %rbx, %rdi
	call print_string
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
