-- Academicos: Franco Fiorini, Kim Schaurich, Matheus Marrane

-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------
CREATE TABLE Produto (
  idProduto INTEGER PRIMARY KEY,
  nomeProduto VARCHAR(45) NOT NULL,
  preco NUMBER(38,2) NOT NULL,
  tipoProduto VARCHAR(45) NULL
   );
---- Inserção de dados de exemplo
INSERT INTO "PRODUTO" (IDPRODUTO, NOMEPRODUTO, PRECO, TIPOPRODUTO) VALUES ('1', 'Tenis da nike', '200', 'Moda');
INSERT INTO "PRODUTO" (IDPRODUTO, NOMEPRODUTO, PRECO, TIPOPRODUTO) VALUES ('2', 'Tenis da Adidas', '200', 'Moda');
INSERT INTO "PRODUTO" (IDPRODUTO, NOMEPRODUTO, PRECO, TIPOPRODUTO) VALUES ('3', 'Vanish', '20', 'Limpeza');
INSERT INTO "PRODUTO" (IDPRODUTO, NOMEPRODUTO, PRECO, TIPOPRODUTO) VALUES ('4', 'Detergente ipe', '2,3', 'Limpeza');
INSERT INTO "PRODUTO" (IDPRODUTO, NOMEPRODUTO, PRECO, TIPOPRODUTO) VALUES ('5', 'Detergente X', '2,4', 'Limpeza');
INSERT INTO "PRODUTO" (IDPRODUTO, NOMEPRODUTO, PRECO, TIPOPRODUTO) VALUES ('6', 'Celular samsung', '1500', 'Eletronicos');
INSERT INTO "PRODUTO" (IDPRODUTO, NOMEPRODUTO, PRECO, TIPOPRODUTO) VALUES ('7', 'Iphone 7', '4500', 'Eletronicos');
INSERT INTO "PRODUTO" (IDPRODUTO, NOMEPRODUTO, PRECO, TIPOPRODUTO) VALUES ('8', 'Iphone 5s', '1500,33', 'Eletronicos');

-- -----------------------------------------------------
-- Table TipoCliente
-- -----------------------------------------------------
CREATE TABLE TipoCliente (
  idTipoCliente INTEGER PRIMARY KEY,
  TipoCliente VARCHAR(45) NOT NULL
   );
---- Inserção de dados de exemplo
Insert into TIPOCLIENTE (IDTIPOCLIENTE,TIPOCLIENTE) values ('1','Vip');
Insert into TIPOCLIENTE (IDTIPOCLIENTE,TIPOCLIENTE) values ('2','Superior');
Insert into TIPOCLIENTE (IDTIPOCLIENTE,TIPOCLIENTE) values ('3','Regular');

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE Cliente (
  idCliente INTEGER PRIMARY KEY,
  nome VARCHAR(30) NOT NULL,
  endereco VARCHAR(100) NULL,
  telefone VARCHAR(15) NULL,
  limiteDeCredito NUMBER(38, 2) NOT NULL,
  TipoCliente_idTipoCliente INT NOT NULL,
    FOREIGN KEY (TipoCliente_idTipoCliente)
    REFERENCES TipoCliente (idTipoCliente)
    );
---- Inserção de dados de exemplo
Insert into CLIENTE (IDCLIENTE,NOME,ENDERECO,TELEFONE,LIMITEDECREDITO,TIPOCLIENTE_IDTIPOCLIENTE) values ('1','Matheus Marrane','Rua 234','(51)9850-5401','10000,02','1');
Insert into CLIENTE (IDCLIENTE,NOME,ENDERECO,TELEFONE,LIMITEDECREDITO,TIPOCLIENTE_IDTIPOCLIENTE) values ('2','Kim','Rua 1234','(51) 3456-9582','5000,5','2');
Insert into CLIENTE (IDCLIENTE,NOME,ENDERECO,TELEFONE,LIMITEDECREDITO,TIPOCLIENTE_IDTIPOCLIENTE) values ('3','Franco','Av. fef','(51) 3659-8463','568,3','3');

-- -----------------------------------------------------
-- Table Pedido
-- -----------------------------------------------------
CREATE TABLE Pedido (
  idPedido INTEGER PRIMARY KEY,
  Cliente_idCliente INT NOT NULL,
  data DATE NOT NULL,
  Produto_idProduto INT NOT NULL,
  quantidade INT NOT NULL,
  valorTotal NUMBER(38, 2) NOT NULL,
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto),
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente)
    );
    ---- Inserção de dados de exemplo
INSERT INTO "PEDIDO" (IDPEDIDO, CLIENTE_IDCLIENTE, DATA, PRODUTO_IDPRODUTO, QUANTIDADE, VALORTOTAL) VALUES ('1', '1', TO_DATE('2016-10-15 01:01:55', 'YYYY-MM-DD HH24:MI:SS'), '1', '10', '2000')


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
	, tc.tipoCliente 
FROM Cliente c 
	INNER JOIN TipoCliente tc
		ON tc.idTipoCliente = c.TipoCliente_idTipoCliente
			AND c.nome LIKE '%a%';
      
---- Busca Produto
SELECT idProduto
	, nomeProduto
	, preco
	, tipoProduto
FROM Produto
	WHERE nomeProduto LIKE '%a%';




-- Operação 3
INSERT INTO "PEDIDO" (IDPEDIDO, CLIENTE_IDCLIENTE, DATA, PRODUTO_IDPRODUTO, QUANTIDADE, VALORTOTAL) 
VALUES ('2', '2', TO_DATE('2016-10-15 01:01:55', 'YYYY-MM-DD HH24:MI:SS'), '2', '10', '2000');

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
ORDER BY pe.data ASC;

-- Operação 5
SELECT p.nomeProduto
	, count(pe.idPedido) as qtdPedidos
	, sum(pe.quantidade) as qtdTotal
	, sum(pe.valorTotal) as totalVendido
	, (sum(pe.quantidade)*(SELECT preco FROM Produto WHERE idProduto = p.idProduto)) - sum(pe.valorTotal) as desconto
FROM Produto p
	LEFT JOIN Pedido pe
		ON pe.Produto_idProduto = p.idProduto
GROUP BY p.idProduto, p.nomeProduto;

-- Operação 6
SELECT c.nome
	, count(pe.idPedido) as numPedidos
	, sum(pe.valorTotal) as valorTotal
FROM Cliente c
	INNER JOIN Pedido pe
		ON pe.Cliente_idCliente = c.idCliente
	GROUP BY c.idCliente, c.nome
	ORDER BY valorTotal DESC;

-- Operação 7
-- Selecionar clientes vips que possuem pelo menos um pedido

SELECT c.NOME
        FROM CLIENTE c
WHERE c.TIPOCLIENTE_IDTIPOCLIENTE = 1 AND
EXISTS (SELECT * FROM PEDIDO p WHERE p.CLIENTE_IDCLIENTE = c.IDCLIENTE)
