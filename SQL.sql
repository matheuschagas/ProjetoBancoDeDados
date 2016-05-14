-- -----------------------------------------------------
-- Tabela Funcionario
-- -----------------------------------------------------
CREATE TABLE Funcionario (
  id_Funcionario INT PRIMARY KEY,
  senha VARCHAR(45) NOT NULL,
  nome_completo VARCHAR(100) NOT NULL,
  data_nascimento DATE NOT NULL,
  data_admissao DATE NOT NULL,
  sexo VARCHAR(1) NOT NULL,
  endereco1 VARCHAR(50) NOT NULL,
  endereco2 VARCHAR(50) NULL,
  salario_mensal NUMBER NOT NULL);


-- -----------------------------------------------------
-- Tabela TipoEquipamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Equipamentos`.`TipoEquipamento` (
  `id_TipoEquipamento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_TipoEquipamento`));


-- -----------------------------------------------------
-- Tabela Equipamento
-- -----------------------------------------------------
CREATE TABLE Equipamento (
  id_Equipamento INT PRIMARY KEY,
  id_TipoEquipamento INT,
  data_aquisicao DATE,
  descricao Varchar(100) NOT NULL,
  custo_diaria Number(2) NOT NULL,
  em_manutencao Number(1,0) NOT NULL,
  FOREIGN KEY (id_TipoEquipamento) REFERENCES TipoEquipamento (id_TipoEquipamento)
);


-- -----------------------------------------------------
-- Tabela Reserva
-- -----------------------------------------------------
CREATE TABLE Reserva (
  id_Reserva INT PRIMARY KEY,
  id_Funcionario INT NOT NULL,
  id_Equipamento INT NOT NULL,
  data_inicial DATE NOT NULL,
  data_final DATE NOT NULL,
  FOREIGN KEY (id_Funcionario) REFERENCES Funcionario (id_Funcionario),
  FOREIGN KEY (id_Equipamento) REFERENCES Equipamento (id_Equipamento)
);

-- -----------------------------------------------------
-- Inserção de dados
-- ----------------------------------------------------

INSERT INTO Funcionario(id_Funcionario, senha, nome_completo, data_nascimento, data_admissao, sexo, endereco1, endereco2, salario_mensal) VALUES(1, '123', 'Douglas Terra', '01/02/1960', '01/02/2006', 'M', 'Rua Paranaue, 738', 'Porto Alegre - RS', 1050.02);
INSERT INTO Funcionario(id_Funcionario, senha, nome_completo, data_nascimento, data_admissao, sexo, endereco1, endereco2, salario_mensal) VALUES(2, '123', 'Lucas Terra', '01/02/1960', '01/02/2006', 'M', 'Av do Forte, 738', 'Porto Alegre - RS', 1050.02);
INSERT INTO Funcionario(id_Funcionario, senha, nome_completo, data_nascimento, data_admissao, sexo, endereco1, endereco2, salario_mensal) VALUES(3, '123', 'Fernanda Paes', '01/02/1960', '01/02/2006', 'F', 'Av Ipiranga, 738', 'Porto Alegre - RS', 2050.02);
INSERT INTO Funcionario(id_Funcionario, senha, nome_completo, data_nascimento, data_admissao, sexo, endereco1, endereco2, salario_mensal) VALUES(4, '123', 'Davi Silva', '01/02/1960', '01/02/2006', 'M', 'Rua das Flores, 738', 'Porto Alegre - RS', 1550.02);
INSERT INTO Funcionario(id_Funcionario, senha, nome_completo, data_nascimento, data_admissao, sexo, endereco1, endereco2, salario_mensal) VALUES(5, '123', 'Leticia Sintra', '01/02/1960', '01/02/2006', 'F', 'Rua Norberto Rauch, 738', 'Porto Alegre - RS', 1053.02);

INSERT INTO TipoEquipamento(ID_TIPOEQUIPAMENTO, NOME) VALUES(1, 'Furadeiras');
INSERT INTO TipoEquipamento(ID_TIPOEQUIPAMENTO, NOME) VALUES(2, 'Esmerilhadeiras');
INSERT INTO TipoEquipamento(ID_TIPOEQUIPAMENTO, NOME) VALUES(3, 'Martelos');

INSERT INTO Equipamento(ID_EQUIPAMENTO, ID_TIPOEQUIPAMENTO, DESCRICAO, DATA_AQUISICAO, CUSTO_DIARIA, EM_MANUTENCAO) VALUES(1, 1, 'Furadeira / Parafusadeira Elétrica 280W 110V', '01/02/2015', 20.50, 1);
INSERT INTO Equipamento(ID_EQUIPAMENTO, ID_TIPOEQUIPAMENTO, DESCRICAO, DATA_AQUISICAO, CUSTO_DIARIA, EM_MANUTENCAO) VALUES(2, 1, 'Furadeira de Impacto com Mandril de 1/2 Pol 680 W 110 V', '01/02/2015', 20.50, 0);
INSERT INTO Equipamento(ID_EQUIPAMENTO, ID_TIPOEQUIPAMENTO, DESCRICAO, DATA_AQUISICAO, CUSTO_DIARIA, EM_MANUTENCAO) VALUES(3, 2, 'Esmerilhadeira Angular 4.1/2 Pol. 820 W 220 V', '01/02/2015', 30.50, 0);
INSERT INTO Equipamento(ID_EQUIPAMENTO, ID_TIPOEQUIPAMENTO, DESCRICAO, DATA_AQUISICAO, CUSTO_DIARIA, EM_MANUTENCAO) VALUES(4, 3, 'Martelo Anti-Retrocesso 1LB', '01/02/2015', 10.50, 0);

INSERT INTO Reserva(ID_RESERVA, ID_FUNCIONARIO, ID_EQUIPAMENTO, DATA_INICIAL, DATA_FINAL) VALUES (1, 1, 2, '10/05/2016', '13/05/2016');
INSERT INTO Reserva(ID_RESERVA, ID_FUNCIONARIO, ID_EQUIPAMENTO, DATA_INICIAL, DATA_FINAL) VALUES (2, 2, 2, '10/02/2016', '13/02/2016');
INSERT INTO Reserva(ID_RESERVA, ID_FUNCIONARIO, ID_EQUIPAMENTO, DATA_INICIAL, DATA_FINAL) VALUES (3, 3, 3, '10/05/2016', '13/05/2016');
INSERT INTO Reserva(ID_RESERVA, ID_FUNCIONARIO, ID_EQUIPAMENTO, DATA_INICIAL, DATA_FINAL) VALUES (4, 2, 2, '10/05/2016', '13/05/2016');
INSERT INTO Reserva(ID_RESERVA, ID_FUNCIONARIO, ID_EQUIPAMENTO, DATA_INICIAL, DATA_FINAL) VALUES (5, 4, 4, '10/05/2016', '13/05/2016');


    
    
-- Consulta 1
SELECT * FROM Funcionario ORDER BY nome_completo ASC;

-- Consulta 2
SELECT * FROM Funcionario WHERE nome_completo LIKE '%busca%';
SELECT * FROM Equipamento WHERE descricao LIKE '%busca%';

-- Consulta 3
INSERT INTO Reserva(id_Reserva, id_Funcionario, id_Equipamento, data_inicial, data_final) VALUES(1, 1, 1, '01/01/2016', '10/01/2016');

-- Consulta 4
SELECT fun.nome_completo, eqp.descricao, rsr.data_inicial, rsr.data_final 
FROM Reserva rsr INNER JOIN Funcionario fun ON rsr.id_Funcionario = fun.id_Funcionario
INNER JOIN Equipamento eqp ON rsr.id_Equipamento = eqp.id_Equipamento AND rsr.data_inicial > CURRENT_DATE;

-- Consulta 5
SELECT Equipamento.descricao, count(Reserva.id_Reserva), sum(Equipamento.custo_diaria) FROM Equipamento LEFT JOIN Reserva ON Reserva.id_Equipamento = Equipamento.id_Equipamento GROUP BY Equipamento.descricao;

-- Consulta 6
SELECT fun.nome_completo as nomeFuncionario, count(rsr.id_Reserva), sum(eqp.custo_diaria) as custoTotal
FROM Funcionario fun INNER JOIN Reserva rsr ON rsr.id_Funcionario = fun.id_Funcionario
INNER JOIN Equipamento eqp ON rsr.id_Equipamento = eqp.id_Equipamento
GROUP BY fun.nome_completo ORDER BY custoTotal DESC;
 
