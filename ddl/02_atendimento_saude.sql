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
  atendimento e saúde
);
