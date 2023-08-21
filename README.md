# Desafio programação

"O teste consiste em criar uma interface web que aceite upload do arquivo CNAB, faça um parse nos dados e armazene-os em um banco de dados relacional e exiba essas informações em tela."

## Descrição do projeto

A aplicação aceita o upload de arquivos CNAB.txt para serem parseados e salvos em um banco de dados e exibindo-os em tabelas.

## INSTALAÇÃO

  Para instalação é necessário:
- Ruby v2.7.3
- Rails 6.1.7.4
- PostgreSQL

## Subir o projeto

Para as dependências do projeto certifique de estar na pasta do projeto rode o comando

bundle install
yarn install
rake db:create
rake db:migrate
rails s

em seguida 
Acesse a aplicação em http://localhost:3000/

Importe o arquivo cnab.txt e confira as transações e o saldo
de acordo com o menu

=====================================================================
