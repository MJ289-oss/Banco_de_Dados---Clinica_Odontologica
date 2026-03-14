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