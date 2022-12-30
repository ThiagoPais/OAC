.data
letra_A: 	.string "A"
letra_Z: 	.string "Z"
letra_a: 	.string "a"
letra_z: 	.string "z"
numero_0: 	.string "0"
numero_9: 	.string "9"
nl:		.string "\n"
menu:		.string "Opcoes:\n\n1- Ler String\n2- Caixa Alta\n3- Caixa Baixa\n4- Tamanho da String\n5- Numero de Letras na String\n6- Numero de digitos na String\n7- Concatenar frase na String\n8- Imprimir String\n9- Encerrar Programa\n"
enter:		.string "\nPressione enter para continuar\n"
trash:		.space 12
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

main:

	li a7, 4
	la a0, enter
	ecall
	
	li a7, 8
	li a1, 12
	la a0, trash
	ecall
	
	la a0, menu
	li a7, 4
	ecall

	li a7, 5
	ecall
	mv t0, a0
	la a0, str
	
	auipc t1, 0
	addi t1, t1, 12
	slli t2, t0, 3
	add t1, t1, t2
	jalr t1
	jal read
	j main
	jal upper_case
	j main
	jal lower_case
	j main
	jal size
	j print_num
	jal count_char
	j print_num
	jal count_dig
	j print_num
	jal concat
	j main
	jal print
	j main
	jal end

read:
	li a7, 8
	li a1, 32
	la a0, str
	ecall

	ret
	
upper_case:
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

	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret	

print:
	li a7, 4
	la a0, str
	ecall
	
	j main
	
print_num:
	li a7, 1
	ecall
	
	j main

end:
	li a7, 10
	ecall
