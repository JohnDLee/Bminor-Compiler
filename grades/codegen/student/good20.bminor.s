.text
.globl fb
.text
.globl main
main:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	SUBQ $8, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ $0, %rbx
	MOVQ %rbx, -8(%rbp)
	MOVQ $0, %rbx
	MOVQ %rbx, -8(%rbp)
.L0:
	MOVQ -8(%rbp), %rbx
	MOVQ $100, %r10
	CMPQ %r10, %rbx
	JL .L2
	MOVQ $0, %rbx
	JMP .L3
.L2:
	MOVQ $1, %rbx
.L3:
	CMPQ $0, %rbx
	JE .L1
	MOVQ -8(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_integer
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $32, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_character
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ -8(%rbp), %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL fb
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_string
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $10, %rbx
	MOVQ %rbx, %rdi
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL print_character
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ -8(%rbp), %rbx
	ADDQ $1, -8(%rbp)
	JMP .L0
.L1:
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
.globl fb
fb:
	PUSHQ %rbp
	MOVQ %rsp, %rbp
	PUSHQ %rdi
	SUBQ $8, %rsp
	PUSHQ %rbx
	PUSHQ %r10
	PUSHQ %r11
	PUSHQ %r12
	PUSHQ %r13
	PUSHQ %r14
	PUSHQ %r15
	MOVQ -8(%rbp), %rbx
	MOVQ $3, %r10
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r10
	MOVQ %rdx, %r10
	MOVQ $0, %rbx
	CMPQ %rbx, %r10
	JE .L6
	MOVQ $0, %r10
	JMP .L7
.L6:
	MOVQ $1, %r10
.L7:
	MOVQ -8(%rbp), %rbx
	MOVQ $5, %r11
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r11
	MOVQ %rdx, %r11
	MOVQ $0, %rbx
	CMPQ %rbx, %r11
	JE .L8
	MOVQ $0, %r11
	JMP .L9
.L8:
	MOVQ $1, %r11
.L9:
	ANDQ %r11, %r10
	CMPQ $0, %r10
	JE .L4
.data
.SL10:
	.string	"fizzbuzz"
.text
	LEAQ .SL10, %rbx
	MOVQ %rbx, %rax
	JMP .fb_epilogue
	JMP .L5
.L4:
	MOVQ -8(%rbp), %rbx
	MOVQ $5, %r10
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r10
	MOVQ %rdx, %r10
	MOVQ $0, %rbx
	CMPQ %rbx, %r10
	JE .L13
	MOVQ $0, %r10
	JMP .L14
.L13:
	MOVQ $1, %r10
.L14:
	CMPQ $0, %r10
	JE .L11
.data
.SL15:
	.string	"buzz"
.text
	LEAQ .SL15, %rbx
	MOVQ %rbx, %rax
	JMP .fb_epilogue
	JMP .L12
.L11:
	MOVQ -8(%rbp), %rbx
	MOVQ $3, %r10
	MOVQ %rbx, %rax
	CQO
	IDIVQ %r10
	MOVQ %rdx, %r10
	MOVQ $0, %rbx
	CMPQ %rbx, %r10
	JE .L18
	MOVQ $0, %r10
	JMP .L19
.L18:
	MOVQ $1, %r10
.L19:
	CMPQ $0, %r10
	JE .L16
.data
.SL20:
	.string	"fizz"
.text
	LEAQ .SL20, %rbx
	MOVQ %rbx, %rax
	JMP .fb_epilogue
	JMP .L17
.L16:
.data
.SL21:
	.string	"PLUS"
.text
	LEAQ .SL21, %rbx
	MOVQ %rbx, %rax
	JMP .fb_epilogue
.L17:
.L12:
.L5:
.fb_epilogue:
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
