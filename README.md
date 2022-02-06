# Husky Challenge

Não fiz grandes alterações na estrutura, criei models para usuarios e tokens.

Achei que era interessante os invoices estarem associados a um usuario, sem depender do campo "invoice_from" já que ele é livre.

Além disso os access tokens nunca são apagados e tem campos datatime sobre quando foram aprovados, revogados e ultimo uso, também acho que são informações importantes.

Tentei deixar tudo em inglês, tanto a interface quanto o código, e seguir todas as convenções do Ruby e Rails.

Fazia tempo que eu nao precisava gerar PDF em Ruby, e depois de pesquisar um pouco sobre, achei que a gem Prawn foi perfeita para esse desafio.

A documentação da API ficou bem simples, mas a manutenção dela não seria tão ruim por que todos os exemplos de Request e Response usam uma instancia do Invoice.

Eu não tenho experiencia com cobertura de testes, mas tentei implementar cobertura completa (models, routing, requests, mailers).

## Configuração

### Dependências de ambiente

- Ruby `>= 3.1.0`
  - bundler `>= 2.3.4`
  - rails `>= 7`
- Node.js `>= 16.13.2`
  - npm `>= 8.0`
  - yarn `>= 1.22.0`
- Postgresql

### Preparando ambiente de desenvolvimento

1) Instale as dependências de ambiente.

2) Crie o arquivo `config/master.key`.

```sh
echo '2500af7274898ae80b2c62be1bbbb64f' > config/master.key

chmod 600 config/master.key
```

3) Crie o aquivo `config/database.yml` a partir do `config/database.yml.sample`.

4) Configure o arquivo `config/database.yml`.

5) Execute `bin/setup`

## Desenvolvimento

### Executando a aplicação

```sh
bin/dev
```

### Executando os testes

```sh
bin/rails spec
```
