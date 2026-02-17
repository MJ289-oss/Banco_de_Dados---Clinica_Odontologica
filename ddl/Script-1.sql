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
