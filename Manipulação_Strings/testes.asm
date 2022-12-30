.data
letra_A: 	.string "A"
letra_Z: 	.string "Z"
letra_a: 	.string "a"
letra_z: 	.string "z"
numero_0: 	.string "0"
numero_9: 	.string "9"
nl:		.string "\n"
str:		.space 64


.text
# definição de constantes
	la t0, letra_A
	lb s0, 0(t0)
	addi s0, s0, -1
	la t0, letra_Z
	lb s1, 0(t0)
	addi s1, s1, 1
	la t0, letra_a
	lb s2, 0(t0)
	addi s2, s2, -1
	la t0, letra_z
	lb s3, 0(t0)
	addi s3, s3, 1
	sub s4, s2, s0
	la t0, nl
	lb s5, 0(t0)
	la t0, numero_0
	lb s6, 0(t0)
	#addi s6, s6, -1
	la t0, numero_9
	lb s7, 0(t0)
	#addi s7, s7, 1




read:
	li a7, 8
	li a1, 32
	la a0, str
	ecall

	jal size

	j end

upper_case: #caixaAlta(string_adress)
	sub a2, zero, s4
	lb t0, 0(a0)
	beq t0, s5, main
	beq t0, zero, main
	blt t0, s2, save
	blt t0, s3, change_case
	j save

lower_case:
	mv a2, s4
	lb t0, 0(a0)
	beq t0, s5, main
	beq t0, zero, main
	blt t0, s0, save
	blt t0, s2, change_case
	j save
save:
	sb t0, 0(a0)
	addi a0, a0, 1
	beq a2, s4, lower_case
	j upper_case
change_case:
	add t0, t0, a2
	j save

		
size:
	la a0, str
	addi sp, sp, -4
	sw ra, 0(sp)
	li t1, 0
	
	lb t0, 0(a0)
	beq t0, s5, end_count
	beq t0, zero, end_count
	addi a0, a0, 1
	li t2, 1
	addi sp, sp, -4
	sw t2, 0(sp)
	jal size
	lw t3, 0(sp)
	addi sp, sp, 4
	add t1, t1, t3
	j end_count
	
count_char:
	addi sp, sp, -4
	sw ra, 0(sp)
	li t1, 0
	
	lb t0, 0(a0)
	beq t0, s5, end_count
	beq t0, zero, end_count # A-s0, Z-s1, a-s2, z-s3
	addi a0, a0, 1
	blt t0, s0, skip
	bgt t0, s3, skip
count:
	li t2, 1
	j next_char
skip:
	li t2, 0

next_char:
	addi sp, sp, -4
	sw t2, 0(sp)
	jal count_char
	lw t3, 0(sp)
	addi sp, sp, 4
	add t1, t1, t3
	j end_count
	
count_dig:
	addi sp, sp, -4
	sw ra, 0(sp)
	li t1, 0
	
	lb t0, 0(a0)
	beq t0, s5, end_count
	beq t0, zero, end_count # A-s0, Z-s1, a-s2, z-s3
	addi a0, a0, 1
	blt t0, s6, skip2
	bgt t0, s7, skip2
count2:
	li t2, 1
	j next_char2
skip2:
	li t2, 0

next_char2:
	addi sp, sp, -4
	sw t2, 0(sp)
	jal count_dig
	lw t3, 0(sp)
	addi sp, sp, 4
	add t1, t1, t3
	j end_count
	
end_count:
	mv a0, t1
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

concat:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal size
	la t0, str
	add a0, t0, a0
	li a1, 32
	li a7, 8
	ecall
	la a0, str
	li a7, 4
	ecall
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

end:
	li a7, 10
	ecall