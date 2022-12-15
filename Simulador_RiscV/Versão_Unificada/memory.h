/*
Universidade de Brasília
Organização e Arquitetura de Computadores
Professor: Ricardo Jacobi
Turma: C
2022/2

Aluno: Thiago Cardoso Pinheiro Dias Pais
Matrícula: 16/0146372

Data: 13/11/2022

Trabalho 1
*/

#ifndef MEMORY_H
#define MEMORY_H


#include <stdio.h>
#include <stdint.h>

#define MEM_SIZE 4096
extern int32_t mem[MEM_SIZE];


int32_t lw(uint32_t address, int32_t kte);

int32_t lb(uint32_t address, int32_t kte);

int32_t lh(uint32_t address, int32_t kte);

int32_t lbu(uint32_t address, int32_t kte);

void sw(uint32_t address, int32_t kte, int32_t dado);

void sb(uint32_t address, int32_t kte, int8_t dado);

void sh(uint32_t address, int32_t kte, int8_t dado);


int32_t lw(uint32_t address, int32_t kte){

	if ((address+kte)%4 != 0 || (address+kte)/4 > MEM_SIZE){
		//printf("Endereço (%d, %d) inválido!\nFavor fornecer um endereço válido.\n", address, kte);
		return 0;
	}

	//printf("%08X\n\n", mem[(address+kte)/4]);

	return mem[(address+kte)/4];
}

int32_t lb(uint32_t address, int32_t kte){

	if ((address+kte)/4 > MEM_SIZE){
		//printf("Endereço (%d, %d) inválido!\nFavor fornecer um endereço válido.\n", address, kte);
		return 0;
	}
	
	char *pos = (char*)mem;

	//printf("%08X\n\n", (int32_t)pos[(address+kte)]);

	return (int32_t)pos[(address+kte)];
}

int32_t lh(uint32_t address, int32_t kte){

	if ((address+kte)/4 > MEM_SIZE){
		//printf("Endereço (%d, %d) inválido!\nFavor fornecer um endereço válido.\n", address, kte);
		return 0;
	}
	
	int16_t *pos = (int16_t*)mem;

	//printf("%08X\n\n", (int32_t)pos[(address+kte)]);

	return (int32_t)pos[(address+kte)];
}

int32_t lbu(uint32_t address, int32_t kte){


    if ((address+kte)/4 > MEM_SIZE){
		//printf("Endereço (%d, %d) inválido!\nFavor fornecer um endereço válido.\n", address, kte);
		return 0;
	}
	
	char *pos = (char*)mem;
	int32_t aux = (int32_t)pos[(address+kte)];
	
	if(aux < 0){
		aux = 0xffffffff - aux;
		aux = 0xff - aux; // operação para zerar primeiros bits
		//aux = aux & 0x00000011; // máscara de dados
	}

	//printf("%08X\n\n", aux);

	return aux;
}

void sw(uint32_t address, int32_t kte, int32_t dado){

	if ((address+kte)%4 != 0 || (address+kte)/4 > MEM_SIZE){
		//printf("Endereço (%d, %d) inválido!\nFavor fornecer um endereço válido.\n", address, kte);
		return;
	}

	mem[(address+kte)/4] = dado;

	return;
}

void sb(uint32_t address, int32_t kte, int8_t dado){

    if ((address+kte)/4 > MEM_SIZE){
		//printf("Endereço (%d, %d) inválido!\nFavor fornecer um endereço válido.\n", address, kte);
		return;
	}
	
	char *pos = (char*)mem;

	pos[(address+kte)] = dado;

	return;
}

void sh(uint32_t address, int32_t kte, int8_t dado){

    if (((address+kte)%4 != 0 && (address+kte)%4 != 2) || (address+kte)/4 > MEM_SIZE){
		//printf("Endereço (%d, %d) inválido!\nFavor fornecer um endereço válido.\n", address, kte);
		return;
	}

	int16_t *pos = (int16_t*)mem;

	pos[(address+kte)] = dado;

	return;
}

#endif //MEMORY_H