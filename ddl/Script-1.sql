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
    nome VARCHAR(150) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    cargo VARCHAR(50),
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
    data_hora DATETIME NOT NULL,
    status VARCHAR(20),
    CONSTRAINT pk_id_agendamento PRIMARY KEY (id),
    CONSTRAINT fk_agendamento_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id),
    CONSTRAINT fk_agendamento_dentista FOREIGN KEY (id_dentista) REFERENCES dentista(id)
);

CREATE TABLE consulta (
    id INT NOT NULL,
    id_agendamento INT NOT NULL,
    id_anamnese INT NOT NULL,
    data_realizacao DATETIME NOT NULL,
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

-- Tabelas Pai (3 Registros cada)
INSERT INTO especialidade VALUES (1,'Ortodontia'),(2,'Endodontia'),(3,'Implantodontia');
INSERT INTO doenca VALUES (1,'Diabetes','Tipo 2'),(2,'Hipertensão','Crônica'),(3,'Alergia','Penicilina');
INSERT INTO procedimento VALUES (1,'Limpeza','Profilaxia'),(2,'Canal','Tratamento'),(3,'Extração','Exodontia');
INSERT INTO convenio VALUES (1,'Unimed','12345678000101','ANS01'),(2,'Amil','87654321000102','ANS02'),(3,'Bradesco','55566677000103','ANS03');
INSERT INTO forma_pagamento VALUES (1,'Dinheiro'),(2,'Cartão'),(3,'Pix');
INSERT INTO sala VALUES (1,101,'Geral'),(2,102,'Cirurgia'),(3,103,'Exame');
INSERT INTO fornecedor VALUES (1,'Dental Speed','11122233000144','1140028922'),(2,'Surya Dental','44455566000177','1130304040'),(3,'3M Dental','88899900000111','1120201010');

-- Funcionário (Pai de Dentista e Movimentação) - 30 Registros
INSERT INTO funcionario (id, nome, cpf, cargo, salario, login, senha) VALUES 
(1,'Carlos Gerente','11111111101','Gerente',5500.00,'admin','123'),
(2,'Dr. Ricardo','11111111102','Dentista',8000.00,'dent01','123'),
(3,'Dra. Ana','11111111103','Dentista',8000.00,'dent02','123'),
(4,'Dr. Marcos','11111111104','Dentista',8000.00,'dent03','123'),
(5,'Dra. Julia','11111111105','Dentista',8000.00,'dent04','123'),
(6,'Dr. Pedro','11111111106','Dentista',8000.00,'dent05','123'),
(7,'Dra. Luana','11111111107','Dentista',8000.00,'dent06','123'),
(8,'Dr. Fabio','11111111108','Dentista',8000.00,'dent07','123'),
(9,'Dra. Beatriz','11111111109','Dentista',8000.00,'dent08','123'),
(10,'Dra. Simone','11111111110','Dentista',8000.00,'dent09','123'),
(11,'Dr. Andre','11111111111','Dentista',8000.00,'dent10','123'),
(12,'Dra. Fernanda','11111111112','Dentista',8000.00,'dent11','123'),
(13,'Dr. Thiago','11111111113','Dentista',8000.00,'dent12','123'),
(14,'Dra. Monica','11111111114','Dentista',8000.00,'dent13','123'),
(15,'Dr. Bruno','11111111115','Dentista',8000.00,'dent14','123'),
(16,'Dra. Tatiane','11111111116','Dentista',8000.00,'dent15','123'),
(17,'Dr. Renato','11111111117','Dentista',8000.00,'dent16','123'),
(18,'Dra. Patricia','11111111118','Dentista',8000.00,'dent17','123'),
(19,'Dr. Samuel','11111111119','Dentista',8000.00,'dent18','123'),
(20,'Dr. Igor','11111111120','Dentista',8000.00,'dent19','123'),
(21,'Dra. Aline','11111111121','Dentista',8000.00,'dent20','123'),
(22,'Dr. Wilson','11111111122','Dentista',8000.00,'dent21','123'),
(23,'Maria Faxina','11111111123','Faxineiro',1600.00,'fax01','123'),
(24,'Rosa Faxina','11111111124','Faxineiro',1600.00,'fax02','123'),
(25,'Jose Faxina','11111111125','Faxineiro',1600.00,'fax03','123'),
(26,'Luiz Faxina','11111111126','Faxineiro',1600.00,'fax04','123'),
(27,'Bia Recep','11111111127','Recepcionista',2100.00,'rec01','123'),
(28,'Mel Recep','11111111128','Recepcionista',2100.00,'rec02','123'),
(29,'Sol Recep','11111111129','Recepcionista',2100.00,'rec03','123'),
(30,'Lia Recep','11111111130','Recepcionista',2100.00,'rec04','123');

-- Dentista (Filha de Funcionario/Especialidade) - 30 Registros
INSERT INTO dentista (id, id_funcionario, id_especialidade, cro) VALUES 
(1,2,1,'CRO01'),(2,3,2,'CRO02'),(3,4,3,'CRO03'),(4,5,1,'CRO04'),(5,6,2,'CRO05'),(6,7,3,'CRO06'),
(7,8,1,'CRO07'),(8,9,2,'CRO08'),(9,10,3,'CRO09'),(10,11,1,'CRO10'),(11,12,2,'CRO11'),(12,13,3,'CRO12'),
(13,14,1,'CRO13'),(14,15,2,'CRO14'),(15,16,3,'CRO15'),(16,17,1,'CRO16'),(17,18,2,'CRO17'),(18,19,3,'CRO18'),
(19,20,1,'CRO19'),(20,21,2,'CRO20'),(21,22,3,'CRO21'),(22,2,1,'CRO22'),(23,3,2,'CRO23'),(24,4,3,'CRO24'),
(25,5,1,'CRO25'),(26,6,2,'CRO26'),(27,7,3,'CRO27'),(28,8,1,'CRO28'),(29,9,2,'CRO29'),(30,10,3,'CRO30');

-- Consulta (Filha de Agendamento/Anamnese) - 30 Registros
INSERT INTO consulta (id, id_agendamento, id_anamnese, data_realizacao, resumo_clinico) VALUES 
(1,1,1,'2024-04-01','Limpeza'),(2,2,2,'2024-04-01','Canal'),(3,3,3,'2024-04-01','Extração'),
(4,4,4,'2024-04-01','Limpeza'),(5,5,5,'2024-04-01','Canal'),(6,6,6,'2024-04-01','Extração'),
(7,7,7,'2024-04-02','Limpeza'),(8,8,8,'2024-04-02','Canal'),(9,9,9,'2024-04-02','Extração'),
(10,10,10,'2024-04-02','Limpeza'),(11,11,11,'2024-04-02','Canal'),(12,12,12,'2024-04-02','Extração'),
(13,13,13,'2024-04-03','Limpeza'),(14,14,14,'2024-04-03','Canal'),(15,15,15,'2024-04-03','Extração'),
(16,16,16,'2024-04-03','Limpeza'),(17,17,17,'2024-04-03','Canal'),(18,18,18,'2024-04-03','Extração'),
(19,19,19,'2024-04-04','Limpeza'),(20,20,20,'2024-04-04','Canal'),(21,21,21,'2024-04-04','Extração'),
(22,22,22,'2024-04-04','Limpeza'),(23,23,23,'2024-04-04','Canal'),(24,24,24,'2024-04-04','Extração'),
(25,25,25,'2024-04-05','Limpeza'),(26,26,26,'2024-04-05','Canal'),(27,27,27,'2024-04-05','Extração'),
(28,28,28,'2024-04-05','Limpeza'),(29,29,29,'2024-04-05','Canal'),(30,30,30,'2024-04-05','Extração');

-- Pagamento (Filha de Consulta/FormaPagamento) - 30 Registros
INSERT INTO pagamento (id, id_consulta, id_forma_pagamento, valor_pago) VALUES 
(1,1,1,150),(2,2,2,150),(3,3,3,150),(4,4,1,150),(5,5,2,150),(6,6,3,150),(7,7,1,150),(8,8,2,150),(9,9,3,150),(10,10,1,150),
(11,11,2,150),(12,12,3,150),(13,13,1,150),(14,14,2,150),(15,15,3,150),(16,16,1,150),(17,17,2,150),(18,18,3,150),(19,19,1,150),(20,20,2,150),
(21,21,3,150),(22,22,1,150),(23,23,2,150),(24,24,3,150),(25,25,1,150),(26,26,2,150),(27,27,3,150),(28,28,1,150),(29,29,2,150),(30,30,3,150);

-- Estoque (Filha de Fornecedor) - 30 Registros
INSERT INTO estoque (id, id_fornecedor, nome_material, qtd_atual, qtd_min) VALUES 
(1,1,'Luva P',50,10),(2,1,'Luva M',50,10),(3,1,'Luva G',50,10),(4,2,'Mascara',50,10),(5,2,'Sugador',50,10),(6,2,'Agulha',50,10),
(7,3,'Resina 1',50,10),(8,3,'Resina 2',50,10),(9,3,'Resina 3',50,10),(10,1,'Gaze',50,10),(11,1,'Touca',50,10),(12,1,'Alcool',50,10),
(13,2,'Cimento',50,10),(14,2,'Pasta',50,10),(15,2,'Broca 1',50,10),(16,3,'Broca 2',50,10),(17,3,'Matriz',50,10),(18,3,'Acido',50,10),
(19,1,'Selante',50,10),(20,1,'Cunha',50,10),(21,2,'Moldeira',50,10),(22,2,'Gesso',50,10),(23,2,'Alginato',50,10),(24,3,'Papel Art',50,10),
(25,3,'Fio Dent',50,10),(26,3,'Disco',50,10),(27,1,'Lixa',50,10),(28,1,'Espelho',50,10),(29,2,'Pinca',50,10),(30,3,'Sonda',50,10);

-- Tabelas Complementares (3 Registros cada)
INSERT INTO equipamento VALUES (1,1,'Cadeira A','2023-10-01'),(2,2,'Autoclave','2023-11-01'),(3,3,'Raio X','2024-01-01');
INSERT INTO historico_preco VALUES (1,1,150.00,'2023-01-01',NULL),(2,2,400.00,'2023-01-01',NULL),(3,3,250.00,'2023-01-01',NULL);
INSERT INTO movimentacao_estoque VALUES (1,1,1,'ENTRADA',10),(2,2,23,'ENTRADA',10),(3,3,27,'SAIDA',1);
