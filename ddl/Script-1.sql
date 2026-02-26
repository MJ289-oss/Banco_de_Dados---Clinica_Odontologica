--script primeira parte:

create database clinica_odontologica;

create table paciente (
    id int not null,
    nome varchar(100) not null,
    cpf char(11) not null,
    data_nasc date,
    tel varchar(15),
    email varchar(50),
    constraint pk_id_paciente primary key (id),
)

create table funcionario (
    id int not null,
    nome varchar(100) not null,
    cpf char(11) not null,
    cargo varchar(30) not null,
    salario decimal(10,2) not null,
    login varchar(20),
    senha varchar(20),
    constraint pk_id_funcionario primary key (id)
)

create table especialidade (
    id int not null,
    nome_especialidade varchar(50) not null,
    constraint pk_id_especialidade primary key (id)
)

create table dentista (
    id int not null,
    cro varchar(15) not null,
    constraint pk_id_dentista primary key (id),
)


-- script Parte 2: Atendimento e Saúde

create table doenca (
    id int not null,
    nome_doenca varchar(100) not null,
    descricao varchar(100) not null,
    constraint pk_id_doenca primary key (id)
)

create table anamnese (
    id int not null,
    data_registro date not null,
    observacao text
    constraint pk_id_anamnese primary key (id)
)

create table agendamento (
    id int not null,
    data_hora timestamp not null,
    status varchar(100) not null,
    constraint pk_id_agendamento primary key (id)
)

create table consulta (
    id int not null,
    data_realizacao timestamp not null,
    resumo_clinico varchar(200) not null,
    constraint pk_id_consulta primary key (id)
)

    
--script terceira parte:

create table procedimento (
    id int not null,
    nome varchar(50) not null,
    descricao_tecnica text not null,
    constraint pk_id_procedimento primary key (id)
)

create table historico_preco (
    id int not null,
    id_procedimento int not null,
    valor decimal(6,2) not null,
    data_inicio date not null,
    data_fim date,
    constraint pk_id_historico_preco primary key (id),
    constraint fk_historico_procedimento foreign key (id_procedimento) references procedimento(id)
)

create table convenio (
    id int not null,
    nome_empresa varchar(20) not null,
    cnpj varchar(14) not null,
    registro_ans varchar(6) not null,
    constraint pk_id_convenio primary key (id)
)

create table pagamento (
    id int not null,
    id_consulta int not null,
    id_forma_pagamento int not null,
    valor_pago decimal(6,2) not null,
    constraint pk_id_pagamento primary key (id)
    constraint fk_pagamento_consulta foreign key (id_consulta) references consulta(id),
    constraint fk_pagamento_forma foreign key (id_forma_pagamento) references forma_pagamento(id)
)

create table forma_pagamento (
    id int not null,
    descricao varchar(20) not null,
    constraint pk_id_forma_pagamento primary key (id)
)

-- quarta parte --

create table sala (
    id int not null,
    numero varchar(20),
    tipo varchar(100),
    constraint pk_id_sala primary key (id)
)

create table equipamento (
    id int not null,
    nome varchar(100),
    ultima_manutencao date,
    constraint pk_id_equipamento primary key (id)
)

create table fornecedor (
    id int not null,
    nome_fantasia varchar(150),
    cnpj varchar(20),
    telefone varchar(20),
    constraint pk_id_fornecedor primary key (id)
)

create table estoque (
    id int not null,
    nome_material varchar(100),
    qtd_atual int,
    qtd_min int,
    constraint pk_id_item primary key (id)
)

create table movimentacao_estoque (
    id int not null,
    tipo_mov varchar(50),
    quantidade int,
    constraint pk_id_mov primary key (id)
)
