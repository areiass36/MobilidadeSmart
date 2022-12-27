--1. Aluno que fez o maior numero de corridas
SELECT Nome, COUNT(DISTINCT CorridaId) as Corridas FROM Aluno
INNER JOIN CorridaAluno CA on Aluno.Numero = CA.NumeroAluno
GROUP BY Nome
HAVING COUNT(DISTINCT CorridaId) >= All (SELECT COUNT(DISTINCT CorridaId) as Corridas FROM CorridaAluno
                                                                                      GROUP BY NumeroAluno);

--2. Aluno que fez o maior numero de corridas como motorista
SELECT A.Nome, COUNT(DISTINCT CorridaId) as Corridas FROM Aluno A
INNER JOIN CorridaAluno CA on A.Numero = CA.NumeroAluno
INNER JOIN TipoAlunoCorrida T on CA.Tipo = T.Id
GROUP BY A.Nome, T.Nome
HAVING T.Nome = 'Motorista' AND COUNT(DISTINCT CorridaId) >= All (SELECT COUNT(DISTINCT CorridaId) as Corridas FROM CorridaAluno C
                                                                                      INNER JOIN TipoAlunoCorrida TAC on C.Tipo = TAC.Id
                                                                                      GROUP BY NumeroAluno, TAC.Nome
                                                                                      HAVING TAC.Nome = 'Motorista');

--3. Zona que teve o maior tempo de espera
SELECT Zona.Nome, DATEDIFF(MINUTE ,InicioEspera, FimEspera) as MinutosEspera FROM Zona
INNER JOIN FilaEspera FE on Zona.Id = FE.ZonaId
WHERE DATEDIFF(MINUTE ,InicioEspera, FimEspera) >= ALL (SELECT DATEDIFF(MINUTE ,InicioEspera, FimEspera) FROM FilaEspera)

--4. Categoria de veiculo mais esperada
SELECT CV.Nome, DATEDIFF(MINUTE ,InicioEspera, FimEspera) as MinutosEspera FROM CategoriaVeiculo CV
INNER JOIN FilaEspera FE on FE.CategoriaVeiculo = CV.Id
WHERE DATEDIFF(MINUTE ,InicioEspera, FimEspera) >= ALL (SELECT DATEDIFF(MINUTE ,InicioEspera, FimEspera) FROM FilaEspera)

--5. Modelo de veiculo mais utilizado nas corridas
SELECT VM.Nome,CV.Nome as Categoria, COUNT(V.Id) as Corridas FROM Corrida
INNER JOIN Veiculo V on Corrida.VeiculoId = V.Id
INNER JOIN VeiculoModelo VM on VM.Id = V.ModeloId
INNER JOIN CategoriaVeiculo CV on CV.Id = VM.CategoriaVeiculo
GROUP BY VM.Nome, CV.Nome
HAVING COUNT(V.Id) >= ALL (SELECT COUNT(V.ModeloId) FROM Corrida
                                INNER JOIN Veiculo V on Corrida.VeiculoId = V.Id
                                GROUP BY ModeloId)

--6. Três modelos mais frequentes na frota de veiculos
SELECT TOP 3 VM.Nome as Modelo,COUNT(V.Id) FROM Veiculo V
INNER JOIN VeiculoModelo VM on VM.Id = V.ModeloId
GROUP BY V.ModeloId, VM.Nome
ORDER BY COUNT(V.Id) DESC

--7. Alunos presentes na última corrida finalizada
SELECT A.Nome FROM Aluno A
INNER JOIN CorridaAluno CA on A.Numero = CA.NumeroAluno
INNER JOIN Corrida C on CA.CorridaId = C.Id
WHERE C.DataFim = (SELECT MAX(DataFim) FROM Corrida C)

--8. Cor mais utilizada na fronta de veiculos
SELECT C.Nome, COUNT(V.Id) as Veiculos FROM Cor C
INNER JOIN Veiculo V on C.Id = V.CorId
GROUP BY C.Nome
HAVING COUNT(V.Id) >= ALL (SELECT COUNT(V.Id) FROM Veiculo V
                            INNER JOIN Cor C on C.Id = V.CorId
                            GROUP BY C.Id)

--9. Zona de destino mais utilizada pelo aluno "Patten"
SELECT Z.Nome, COUNT(C.Id) FROM Zona Z
INNER JOIN Corrida C on Z.Id = C.ZonaFim
INNER JOIN CorridaAluno CA on C.Id = CA.CorridaId
INNER JOIN Aluno A on A.Numero = CA.NumeroAluno
GROUP BY C.ZonaFim, Z.Nome, A.Nome
HAVING A.Nome = 'Patten' AND COUNT(C.Id) >= ALL (SELECT COUNT(C.Id) FROM Corrida C
                                                INNER JOIN CorridaAluno CA on C.Id = CA.CorridaId
                                                INNER JOIN Aluno A on A.Numero = CA.NumeroAluno
                                                GROUP BY C.ZonaFim, A.Nome
                                                HAVING A.Nome = 'Patten')

--10. Zona de inicio mais utilizada pelo aluno "Patten" e "Carree"
SELECT A.Nome as Aluno, Z.Nome as Zona, COUNT(C.Id) FROM Zona Z
INNER JOIN Corrida C on Z.Id = C.ZonaInicio
INNER JOIN CorridaAluno CA on C.Id = CA.CorridaId
INNER JOIN Aluno A on A.Numero = CA.NumeroAluno
GROUP BY C.ZonaInicio, Z.Nome, A.Nome
HAVING A.Nome = 'Patten' AND COUNT(C.Id) >= ALL (SELECT COUNT(C.Id) FROM Corrida C
                                                INNER JOIN CorridaAluno CA on C.Id = CA.CorridaId
                                                INNER JOIN Aluno A on A.Numero = CA.NumeroAluno
                                                GROUP BY C.ZonaInicio, A.Nome
                                                HAVING A.Nome = 'Patten')
UNION

SELECT A.Nome as Aluno, Z.Nome as Zona, COUNT(C.Id) FROM Zona Z
INNER JOIN Corrida C on Z.Id = C.ZonaInicio
INNER JOIN CorridaAluno CA on C.Id = CA.CorridaId
INNER JOIN Aluno A on A.Numero = CA.NumeroAluno
GROUP BY C.ZonaInicio, Z.Nome, A.Nome
HAVING A.Nome = 'Carree' AND COUNT(C.Id) >= ALL (SELECT COUNT(C.Id) FROM Corrida C
                                                INNER JOIN CorridaAluno CA on C.Id = CA.CorridaId
                                                INNER JOIN Aluno A on A.Numero = CA.NumeroAluno
                                                GROUP BY C.ZonaInicio, A.Nome
                                                HAVING A.Nome = 'Carree');

