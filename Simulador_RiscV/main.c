/*
Universidade de Brasília
Organização e Arquitetura de Computadores
Professor: Ricardo Jacobi
Turma: C
2022/2

Aluno: Thiago Cardoso Pinheiro Dias Pais
Matrícula: 16/0146372

Data: 09/12/2022

Trabalho 2
*/

#include <stdio.h>
#include <stdint.h>
#include "globals.h"
#include "memory.h"

#define CODE_FILE_NAME "code.bin"
#define DATA_FILE_NAME "data.bin"


const uint32_t DATA_SEGMENT_START = 0X2000;
const uint32_t CODE_SEGMENT_START = 0X00;

int main(){

    load_mem(CODE_FILE_NAME, DATA_FILE_NAME);
    /*
    fetch();
    printf("intruction = %X\n", ri);
    decode();
    printf("opcode = %X\nfunct3 = %X\nfunct7 = %X\n", opcode, funct3, funct7);
    printf("rd = %X\nimm30 = %X\n", rd, imm20_u);
    printf("instruct = %d\n", get_instr_code(opcode, funct3, funct7));
    switch (get_instr_code(opcode, funct3, funct7))
    {
    case I_auipc:
        printf("Imm = %X\n", get_imm32(get_i_format(opcode, funct3, funct7)));
        f_auipc();
        printf("breg[%d] = %X\n", rd, breg[rd]);
        printf("mem[breg[%X]] = %X\n", rd, lw(breg[rd],0));
        printf("mem[0x2000] = %X\n", lw(0x2000,0));
        printf("mem[0x2004] = %X\n", lw(0x2004,0));
        break;
    
    default:
        break;
    }*/
    run();

    return 0;
}

//0000 0000 0000 0000 0010 0010 1001 0111

/*
FILE *code;
    uint32_t entry, data_pointer = 0x2000;

    code = fopen("code.bin", "rb");

    for(int i=0; i<10; i++){
        fread(&entry, sizeof(entry), 1, code);

        printf("Codigo encontrado: %X\n", entry);
    }

    fseek(code, sizeof(entry)*5, SEEK_SET);

    for(int i=0; i<10; i++){
        fread(&entry, sizeof(entry), 1, code);

        printf("Codigo encontrado: %X\n", entry);
    }

    fclose(code);

    printf("testes bib: %X", get_byte_0(entry));
    printf("testes bib: %X", get_byte_1(entry));
    printf("testes bib: %X", get_byte_2(entry));
    printf("testes bib: %X", get_byte_3(entry));
*/