Para compilar o arquivo, basta rodar o Makefile, se estiver no Windows.

Caso não esteja no Windows ou não possua o make instalado, é necessário compilar os arquivos "main.c", "memory.c", "riscv_func.c" e "riscv_definitions.c". Após compilar, execute o arquivo proveniente de "main.c"

Para o caso da compilação de múltiplos arquivos dê errado, compilar arquivo "riscv_func.c" na pasta "Versão_Unificada". Apenas a compilação dele é suficiente para executar o programa.

Caso queira testar o programa com outros arquivos binário proveniente do RARS sem ter que deletar os arquivos anteriores, basta alterar o nome dos arquivos lidos pelo programa nas linhas 21 e 22 do arquivo "main.c", ou nas linhas 13 e 14 do arquivo "Versão_Unificada/riscv_func.c".