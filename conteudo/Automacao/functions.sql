CREATE OR REPLACE FUNCTION FaturamentoDentistaMes(p_id_dentista INT, p_mes INT, p_ano INT)
RETURNS NUMERIC AS $$
DECLARE total NUMERIC;
BEGIN
    SELECT SUM(pag.valor_pago) INTO total
    FROM pagamento pag
    JOIN consulta c ON pag.id_consulta = c.id
    JOIN agendamento a ON c.id_agendamento = a.id
    WHERE a.id_dentista = p_id_dentista
      AND EXTRACT(MONTH FROM c.data_realizacao) = p_mes
      AND EXTRACT(YEAR FROM c.data_realizacao) = p_ano;
    RETURN COALESCE(total,0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION IdadePaciente(p_id INT)
RETURNS INT AS $$
DECLARE idade INT;
BEGIN
    SELECT EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nasc)) INTO idade
    FROM paciente WHERE id = p_id;
    RETURN idade;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ContarConsultasPaciente(p_id INT)
RETURNS INT AS $$
DECLARE total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM consulta c
    JOIN agendamento a ON c.id_agendamento = a.id
    WHERE a.id_paciente = p_id;
    RETURN total;
END;
$$ LANGUAGE plpgsql;
