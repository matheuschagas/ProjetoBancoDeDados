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
CREATE TABLE IF NOT EXISTS `Equipamentos`.`Equipamento` (
  `id_Equipamento` INT NOT NULL AUTO_INCREMENT,
  `id_TipoEquipamento` INT NOT NULL,
  `data_aquisicao` DATE NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  `custo_diaria` FLOAT NOT NULL,
  `em_manutencao` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_Equipamento`),
  INDEX `fk_Equipamento_TipoEquipamento_idx` (`id_TipoEquipamento` ASC),
  CONSTRAINT `fk_Equipamento_TipoEquipamento`
    FOREIGN KEY (`id_TipoEquipamento`)
    REFERENCES `Equipamentos`.`TipoEquipamento` (`id_TipoEquipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Tabela `Equipamentos`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Equipamentos`.`Reserva` (
  `id_Reserva` INT NOT NULL AUTO_INCREMENT,
  `id_Funcionario` INT NOT NULL,
  `id_Equipamento` INT NOT NULL,
  `data_inicial` DATE NOT NULL,
  `data_final` DATE NOT NULL,
  `emprestimo` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_Reserva`),
  INDEX `fk_Reserva_Funcionario1_idx` (`id_Funcionario` ASC),
  INDEX `fk_Reserva_Equipamento1_idx` (`id_Equipamento` ASC),
  CONSTRAINT `fk_Reserva_Funcionario1`
    FOREIGN KEY (`id_Funcionario`)
    REFERENCES `Equipamentos`.`Funcionario` (`id_Funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Equipamento1`
    FOREIGN KEY (`id_Equipamento`)
    REFERENCES `Equipamentos`.`Equipamento` (`id_Equipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
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
 