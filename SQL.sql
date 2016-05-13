-- -----------------------------------------------------
-- Banco Equipamentos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Equipamentos` DEFAULT CHARACTER SET utf8 ;
USE `Equipamentos` ;

-- -----------------------------------------------------
-- Tabela `Equipamentos`.`Funcionario`
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
-- Tabela `Equipamentos`.`TipoEquipamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Equipamentos`.`TipoEquipamento` (
  `id_TipoEquipamento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_TipoEquipamento`));


-- -----------------------------------------------------
-- Tabela `Equipamentos`.`Equipamento`
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
-- Tabela `Equipamentos`.`Reserva`
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
    
    
-- Consulta 1
SELECT * FROM Funcionario ORDER BY nome_completo ASC;

-- Consulta 2
SELECT * FROM Funcionario WHERE nome_completo LIKE '%busca%';
SELECT * FROM Equipamento WHERE descricao LIKE '%busca%';

-- Consulta 3
INSERT INTO Reserva(id_Reserva, id_Funcionario, id_Equipamento, data_inicial, data_final) VALUES(1, 1, 1, '01/01/2016', '10/01/2016');

-- Consulta 4
SELECT Funcionario.nome_completo, Equipamento.descricao, Reserva.data_inicial, Reserva.data_final 
FROM Reserva, Funcionario, Equipamento 
WHERE Reserva.id_Funcionario = Funcionario.id_Funcionario AND Reserva.id_Equipamento = Equipamento.id_Equipamento AND Reserva.data_inicial > CURRENT_DATE;

-- Consulta 5
SELECT Equipamento.descricao, count(Reserva.id_Reserva), sum(Equipamento.custo_diaria) FROM Equipamento LEFT JOIN Reserva ON Reserva.id_Equipamento = Equipamento.id_Equipamento GROUP BY Equipamento.descricao;

-- Consulta 6
SELECT Funcionario.nome_completo as funcionario, count(Reserva.id_Reserva), sum(Equipamento.custo_diaria) as custoTotal
FROM Funcionario, Reserva, Equipamento
WHERE Reserva.id_Funcionario = Funcionario.id_Funcionario AND Reserva.id_Equipamento = Equipamento.id_Equipamento GROUP BY funcionario ORDER BY custoTotal DESC;
 
