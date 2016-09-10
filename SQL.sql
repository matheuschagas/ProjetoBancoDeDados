-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------
CREATE TABLE Produto (
  idProduto INTEGER PRIMARY KEY,
  nomeProduto VARCHAR(45) NOT NULL,
  preco DECIMAL(2) NOT NULL,
  tipoProduto VARCHAR(45) NULL
   );


-- -----------------------------------------------------
-- Table TipoCliente
-- -----------------------------------------------------
CREATE TABLE TipoCliente (
  idTipoCliente INTEGER PRIMARY KEY,
  TipoCliente VARCHAR(45) NOT NULL
   );


-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE Cliente (
  idCliente INTEGER PRIMARY KEY,
  nome VARCHAR(30) NOT NULL,
  endereco VARCHAR(100) NULL,
  telefone VARCHAR(15) NULL,
  limiteDeCredito DECIMAL(2) NOT NULL,
  TipoCliente_idTipoCliente INT NOT NULL,
  INDEX fk_Cliente_TipoCliente1_idx (TipoCliente_idTipoCliente ASC),
  CONSTRAINT fk_Cliente_TipoCliente1
    FOREIGN KEY (TipoCliente_idTipoCliente)
    REFERENCES TipoCliente (idTipoCliente)
    );


-- -----------------------------------------------------
-- Table `vendaProdutos`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE Pedido (
  `idPedido` INTEGER PRIMARY KEY,
  Cliente_idCliente INT NOT NULL,
  data DATE NOT NULL,
  Produto_idProduto INT NOT NULL,
  quantidade INT NOT NULL,
  valorTotal DECIMAL(2) NOT NULL,
  INDEX fk_Pedido_Produto1_idx (Produto_idProduto ASC),
  INDEX fk_Pedido_Cliente1_idx (Cliente_idCliente ASC),
  CONSTRAINT fk_Pedido_Produto1
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto),
  CONSTRAINT fk_Pedido_Cliente1
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente)
    );


-- Operação 1
SELECT idProduto
	, nomeProduto
	, preco
	, tipoProduto 
FROM Produto 
ORDER BY nomeProduto ASC;

-- Operação 2
---- Busca Cliente
SELECT c.idCliente
	, c.nome
	, c.endereco
	, c.telefone
	, c.limiteDeCredito
	, c.tipoCliente 
FROM Cliente c 
	INNER JOIN TipoCliente tc
		ON tc.idTipoCliente = c.TipoCliente_idTipoCliente
			AND c.nome LIKE '%Fulano%'; 

---- Busca Produto
SELECT idProduto
	, nomeProduto
	, preco
	, tipoProduto
FROM Produto
	WHERE nomeProduto LIKE '%Vanish%';




-- Operação 3
INSERT INTO Pedido(
			idPedido
			, Cliente_idCliente
			, data
			, Produto_idProduto
			, quantidade
			, valorTotal
		  ) VALUES (
				1
				, 1
				, '20-12-2016'
				, 1
				, 20
				, 546.65
			    )

-- Operação 4
SELECT c.nome
	, p.nomeProduto
	, pe.data
	, pe.valorTotal
FROM Cliente c
	INNER JOIN Pedido pe
		ON pe.Cliente_idCliente = c.idCliente
	INNER JOIN Produto p
		ON p.idProduto = pe.Produto_idProduto
ORDER BY pe.data ASC

-- Operação 5
SELECT p.nomeProduto
	, count(pe.idPedido) as qtdPedidos
	, sum(pe.quantidade) as qtdTotal
	, sum(pe.valorTotal) as totalVendido
	, (sum(pe.quantidade)*p.preco - sum(pe.valorTotal)) as desconto
FROM Produto p
	LEFT JOIN Pedido pe
		ON pe.Produto_idProduto = p.idProduto
	GROUP BY p.idProduto

-- Operação 6
SELECT c.nome
	, count(pe.idPedido) as numPedidos
	, sum(pe.valorTotal) as valorTotal
FROM Cliente c
	INNER JOIN Pedido pe
		ON pe.Cliente_idCliente = c.idCliente
	GROUP BY c.idCliente
	ORDER BY valorTotal DESC

-- Operação 7

