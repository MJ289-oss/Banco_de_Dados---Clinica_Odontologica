--script primeira parte:

create database clinica_odontologica;

create table paciente (
    id_paciente int not null,
    nome varchar(100) not null,
    cpf char(11) not null,
    data_nasc date,
    tel varchar(15),
    email varchar(50),
    constraint pk_id_paciente primary key (id_paciente),
)

create table funcionario (
    id_funcionario int not null,
    nome varchar(100) not null,
    cpf char(11) not null,
    cargo varchar(30) not null,
    salario decimal(10,2) not null,
    login varchar(20),
    senha varchar(20),
    constraint pk_id_funcionario primary key (id_funcionario)
)

create table especialidade (
    id_especialidade int not null,
    nome_especialidade varchar(50) not null,
    constraint pk_id_especialidade primary key (id_especialidade)
)

create table dentista (
    id_dentista int not null,
    cro varchar(15) not null,
    constraint pk_id_dentista primary key (id_dentista),
)


-- script Parte 2: Atendimento e Saúde

create table doenca (
    id_doenca int not null,
    nome_doenca varchar(100) not null,
    descricao text,
    constraint pk_id_doenca primary key (id_doenca)
);

create table anamnese (
    id_anamnese int not null,
    id_paciente int not null,
    id_doenca int not null,
    data_registro date not null,
    observacao text,
    constraint pk_id_anamnese primary key (id_anamnese)
);

create table agendamento (
    id_agendamento int not null,
    id_paciente int not null,
    id_dentista int not null,
    data_hora timestamp not null,
    status varchar(30) not null,
    constraint pk_id_agendamento primary key (id_agendamento)
);

create table consulta (
    id_consulta int not null,
    id_agendamento int not null,
    data_realizacao timestamp not null,
    resumo_clinico text,
    constraint pk_id_consulta primary key (id_consulta)
);

--script terceira parte:

create table procedimento (
id_procedimento int not null,
nome varchar(50) not null,
descricao_tecnica varchar(100) not null,
constraint pk_id_procedimento primary key (id_procedimento)
)

create table historico_preco (
id_historico int not null,
valor decimal(5,2) not null,
data_inicio date not null,
data_fim date,
constraint pk_id_historico_preco primary key (id_historico)
)

create table convenio (
id_convenio int not null,
nome_empresa varchar(20) not null,
cnpj varchar(14) not null,
registro_ans varchar(6) not null,
constraint pk_id_convenio primary key (id_convenio)
)

create table pagamento (
id_pagamento int not null,
valor_pago decimal(5,2) not null,
constraint pk_id_pagamento primary key (id_pagamento)
)

create table forma_pagamento (
id_forma_pagamento int not null,
descricao varchar(20) not null,
constraint pk_id_forma_pagamento primary key (id_forma_pagamento)
)

-- quarta parte --

create table sala (
    id_sala int not null,
    numero varchar(20),
    tipo varchar(100),
    constraint pk_id_sala primary key (id_sala)
)

create table equipamento (
    id_equipamento int not null,
    id_sala int,
    nome varchar(100),
    ultima_manutencao date,
    constraint pk_id_equipamento primary key (id_equipamento)
)

create table fornecedor (
    id_fornecedor int not null,
    nome_fantasia varchar(150),
    cnpj varchar(20),
    telefone varchar(20),
    constraint pk_id_fornecedor primary key (id_fornecedor)
)

create table estoque (
    id_item int not null,
    id_fornecedor int,
    nome_material varchar(100),
    qtd_atual int,
    qtd_min int,
    constraint pk_id_item primary key (id_item)
)

create table movimentacao_estoque (
    id_mov int not null,
    id_item int,
    id_funcionario int,
    tipo_mov varchar(50),
    quantidade int,
    constraint pk_id_mov primary key (id_mov)
)# Banco-de-Dados---Clinica_Odontologica
