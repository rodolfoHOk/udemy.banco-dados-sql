/* Modelagem básica */
Banco: LIVRARIA
Tabela: LIVROS
ATRIBUTOS: {
	NOME_DO_LIVRO - CARACTER(30),
	NOME_DO_AUTOR - CARACTER(30),
	SEXO_DO_AUTOR - CARACTER(9),
	NUMERO_DE_PAGINAS - NUMERO INTEIRO(5),
	NOME_DA_EDITORA - CARACTER(30),
	VALOR_DO_LIVRO - NÚMERO FLOAT(6,2),
	UF_DA_EDITORA - CARACTER(2),
	ANO_PUBLICACAO - NÚMERO INTEIRO(4),
}

/* Modelagem Lógica */
arquivo do brModelo: livraria-modelagem

/* Modelagem Física */
/* 1 - Criando o banco de dados */
CREATE DATABASE LIVRARIA;

/* OBS VERIFICANDO OS BANCOS */
SHOW DATABASES;

/* 2 -Conectando ao banco de dados */
USE LIVRARIA;

/* 3 - Criando a Tabela */
CREATE TABLE LIVROS(
	NOME_DO_LIVRO VARCHAR(100),
	NOME_DO_AUTOR VARCHAR(100),
	SEXO_DO_AUTOR VARCHAR(9),
	NUMERO_DE_PAGINAS INT(5),
	NOME_DA_EDITORA VARCHAR(30),
	VALOR_DO_LIVRO FLOAT(10,2),
	UF_DA_EDITORA CHAR(2),
	ANO_PUBLICACAO INT(4)
);

/* Inserindo os dados para teste */
INSERT INTO LIVROS(NOME_DO_LIVRO, NOME_DO_AUTOR, SEXO_DO_AUTOR, NUMERO_DE_PAGINAS, NOME_DA_EDITORA, VALOR_DO_LIVRO, UF_DA_EDITORA, ANO_PUBLICACAO)
VALUES('Cavaleiro Real','Ana Claudia','Feminino',465,'Atlas',49.90,'RJ',2009),
('SQL para leigos','João Nunes','Masculino',450,'Addison',98.00,'SP',2018),
('Receitas Caseiras','Celia Tavares','Feminino',210,'Atlas',45.00,'RJ',2008),
('Pessoas Efetivas','Eduardo Santos','Masculino',390,'Beta',78.99,'RJ',2018),
('Habitos Saudaveis','Eduardo Santos','Masculino',630,'Beta',150.98,'RJ',2019),
('A Casa Marrom','Hermes Macedo','Masculino',250,'Bubba',60.00,'MG',2016),
('Estacio Querido','Geraldo Francisco','Masculino',310,'Insignia',100.00,'ES',2015),
('Pra sempre amigas','Leda Silva','Feminino',510,'Insignia',78.98,'ES',2011),
('Copas Inesqueciveis','Marco Alcantara','Masculino',200,'Larson',130.98,'RS',2018),
('O poder da mente','Clara Mafra','Feminino',120,'Continental',56.58,'SP',2017);

/* Query SQL Exercícios */
/* 1 - Trazer todos os dados. */
SELECT * FROM LIVROS;

/* 2 - Trazer o nome do livro e o nome da editora */
SELECT NOME_DO_LIVRO, NOME_DA_EDITORA FROM LIVROS;

/* 3 - Trazer o nome do livro e a UF dos livros publicados por autores do sexo masculino */
SELECT NOME_DO_LIVRO, UF_DA_EDITORA FROM LIVROS
WHERE SEXO_DO_AUTOR = 'Masculino';

/* 4 - Trazer o nome do livro e o número de páginas dos livros publicados por autores do sexo feminino */
SELECT NOME_DO_LIVRO, NUMERO_DE_PAGINAS FROM LIVROS
WHERE SEXO_DO_AUTOR = 'Feminino';

/* 5 - Trazer os valores dos livros das editoras de São Paulo */
SELECT NOME_DO_LIVRO, VALOR_DO_LIVRO FROM LIVROS
WHERE UF_DA_EDITORA = 'SP';

/* 6 - Trazer os dados dos autores do sexo masculino que tiveram livros publicados por São Paulo ou Rio de Janeiro (Questão Desafio) */
SELECT NOME_DO_AUTOR, SEXO_DO_AUTOR FROM LIVROS
WHERE SEXO_DO_AUTOR = 'Masculino' AND (UF_DA_EDITORA = 'SP' OR UF_DA_EDITORA = 'RJ');
