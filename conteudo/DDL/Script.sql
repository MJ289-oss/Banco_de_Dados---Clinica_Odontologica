CREATE DATABASE IF NOT EXISTS clinica_odontologica;
USE clinica_odontologica;

DROP TABLE IF EXISTS movimentacao_estoque;
DROP TABLE IF EXISTS estoque;
DROP TABLE IF EXISTS equipamento;
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS consulta;
DROP TABLE IF EXISTS agendamento;
DROP TABLE IF EXISTS anamnese;
DROP TABLE IF EXISTS historico_preco;
DROP TABLE IF EXISTS dentista;
DROP TABLE IF EXISTS paciente;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS cargo;
DROP TABLE IF EXISTS fornecedor;
DROP TABLE IF EXISTS sala;
DROP TABLE IF EXISTS forma_pagamento;
DROP TABLE IF EXISTS convenio;
DROP TABLE IF EXISTS procedimento;
DROP TABLE IF EXISTS doenca;
DROP TABLE IF EXISTS especialidade;

CREATE TABLE especialidade (
    id INT NOT NULL,
    nome_especialidade VARCHAR(100) NOT NULL,
    CONSTRAINT pk_id_especialidade PRIMARY KEY (id)
);

CREATE TABLE doenca (
    id INT NOT NULL,
    nome_doenca VARCHAR(100) NOT NULL,
    descricao VARCHAR(500),
    CONSTRAINT pk_id_doenca PRIMARY KEY (id)
);

CREATE TABLE procedimento (
    id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao_tecnica VARCHAR(500),
    CONSTRAINT pk_id_procedimento PRIMARY KEY (id)
);

CREATE TABLE cargo (
    id INT NOT NULL,
    nome_cargo VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_cargo PRIMARY KEY (id)
);

CREATE TABLE convenio (
    id INT NOT NULL,
    nome_empresa VARCHAR(150) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    registro_ans VARCHAR(20) UNIQUE,
    CONSTRAINT pk_id_convenio PRIMARY KEY (id)
);

CREATE TABLE forma_pagamento (
    id INT NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_forma_pagamento PRIMARY KEY (id)
);

CREATE TABLE sala (
    id INT NOT NULL,
    numero INT NOT NULL,
    tipo VARCHAR(50),
    CONSTRAINT pk_id_sala PRIMARY KEY (id)
);

CREATE TABLE fornecedor (
    id INT NOT NULL,
    nome_fantasia VARCHAR(150) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    CONSTRAINT pk_id_fornecedor PRIMARY KEY (id)
);

CREATE TABLE funcionario (
    id INT NOT NULL,
    id_cargo INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    salario DECIMAL(10,2),
    login VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_funcionario PRIMARY KEY (id)
);

CREATE TABLE paciente (
    id INT NOT NULL,
    id_convenio INT,
    nome VARCHAR(150) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nasc DATE NOT NULL,
    tel VARCHAR(15),
    email VARCHAR(100),
    CONSTRAINT pk_id_paciente PRIMARY KEY (id),
    CONSTRAINT fk_paciente_convenio FOREIGN KEY (id_convenio) REFERENCES convenio(id)
);

CREATE TABLE dentista (
    id INT NOT NULL,
    id_funcionario INT NOT NULL,
    id_especialidade INT NOT NULL,
    cro VARCHAR(20) UNIQUE NOT NULL,
    CONSTRAINT pk_id_dentista PRIMARY KEY (id),
    CONSTRAINT fk_dentista_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id),
    CONSTRAINT fk_dentista_especialidade FOREIGN KEY (id_especialidade) REFERENCES especialidade(id)
);

CREATE TABLE historico_preco (
    id INT NOT NULL,
    id_procedimento INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    CONSTRAINT pk_id_historico PRIMARY KEY (id),
    CONSTRAINT fk_historico_procedimento FOREIGN KEY (id_procedimento) REFERENCES procedimento(id)
);

CREATE TABLE anamnese (
    id INT NOT NULL,
    id_paciente INT NOT NULL,
    id_doenca INT NOT NULL,
    data_registro DATE NOT NULL,
    observacao VARCHAR(500),
    CONSTRAINT pk_id_anamnese PRIMARY KEY (id),
    CONSTRAINT fk_anamnese_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id),
    CONSTRAINT fk_anamnese_doenca FOREIGN KEY (id_doenca) REFERENCES doenca(id)
);

CREATE TABLE agendamento (
    id INT NOT NULL,
    id_paciente INT NOT NULL,
    id_dentista INT NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    status VARCHAR(20),
    CONSTRAINT pk_id_agendamento PRIMARY KEY (id),
    CONSTRAINT fk_agendamento_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id),
    CONSTRAINT fk_agendamento_dentista FOREIGN KEY (id_dentista) REFERENCES dentista(id)
);

CREATE TABLE consulta (
    id INT NOT NULL,
    id_agendamento INT NOT NULL,
    id_anamnese INT,
    data_realizacao TIMESTAMP NOT NULL,
    resumo_clinico VARCHAR(500),
    CONSTRAINT pk_id_consulta PRIMARY KEY (id),
    CONSTRAINT fk_consulta_agendamento FOREIGN KEY (id_agendamento) REFERENCES agendamento(id),
    CONSTRAINT fk_consulta_anamnese FOREIGN KEY (id_anamnese) REFERENCES anamnese(id)
);

CREATE TABLE pagamento (
    id INT NOT NULL,
    id_consulta INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_id_pagamento PRIMARY KEY (id),
    CONSTRAINT fk_pagamento_consulta FOREIGN KEY (id_consulta) REFERENCES consulta(id),
    CONSTRAINT fk_pagamento_forma FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id)
);

CREATE TABLE equipamento (
    id INT NOT NULL,
    id_sala INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    ultima_manutencao DATE,
    CONSTRAINT pk_id_equipamento PRIMARY KEY (id),
    CONSTRAINT fk_equipamento_sala FOREIGN KEY (id_sala) REFERENCES sala(id)
);

CREATE TABLE estoque (
    id INT NOT NULL,
    id_fornecedor INT NOT NULL,
    nome_material VARCHAR(100) NOT NULL,
    qtd_atual INT,
    qtd_min INT,
    CONSTRAINT pk_id_estoque PRIMARY KEY (id),
    CONSTRAINT fk_estoque_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id)
);

CREATE TABLE movimentacao_estoque (
    id INT NOT NULL,
    id_item INT NOT NULL,
    id_funcionario INT NOT NULL,
    tipo_mov VARCHAR(20),
    quantidade INT NOT NULL,
    CONSTRAINT pk_id_movimentacao PRIMARY KEY (id),
    CONSTRAINT fk_movimentacao_item FOREIGN KEY (id_item) REFERENCES estoque(id),
    CONSTRAINT fk_movimentacao_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id)
);