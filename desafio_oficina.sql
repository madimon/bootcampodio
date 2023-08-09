-- CRIAÇÃO BANCO DE DADOS 
CREATE DATABASE desafio_oficina;
USE desafio_oficina;

-- TABELAS
CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(25),
    telefone VARCHAR(15)
);

CREATE TABLE Veiculo (
    veiculo_id INT PRIMARY KEY,
    cliente_id INT,
    marca VARCHAR(15),
    modelo VARCHAR(15),
    ano INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE Servico (
    servico_id INT PRIMARY KEY,
    descricao VARCHAR(200),
    preco DECIMAL(10, 2)
);

CREATE TABLE OrdemServico (
    ordem_id INT PRIMARY KEY,
    cliente_id INT,
    veiculo_id INT,
    data_entrada DATE,
    data_saida DATE,
    total_pago DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (veiculo_id) REFERENCES Veiculo(veiculo_id)
);

CREATE TABLE ItensOrdemServico (
    item_id INT PRIMARY KEY,
    ordem_id INT,
    servico_id INT,
    quantidade INT,
    FOREIGN KEY (ordem_id) REFERENCES OrdemServico(ordem_id),
    FOREIGN KEY (servico_id) REFERENCES Servico(servico_id)
);

-- DADOS
INSERT INTO Cliente (cliente_id, nome, telefone)
VALUES (1, 'Cleitinho', '859648579'),
       (2, 'Maria', '885566447');

INSERT INTO Veiculo (veiculo_id, cliente_id, marca, modelo, ano)
VALUES (1, 1, 'Volkswagen', 'Gol', 2009),
       (2, 2, 'Subaru', 'Impreza', 2016);

INSERT INTO Servico (servico_id, descricao, preco)
VALUES (1, 'Troca de óleo e filtro', 160.00),
       (2, 'Alinhamento e balanceamento computadorizado', 200.00);

INSERT INTO OrdemServico (ordem_id, cliente_id, veiculo_id, data_entrada, data_saida, total_pago)
VALUES (1, 1, 1, '2023-08-06', '2023-08-08', 250.00),
       (2, 2, 2, '2023-08-07', '2023-08-08', 200.00);

INSERT INTO ItensOrdemServico (item_id, ordem_id, servico_id, quantidade)
VALUES (1, 1, 1, 1),
       (2, 1, 2, 2),
       (3, 2, 2, 1);

-- CONSULTAS

-- nomes dos clientes
SELECT nome
FROM Cliente;

-- modelos dos veículos de um cliente específico
SELECT modelo
FROM Veiculo
WHERE cliente_id = 1;

-- total pago por cada ordem de serviço
SELECT OrdemServico.ordem_id, SUM(total_pago) AS total_pago
FROM OrdemServico
GROUP BY OrdemServico.ordem_id;

-- veículos e a quantidade de serviços realizados em cada ordem de serviço
SELECT OrdemServico.veiculo_id, COUNT(ItensOrdemServico.item_id) AS quantidade_servicos
FROM OrdemServico
JOIN ItensOrdemServico ON OrdemServico.ordem_id = ItensOrdemServico.ordem_id
GROUP BY OrdemServico.veiculo_id;

-- ordens de serviço e a descrição dos serviços realizados para cada uma
SELECT OrdemServico.ordem_id, Servico.descricao
FROM OrdemServico
JOIN ItensOrdemServico ON OrdemServico.ordem_id = ItensOrdemServico.ordem_id
JOIN Servico ON ItensOrdemServico.servico_id = Servico.servico_id;

