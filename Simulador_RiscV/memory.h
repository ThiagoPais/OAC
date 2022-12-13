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

#endif //MEMORY_H