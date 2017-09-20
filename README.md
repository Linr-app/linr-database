# linr-database

Este repositorio contem a descrição do banco de dados do Linr, assim como
as migrações e testes unitários.

## Build

Para rodar a aplicação, é necessário Python 3.6.

Espera-se que o banco de dados tenha a seguinte configuração:

```
Banco de dados: linr_db
    Schema: linr_sc
        Tabelas de produção
    Schema: linr_test
        Espaço para realizar testes
```

