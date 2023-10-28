CREATE DATABASE LOCADORA

GO

USE LOCADORA

GO

CREATE TABLE filme (
id_filme		int				not null,
titulo			varchar(40)		not null,
ano				int				null	CHECK(ano < 2022)
PRIMARY KEY (ID_filme)
)

GO

CREATE TABLE cliente (
num_cliente		int				not null,
nome				varchar(70)		not null,
logradouro			varchar(150)	not null,
num					int				not null	CHECK(num > 0),
cep					char(8)			null	CHECK(LEN(cep) = 8)
PRIMARY KEY (num_cliente)
)

GO

CREATE TABLE estrela (
id_estrela		int				not null,
nome			varchar(50)		not null
PRIMARY KEY (id_estrela)
)

GO

CREATE TABLE filme_estrela (
id_filme		int		not null,
id_estrela		int		not null
PRIMARY KEY (id_filme, id_estrela)
FOREIGN KEY (id_filme) REFERENCES filme (id_filme),
FOREIGN KEY (id_estrela) REFERENCES estrela (id_estrela)
)

GO

CREATE TABLE dvd (
id_filme			int			not null,
num_dvd				int			not null,
data_fabricacao		date		not null	
PRIMARY KEY (num_dvd)
FOREIGN KEY (id_filme) REFERENCES filme (id_filme)
CONSTRAINT chk_data_hj CHECK(data_fabricacao < GETDATE())
)

GO

CREATE TABLE locacao (
num_dvd				int				not null,
num_cliente			int				not null,
data_locacao		date			not null	DEFAULT(GETDATE()),
data_devolucao		date			not null,
valor				decimal(7,2)	not null	CHECK(valor > 0)
PRIMARY KEY (num_dvd, num_cliente, data_locacao)
FOREIGN KEY (num_dvd) REFERENCES dvd (num_dvd),
FOREIGN KEY (num_cliente) REFERENCES cliente (num_cliente),
CONSTRAINT chk_data_devo CHECK (data_devolucao > data_locacao)
)

GO

ALTER TABLE estrela
ADD nome_estrela	varchar(50) null

GO

ALTER TABLE filme
ALTER COLUMN titulo varchar(80) not null

GO

INSERT INTO filme VALUES
(1001, 'Whiplash', 2015),
(1002, 'Birdman', 2015),
(1003, 'Interestelar', 2014),
(1004, 'A Culpa é das Estrelas', 2014),
(1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
(1006, 'Sing', 2016)

GO

INSERT INTO estrela VALUES 
(9901, 'Michael Keaton', 'Michael John Douglas'),
(9902, 'Emma Stone', 'Emily Jean Stone'),
(9904, 'Steve Carell', 'Steven John Carell'),
(9905, 'Jennifer Garner', 'Jennifer Anne Garner')

GO

INSERT INTO estrela (id_estrela, nome)
VALUES (9903, 'Miles Teller')

GO

INSERT INTO filme_estrela VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)

GO
INSERT INTO dvd (num_dvd, id_filme, data_fabricacao) VALUES
(10001, 1001, '02-12-2020')

GO

INSERT INTO dvd (num_dvd, id_filme, data_fabricacao) VALUES
(10002, 1002, '18-10-2019'),
(10003, 1003, '03-04-2020'),
(10004, 1001, '02-12-2020'),
(10005, 1004, '18-10-2020'),
(10006, 1002, '03-04-2020'),
(10007, 1005, '02-12-2020'),
(10008, 1002, '18-10-2019'),
(10009, 1003, '03-04-2020')

INSERT INTO cliente VALUES
(5501, 'Matilde Luz', 'Rua Síria', 150, '03086040'),
(5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'),
(5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')

GO

INSERT INTO cliente VALUES
(5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, null),
(5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, null)

INSERT INTO locacao VALUES
(10001, 5502, '2021-02-18', '2021-02-21', 3.50)

GO

INSERT INTO LOCACAO VALUES
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20', '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)

GO

UPDATE cliente
SET CEP = '08411150'
WHERE num_cliente = 5503

GO

UPDATE cliente
SET CEP = '02918190'
WHERE num_cliente = 5504

GO

UPDATE locacao
SET valor = 3.25
WHERE data_locacao = '2021-02-18' AND num_cliente = 5502

GO

UPDATE locacao
SET valor = 3.10
WHERE data_locacao = '2021-02-24' AND num_cliente = 5501

GO

UPDATE dvd
SET data_fabricacao = '2019-07-14'
WHERE num_dvd = 10005

GO

UPDATE estrela
SET nome_estrela = 'Miles Alexander Teller'
WHERE UPPER(nome) = 'MILES TELLER'

GO 

DELETE filme
WHERE UPPER(titulo) = 'SING'

GO

SELECT titulo
FROM filme
WHERE ano = 2014

GO 

SELECT id_filme, ano
from filme
where UPPER(titulo) = 'BIRDMAN'

GO

INSERT INTO filme 
VALUES (1006, 'harplash', 2015)

GO

SELECT id_filme, ano
FROM filme
WHERE UPPER(titulo) LIKE '%PLASH'

GO

SELECT * 
FROM estrela
WHERE UPPER(nome) LIKE 'STEVE%'

GO

SELECT id_filme, CONVERT(CHAR(10), data_fabricacao, 103) AS Fab
FROM dvd
WHERE data_fabricacao > '01-01-2020'

GO

SELECT num_dvd, data_locacao, data_devolucao, valor, valor + 2.00 AS Multa_Acrescimo
FROM locacao
WHERE num_cliente = 5505

GO

SELECT logradouro, num, cep
FROM cliente
WHERE UPPER(nome) = 'MATILDE LUZ'

GO

SELECT nome_estrela
FROM estrela
WHERE UPPER(nome) = 'MICHAEL KEATON' 

GO

SELECT num_cliente, logradouro + ', ' + CAST(num AS varchar(7)) + ' - CEP: ' + cep AS end_comp 
FROM cliente
WHERE num_cliente >= 5503


SELECT * FROM cliente
SELECT * FROM dvd
SELECT * FROM estrela
SELECT * FROM filme
SELECT * FROM filme_estrela
SELECT * FROM locacao 