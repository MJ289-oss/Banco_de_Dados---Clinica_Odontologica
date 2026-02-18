--script Parte 1:

create table paciente (
    id_paciente int not null,
    id_convenio int,
    nome varchar(100) not null,
    cpf char(11) not null,
    data_nasc date,
    tel varchar(15),
    email varchar(50),
    constraint pk_id_paciente primary key (id_paciente),
    constraint fk_paciente_convenio foreign key (id_convenio) references convenio(id_convenio)
)

create table funcionario (
    id_funcionario int not null,
    nome varchar(100) not null,
    cpf char(11) not null,
    cargo varchar(30),
    salario decimal(10,2),
    login varchar(20),
    senha varchar(100),
    constraint pk_id_funcionario primary key (id_funcionario)
)

create table especialidade (
    id_especialidade int not null,
    nome_especialidade varchar(50) not null,
    constraint pk_id_especialidade primary key (id_especialidade)
)

create table dentista (
    id_dentista int not null,
    id_funcionario int not null,
    id_especialidade int not null,
    cro varchar(15) not null,
    constraint pk_id_dentista primary key (id_dentista),
    constraint fk_dentista_funcionario foreign key (id_funcionario) references funcionario(id_funcionario),
    constraint fk_dentista_especialidade foreign key (id_especialidade) references especialidade(id_especialidade)
)

--scripts da terceira parte

create database clinica_odontologica;

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
descricao varchar(20),
constraint pk_id_forma_pagamento primary key (id_forma_pagamento)
)
