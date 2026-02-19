;-- Tabela de Doenças (Catálogo de patologias/condições)
CREATE TABLE doenca (
    id_doenca INT PRIMARY KEY,
    nome_doenca VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- Tabela de Anamnese (Histórico de saúde do paciente)
CREATE TABLE anamnese (
    id_anamnese INT PRIMARY KEY,
    id_paciente INT, -- Preparado para ser FK no futuro
    id_doenca INT,   -- Preparado para ser FK no futuro
    data_registro DATE NOT NULL,
    observacao TEXT
);

-- Tabela de Agendamento (Reserva do horário)
CREATE TABLE agendamento (
    id_agendamento INT PRIMARY KEY,
    id_paciente INT, -- Preparado para ser FK no futuro
    id_dentista INT, -- Preparado para ser FK no futuro
    data_hora TIMESTAMP NOT NULL,
    status VARCHAR(30) -- Ex: 'Aguardando', 'Confirmado', 'Cancelado'
);

-- Tabela de Consulta (O atendimento real que ocorreu)
CREATE TABLE consulta (
    id_consulta INT PRIMARY KEY,
    id_agendamento INT UNIQUE, -- Preparado para ser FK no futuro (UNIQUE pois 1 agendamento = 1 consulta)
    data_realizacao TIMESTAMP NOT NULL,
    resumo_clinico TEXT
);
);