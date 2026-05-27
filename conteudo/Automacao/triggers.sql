CREATE OR REPLACE FUNCTION validar_horario()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM agendamento 
        WHERE id_dentista = NEW.id_dentista AND data_hora = NEW.data_hora
    ) THEN
        RAISE EXCEPTION 'Dentista já possui consulta neste horário';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_horario
BEFORE INSERT ON agendamento
FOR EACH ROW EXECUTE FUNCTION validar_horario();
CREATE OR REPLACE FUNCTION gerar_financeiro()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO pagamento (id, id_consulta, id_forma_pagamento, valor_pago)
    VALUES (DEFAULT, NEW.id, 1, 0); -- cria pendência
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_gerar_financeiro
AFTER INSERT ON consulta
FOR EACH ROW EXECUTE FUNCTION gerar_financeiro();
CREATE TABLE notificacoes (
    id SERIAL PRIMARY KEY,
    id_agendamento INT,
    mensagem VARCHAR(200),
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION notificar_cancelamento()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Cancelado' THEN
        INSERT INTO notificacoes (id_agendamento, mensagem)
        VALUES (NEW.id, 'Sua consulta foi cancelada');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_notificar_cancelamento
AFTER UPDATE ON agendamento
FOR EACH ROW EXECUTE FUNCTION notificar_cancelamento();