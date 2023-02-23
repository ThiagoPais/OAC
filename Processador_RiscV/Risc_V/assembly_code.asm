.data
word:	.word 0xFAFEF1F0

TAB: 	.asciz "\t"
NL: 	.asciz	"\n"
Label:	.asciz "Teste"
l_ok:	.asciz	" OK"
l_fail:	.asciz	" FAIL"

.text

	li t1, 4	# Testa ADD
	li t2, 3
	li t3, 7
	sw t1, 0(sp)
	add t4, t1, t2
	lw a1, 0(sp)
	add t3, t3, t2
	li a7, 10
	add a2, a1, t3
	ecall