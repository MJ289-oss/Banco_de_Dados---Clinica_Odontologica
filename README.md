# 🦷 Sistema de Banco de Dados: Clínica Odontológica

![Database SQL](https://img.shields.io/badge/Database-MySQL-blue?style=for-the-badge&logo=mysql)
![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-brightgreen?style=for-the-badge)

## 📋 Sobre o Projeto
Este projeto consiste na modelagem e implementação de um banco de dados relacional completo para a gestão de uma clínica odontológica. A estrutura foi desenhada para cobrir desde a recepção do paciente até o controle de estoque e faturamento financeiro, garantindo a integridade dos dados e a rastreabilidade das informações clínicas.

## 🏗️ Arquitetura do Sistema (4 Núcleos)

O banco de dados foi organizado em quatro pilares estratégicos para otimizar o fluxo de informações:

### 1. Núcleo de Pessoas
Gerencia o capital humano e os clientes da clínica.
* **Tabelas:** `paciente`, `funcionario`, `dentista`, `especialidade`, `convenio`.
* **Destaque:** Utiliza o conceito de especialização, onde um `dentista` é um `funcionario` com qualificações técnicas específicas.

### 2. Atendimento e Saúde
Focado na jornada clínica e segurança do paciente.
* **Tabelas:** `doenca`, `anamnese`, `agendamento`, `consulta`.
* **Destaque:** Integração obrigatória com a ficha de `anamnese` para garantir que o dentista tenha acesso ao histórico de saúde antes de cada consulta.

### 3. Financeiro e Procedimentos
Responsável pela precificação e controle de pagamentos.
* **Tabelas:** `procedimento`, `historico_preco`, `pagamento`, `forma_pagamento`.
* **Destaque:** A tabela `historico_preco` permite a alteração de valores de mercado sem perder a rastreabilidade de quanto foi cobrado em consultas passadas.

### 4. Infraestrutura e Estoque
Gestão de insumos e manutenção física.
* **Tabelas:** `sala`, `equipamento`, `fornecedor`, `estoque`, `movimentacao_estoque`.
* **Destaque:** Controle de auditoria em `movimentacao_estoque`, registrando qual funcionário realizou a entrada ou saída de materiais.

---

## 📊 Diagrama Entidade-Relacionamento (ER)

```mermaid
erDiagram
    funcionario ||--o| dentista : "especializa"
    especialidade ||--o{ dentista : "atribui"
    convenio ||--o{ paciente : "cobre"
    paciente ||--o{ anamnese : "possui"
    doenca ||--o{ anamnese : "registra"
    paciente ||--o{ agendamento : "solicita"
    dentista ||--o{ agendamento : "realiza"
    agendamento ||--|| consulta : "gera"
    anamnese ||--o{ consulta : "informa"
    procedimento ||--o{ historico_preco : "precifica"
    consulta ||--o| pagamento : "fatura"
    forma_pagamento ||--o{ pagamento : "processa"
    sala ||--o{ equipamento : "aloca"
    fornecedor ||--o{ estoque : "fornece"
    estoque ||--o{ movimentacao_estoque : "movimenta"
    funcionario ||--o{ movimentacao_estoque : "opera"
