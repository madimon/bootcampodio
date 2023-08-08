----------------------- CRIANDO DATABASE E TABELAS -------------------------------
CREATE DATABASE desafio_dio;
USE desafio_dio;

-- Criação das tabelas
CREATE TABLE Fornecedor (
    fornecedor_id INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE Vendedor (
    vendedor_id INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(255),
    tipo VARCHAR(2)
);

CREATE TABLE Conta (
    conta_id INT PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE Produto (
    produto_id INT PRIMARY KEY,
    fornecedor_id INT,
    nome VARCHAR(255),
    estoque INT,
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

CREATE TABLE Pedido (
    pedido_id INT PRIMARY KEY,
    cliente_id INT,
    vendedor_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (vendedor_id) REFERENCES Vendedor(vendedor_id)
);

CREATE TABLE Pagamento (
    pagamento_id INT PRIMARY KEY,
    conta_id INT,
    forma_de_pagamento VARCHAR(50),
    FOREIGN KEY (conta_id) REFERENCES Conta(conta_id)
);

CREATE TABLE Entrega (
    entrega_id INT PRIMARY KEY,
    pedido_id INT,
    status VARCHAR(50),
    codigo_rastreio VARCHAR(50),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

CREATE TABLE ItemPedido (
    item_id INT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);
----------------------- INSERINDO VALORES -------------------------------
-- Inserir fornecedores
INSERT INTO Fornecedor (fornecedor_id, nome)
VALUES (1, 'Fornecedor Fulaninho'),
       (2, 'Fornecedor Ciclaninho');

-- Inserir vendedores
INSERT INTO Vendedor (vendedor_id, nome)
VALUES (1, 'Vendedor Joãozinho'),
       (2, 'Vendedor Pedrinho');

-- Inserir clientes
INSERT INTO Cliente (cliente_id, nome, tipo)
VALUES (1, 'Maria', 'PF'),
       (2, 'Ana&Ana', 'PJ');

-- Inserir contas
INSERT INTO Conta (conta_id, cliente_id)
VALUES (1, 1),
       (2, 2);

-- Inserir produtos
INSERT INTO Produto (produto_id, fornecedor_id, nome, estoque)
VALUES (1, 1, 'Cadeira', 100),
       (2, 2, 'Mesa', 50);

-- Inserir pedidos
INSERT INTO Pedido (pedido_id, cliente_id, vendedor_id)
VALUES (1, 1, 1),
       (2, 2, 2);

-- Inserir pagamentos
INSERT INTO Pagamento (pagamento_id, conta_id, forma_de_pagamento)
VALUES (1, 1, 'Cartão'),
       (2, 2, 'Boleto');

-- Inserir entregas
INSERT INTO Entrega (entrega_id, pedido_id, status, codigo_rastreio)
VALUES (1, 1, 'Em trânsito', '123456'),
       (2, 2, 'Entregue', '789012');

-- Inserir itens de pedido
INSERT INTO ItemPedido (item_id, pedido_id, produto_id, quantidade)
VALUES (1, 1, 1, 5),
       (2, 1, 2, 3),
       (3, 2, 1, 2);


----------------------- CONSULTAS -------------------------------

-- Recupera os nomes dos fornecedores
SELECT nome
FROM Fornecedor;

-- Recupera os nomes dos clientes que são pessoas físicas (tipo 'PF')
SELECT nome
FROM Cliente
WHERE tipo = 'PF';

-- Recupera os nomes dos produtos e adiciona uma coluna "status" baseada no estoque
SELECT nome, CASE WHEN estoque > 0 THEN 'Disponível' ELSE 'Indisponível' END AS status
FROM Produto;

-- Recupera os nomes dos vendedores ordenados alfabeticamente
SELECT nome
FROM Vendedor
ORDER BY nome;

-- Recupera os nomes dos fornecedores que têm pelo menos 3 produtos disponíveis
SELECT Fornecedor.nome
FROM Fornecedor
JOIN Produto ON Fornecedor.fornecedor_id = Produto.fornecedor_id
WHERE Produto.estoque >= 3
GROUP BY Fornecedor.nome;

-- Recupera os nomes dos clientes, produtos pedidos e quantidades
SELECT Cliente.nome AS cliente, Produto.nome AS produto, ItemPedido.quantidade
FROM Cliente
JOIN Pedido ON Cliente.cliente_id = Pedido.cliente_id
JOIN ItemPedido ON Pedido.pedido_id = ItemPedido.pedido_id
JOIN Produto ON ItemPedido.produto_id = Produto.produto_id;
