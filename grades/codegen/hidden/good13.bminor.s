.text
.globl foo_epilogue
foo_epilogue:
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
	MOVQ $2, %rbx
	MOVQ %rbx, %rax
	JMP .foo_epilogue_epilogue
.foo_epilogue_epilogue:
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
.globl foo
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
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL foo
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $11, %r10
	MOVQ %rbx, %rax
	IMULQ %r10
	MOVQ %rax, %r10
	MOVQ %r10, %rax
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
.globl main_epilogue
main_epilogue:
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
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL foo_epilogue
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $3, %r10
	ADDQ %r10, %rbx
	MOVQ %rbx, %rax
	JMP .main_epilogue_epilogue
.main_epilogue_epilogue:
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
.globl foo
foo:
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
	MOVQ $0, %rax
	PUSHQ %r10
	PUSHQ %r11
	CALL main_epilogue
	POPQ %r11
	POPQ %r10
	MOVQ %rax, %rbx
	MOVQ $1, %r10
	SUBQ %r10, %rbx
	MOVQ %rbx, %rax
	JMP .foo_epilogue
.foo_epilogue:
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
