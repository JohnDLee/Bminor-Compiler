.text
.globl strlen
.text
.globl f
.text
.globl main
main:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $0, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
.data
.SL2:
	.string	"hi"
.text
	LEAQ .SL2, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL strlen
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL3:
	.string	"there"
.text
	LEAQ .SL3, %r10
	MOVQ %r10, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL strlen
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %r10
	CMPQ %r10, %rbx
	JG .L4
	MOVQ $0, %rbx
	JMP .L5
.L4:
	MOVQ $1, %rbx
.L5:
	CMPQ $0, %rbx
	JE .L0
.data
.SL6:
	.string	"no\n"
.text
	LEAQ .SL6, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	JMP .L1
.L0:
.L1:
.data
.SL9:
	.string	"hi"
.text
	LEAQ .SL9, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL strlen
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL f
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
.data
.SL10:
	.string	"there"
.text
	LEAQ .SL10, %r10
	MOVQ %r10, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL strlen
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %r10
	CMPQ %r10, %rbx
	JG .L11
	MOVQ $0, %rbx
	JMP .L12
.L11:
	MOVQ $1, %rbx
.L12:
	CMPQ $0, %rbx
	JE .L7
.data
.SL13:
	.string	"ok\n"
.text
	LEAQ .SL13, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	JMP .L8
.L7:
.L8:
	MOVQ $0, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue
.main_epilogue:
	POPQ %r15
	POPQ %r14
	POPQ %r13
	POPQ %r12
	POPQ %r11
	POPQ %r10
	POPQ %rbx
	MOVQ %rbp, %rsp
	POPQ %rbp
	RET
.text
.globl f
f:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	SUBQ $0, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ -8(%rbp), %rbx
	MOVQ $2, %r10
	MOVQ %rbx, %rax
	IMULQ %r10
	MOVQ %rax, %r10
	MOVQ %r10, %rax
	JMP .f_epilogue
.f_epilogue:
	POPQ %r15
	POPQ %r14
	POPQ %r13
	POPQ %r12
	POPQ %r11
	POPQ %r10
	POPQ %rbx
	MOVQ %rbp, %rsp
	POPQ %rbp
	RET
