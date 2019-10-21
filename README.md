mLabs <img src="https://avatars1.githubusercontent.com/u/29802441?s=200&v=4" alt="drawing" width="45px"/> - Teste back-end

## API de controle de estacionamento (v1.0)

[![Build Status](https://drone.geomk.com.br/api/badges/bispo/parking/status.svg)](https://drone.geomk.com.br/bispo/parking) ![standard-readme compliant](https://img.shields.io/badge/ruby-2.6.5-brightgreen.svg?style=flat-square) ![standard-readme compliant](https://img.shields.io/badge/rails-6-brightgreen.svg?style=flat-square)

## Objetivo

Testar os conhecimentos, código e a organização do candidato no desenvolvimento de uma API usando linguagem de programação ruby.

## Conteúdo do Repositório

1. [Este README](README.md).
2. Histórico de alterações e releases do sistema: [CHANGELOG.md](CHANGELOG.md).
3. [Documentação do desenvolvimento](HOWTO.md).
4. [Fontes do Projeto](/source/mlabs-parking)

## Sumário

- [Visão Geral](#vis%c3%a3o-geral)
- [Principais Funcionalidades](#principais-funcionalidades)
- [Especificações Técnicas](#especifica%c3%a7%c3%b5es-t%c3%a9cnicas)
  - [**Entrada no estacionamento**](#entrada-no-estacionamento)
  - [**Pagamento do estacionamento**](#pagamento-do-estacionamento)
  - [**Saida do estacionamento**](#saida-do-estacionamento)
- [Instalação](#instala%c3%a7%c3%a3o)
- [Configuração](#configura%c3%a7%c3%a3o)
- [Uso no desenvolvimento](#uso-no-desenvolvimento)
- [Mantenedores](#mantenedores)
- [License MIT](#license-mit)


# Visão Geral

API para controle de estacionamento

# Principais Funcionalidades

- Entra no estacionamento
- Pagamento do estacionamento
- Saída de estacionamento
- Histórico de uma dada placa

# Especificações Técnicas

**Routes**

|Prefix      |Verb  |URI Pattern              |Controller#Action  |
|------------|:----:|-------------------------|-------------------|
|            |POST  |/parking                 |parking#create     |
|parking_pay |GET   |/parking/:parking_id/pay |parking#pay        |
|parking_out |GET   |/parking/:parking_id/out |parking#out        |
|            |GET   |/parking/:plate          |parking#historic   |


**Entrada no estacionamento**
----
>  Criação do ticket de estacionamento no momento da entrada

* **URL**

  /parking

* **Method:**
  
  `POST`
  
*  **No URL Params**

* **Data Params**

  { plate: "XYZ-1234" }

* **Success Response:**
  
  * **Code:** 200
    **Content:** `{ id:1, plate: "XYZ-1234"}`


**Pagamento do estacionamento**
----
>  Liberação da saida por meio do pagamento do ticket

* **URL**

  /parking/:parking_id/pay

* **Method:**
  
  `GET`
  
*  **No URL Params**

* **Data Params**

  { id: 1 }

* **Success Response:**
  
  * **Code:** 200
    **Content:** `{ id:1, plate: "XYZ-1234", paid:true }`
 
* **Error Response:**

  * **Code:** 404 NOT FOUND
    **Content:** `{ message : "Couldn't find Parking" }`

**Saida do estacionamento**
----

>  Saida do estacionamento

* **URL**

  /parking/:parking_id/out

* **Method:**
  
  `GET`
  
*  **No URL Params**

* **Data Params**

  { id: 1 }

* **Success Response:**
  
  * **Code:** 200
    **Content:** `{ id:1, plate: "XYZ-1234", time: "15 minutes", paid:true }`
 
* **Error Response:**

  * **Code:** 402 PAYMENT REQUIRED
    **Content:** `{ message : "payment required" }`


# Instalação

# Configuração

> Environment
>
> - RAILS_ENV = development | test | production
> 

# Uso no desenvolvimento

> Levantar a aplicação em modo desenvolvimento

Clone o projeto
```
$ git clone https://github.com/bispogeomk/mlabs-parking.git
$ cd mlabs-parking
```

Rode a aplcação usando docker-compose

```bash
$ docker-compose up
```


# Mantenedores
 - Moacir Bispo - <bispo@det.ufc.br>

# License MIT

