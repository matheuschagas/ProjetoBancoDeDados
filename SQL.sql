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

