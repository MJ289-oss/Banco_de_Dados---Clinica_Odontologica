-- 1. Pacientes e datas das consultas
SELECT p.nome, c.data_realizacao 
FROM paciente p JOIN agendamento a ON p.id = a.id_paciente JOIN consulta c ON a.id = c.id_agendamento;

-- 2. Dentistas e consultas (mesmo sem atendimentos)
SELECT f.nome, c.resumo_clinico 
FROM funcionario f JOIN dentista d ON f.id = d.id_funcionario LEFT JOIN agendamento a ON d.id = a.id_dentista LEFT JOIN consulta c ON a.id = c.id_agendamento;

-- 3. Paciente e Dentista por agendamento
SELECT p.nome AS paciente, f.nome AS dentista 
FROM agendamento a JOIN paciente p ON a.id_paciente = p.id JOIN dentista d ON a.id_dentista = d.id JOIN funcionario f ON d.id_funcionario = f.id;

-- 4. Procedimentos e pacientes
SELECT pr.nome, p.nome 
FROM procedimento pr JOIN historico_preco hp ON pr.id = hp.id_procedimento JOIN pagamento pag ON hp.valor = pag.valor_pago JOIN consulta c ON pag.id_consulta = c.id JOIN agendamento a ON c.id_agendamento = a.id JOIN paciente p ON a.id_paciente = p.id;

-- 5. Pacientes e seus convênios (mesmo sem convênio)
SELECT p.nome, c.nome_empresa 
FROM paciente p LEFT JOIN convenio c ON p.id_convenio = c.id;

-- 6. Detalhes da consulta e contato do paciente
SELECT c.resumo_clinico, p.tel, p.email 
FROM consulta c JOIN agendamento a ON c.id_agendamento = a.id JOIN paciente p ON a.id_paciente = p.id;

-- 7. Especialidades e Dentistas (mesmo vazias)
SELECT e.nome_especialidade, f.nome 
FROM especialidade e LEFT JOIN dentista d ON e.id = d.id_especialidade LEFT JOIN funcionario f ON d.id_funcionario = f.id;

-- 8. Nome do dentista e horário
SELECT f.nome, a.data_hora 
FROM funcionario f JOIN dentista d ON f.id = d.id_funcionario JOIN agendamento a ON d.id = a.id_dentista;

-- 9. Procedimentos e ID das consultas
SELECT p.nome, pag.id_consulta 
FROM procedimento p LEFT JOIN historico_preco hp ON p.id = hp.id_procedimento LEFT JOIN pagamento pag ON hp.valor = pag.valor_pago;

-- 10. CPF do paciente e valor pago
SELECT p.cpf, pag.valor_pago 
FROM paciente p JOIN agendamento a ON p.id = a.id_paciente JOIN consulta c ON a.id = c.id_agendamento JOIN pagamento pag ON c.id = pag.id_consulta;

-- 11. Dentista e telefone do paciente
SELECT f.nome, p.tel 
FROM dentista d JOIN funcionario f ON d.id_funcionario = f.id JOIN agendamento a ON d.id = a.id_dentista JOIN paciente p ON a.id_paciente = p.id;

-- 12. Salas e consultas (mesmo vazias)
SELECT s.numero, c.id 
FROM sala s LEFT JOIN consulta c ON s.id = c.id;



---  GROUP BY, INTERSECT, UNION


SELECT f.nome, COUNT(a.id) 
FROM dentista d JOIN funcionario f ON d.id_funcionario = f.id JOIN agendamento a ON d.id = a.id_dentista 
GROUP BY f.nome;

SELECT p.nome, SUM(pag.valor_pago) 
FROM paciente p JOIN agendamento a ON p.id = a.id_paciente JOIN consulta c ON a.id = c.id_agendamento JOIN pagamento pag ON c.id = pag.id_consulta 
GROUP BY p.nome;

SELECT e.nome_especialidade, COUNT(d.id) 
FROM especialidade e LEFT JOIN dentista d ON e.id = d.id_especialidade 
GROUP BY e.nome_especialidade;

SELECT cv.nome_empresa, SUM(pag.valor_pago) 
FROM convenio cv JOIN paciente p ON cv.id = p.id_convenio JOIN agendamento a ON p.id = a.id_paciente JOIN consulta c ON a.id = c.id_agendamento JOIN pagamento pag ON c.id = pag.id_consulta 
GROUP BY cv.nome_empresa;

SELECT nome FROM paciente 
UNION 
SELECT f.nome FROM funcionario f JOIN dentista d ON f.id = d.id_funcionario;

SELECT tel FROM paciente 
UNION ALL 
SELECT '000-000' FROM funcionario;

SELECT cpf FROM paciente 
INTERSECT 
SELECT cpf FROM funcionario;

SELECT e.nome_especialidade, AVG(pag.valor_pago) 
FROM especialidade e JOIN dentista d ON e.id = d.id_especialidade JOIN agendamento a ON d.id = a.id_dentista JOIN consulta c ON a.id = c.id_agendamento JOIN pagamento pag ON c.id = pag.id_consulta 
GROUP BY e.nome_especialidade;

SELECT p.cpf FROM paciente p JOIN agendamento a ON p.id = a.id_paciente JOIN consulta c ON a.id = c.id_agendamento 
UNION 
SELECT p.cpf FROM paciente p JOIN agendamento a ON p.id = a.id_paciente JOIN consulta c ON a.id = c.id_agendamento JOIN pagamento pag ON c.id = pag.id_consulta;
