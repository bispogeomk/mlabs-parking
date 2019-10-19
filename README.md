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
- [Instalação](#instala%c3%a7%c3%a3o)
- [Configuração](#configura%c3%a7%c3%a3o)
- [Uso](#uso)
- [Mantenedores](#mantenedores)
- [License](#license)


# Visão Geral

API para controle de estacionamento

# Principais Funcionalidades

- Entra de carro
- Pagamento do ticket
- Saída de carro
- Histórico de um dado carro

# Especificações Técnicas

**Entrada no estacionamento**
----
  <_Additional information about your API call. Try to use verbs that match both request type (fetching vs modifying) and plurality (one vs multiple)._>

* **URL**

  <_The URL Structure (path only, no root url)_>

* **Method:**
  
  `POST`
  
*  **No URL Params**

* **Data Params**

  { plate: "XYZ-1234" }

* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** `{ id:1, plate: "XYZ-1234"}`
 
* **Error Response:**

  * **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:** `{ error : "Plate Invalid" `


- URL
  - /parking
- Method
  - POST
- URL Params
  - sem paremetros
- Data Params
    { plate: "FAA-1234" }
- Success Response
  - Code: 200
  - Content: { id : 1, plate : "FAA-1234" }
- Error Response
    
    PUT /parking/:id/out
    PUT /parking/:id/pay
    GET /parking/:plate

# Instalação

# Configuração

> Environment
>
> - RAILS_ENV = development | test | production
> 

# Uso

> Levantar a aplicação em modo desenvolvimento
> ```bash
> $ docker-compose up
> ```


# Mantenedores
 - Moacir Bispo - <bispo@det.ufc.br>

# License

