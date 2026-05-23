CREATE OR REPLACE PROCEDURE AgendarConsulta(
    p_id_paciente INT,
    p_id_dentista INT,
    p_data_hora TIMESTAMP
)
LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM agendamento 
        WHERE id_dentista = p_id_dentista AND data_hora = p_data_hora
    ) THEN
        RAISE EXCEPTION 'Horário já ocupado para este dentista';
    END IF;

    INSERT INTO agendamento (id, id_paciente, id_dentista, data_hora, status)
    VALUES (DEFAULT, p_id_paciente, p_id_dentista, p_data_hora, 'Agendado');
END;
$$;

CREATE OR REPLACE PROCEDURE FinalizarAtendimento(
    p_id_consulta INT,
    p_resumo VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE consulta SET resumo_clinico = p_resumo WHERE id = p_id_consulta;
    UPDATE agendamento SET status = 'Concluído' 
    WHERE id = (SELECT id_agendamento FROM consulta WHERE id = p_id_consulta);
END;
$$;

CREATE OR REPLACE PROCEDURE AtualizarProntuario(
    p_id_paciente INT,
    p_observacao VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO anamnese (id, id_paciente, id_doenca, data_registro, observacao)
    VALUES (DEFAULT, p_id_paciente, 1, CURRENT_DATE, p_observacao);
END;
$$;
