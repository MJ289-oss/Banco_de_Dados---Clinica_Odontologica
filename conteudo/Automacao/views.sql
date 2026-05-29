CREATE OR REPLACE VIEW AgendaDoDia AS
SELECT a.data_hora, p.nome AS paciente, f.nome AS dentista
FROM agendamento a
JOIN paciente p ON a.id_paciente = p.id
JOIN dentista d ON a.id_dentista = d.id
JOIN funcionario f ON d.id_funcionario = f.id
WHERE a.data_hora::DATE = CURRENT_DATE;

CREATE OR REPLACE VIEW FinanceiroPorConvenio AS
SELECT cv.nome_empresa, SUM(pag.valor_pago) AS total
FROM convenio cv
JOIN paciente p ON cv.id = p.id_convenio
JOIN agendamento a ON p.id = a.id_paciente
JOIN consulta c ON a.id = c.id_agendamento
JOIN pagamento pag ON c.id = pag.id_consulta
GROUP BY cv.nome_empresa;

CREATE OR REPLACE VIEW PacientesInativos AS
SELECT p.id, p.nome
FROM paciente p
WHERE NOT EXISTS (
    SELECT 1 FROM agendamento a
    WHERE a.id_paciente = p.id
      AND a.data_hora >= CURRENT_DATE - INTERVAL '6 months'
);
