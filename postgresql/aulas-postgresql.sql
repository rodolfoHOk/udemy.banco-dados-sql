/* postgresql 3° versão do curso */

/* Instalações de softwares - Aula 116 */

/* Downloads de arquivos dos cursos - Aula 117 */

/* Criando o promeiro banco de dados - Aula 118 */

-- usaremos o arquivo 00 - Criacao da Database.sql
-- fizemos copiando e colando

/* trabalhando com datestyle - Aula 119 */

-- como mudar o datestyle no postgresql

/* criando o banco de dados do projeto */ 
-- usaremos o arquivo 00 - Criacao da Database.sql
-- fizemos abrindo o arquivo no pgadmin4 */

select * from funcionarios;

select * from departamentos;

select * from localizacao;

/* FUNÇOES DE AGREGAÇÃO - aula 121 */

-- Query Simples

select * from funcionarios;

-- Contando o numero

select count(*) from funcionarios;
select count(*) from departamentos;
select count(*) from localizacao;

-- Agrupando por sexo

select count(*) from funcionarios
group by sexo;


-- Colocando o nome da coluna

select sexo, count(*) as "quantidade" from funcionarios
group by sexo;

-- Mostrando o numero de funcionarios em cada departamento

select departamento, count(*) from funcionarios
group by departamento;


-- Exibindo o máximo de salarios - 149929

select max(salario) as "Salário Máximo" from funcionarios;

-- Exibindo o mínimo de salarios - 40138

select min(salario) as "Salário Minimo" from funcionarios;

-- Exibindo o máximo e mínimos juntos

select min(salario) as "Salário Mínimo", max(salario) as "Salário Máximo" 
from funcionarios;

-- Exibindo o máximo e mínimo de cada departamento

select departamento, min(salario) as "Salário Mínimo", max(salario) as "Salário Máximo" 
from funcionarios
group by departamento;


-- Exibindo o máximo e mínimo por sexo

select sexo, min(salario) as "Salário Mínimo", max(salario) as "Salário Máximo" 
from funcionarios
group by sexo;

/* Estatísticas - aula 122 */

-- Mostrando uma quantidade limitada de linhas

select * from funcionarios
limit 10;

-- Qual o gasto total de salario pago pela empresa?

select sum(salario) as "Valor total salários" from funcionarios;

-- Qual o montante total que cada departamento recebe de salario?

select departamento, sum(salario) as "Montante total salários"
from funcionarios
group by departamento;

-- Por departamento, qual o total e a média paga para os funcionarios?

select  departamento,
		sum(salario) as "Montante total salários",
		avg(salario) as "Média"
from funcionarios
group by departamento;

-- Ordenando

select  departamento,
		sum(salario) as "Montante total salários",
		avg(salario) as "Média"
from funcionarios
group by departamento
order by 3;

select  departamento,
		sum(salario) as "Montante total salários",
		avg(salario) as "Média"
from funcionarios
group by departamento
order by "Média";


select  departamento,
		sum(salario) as "Montante total salários",
		avg(salario) as "Média"
from funcionarios
group by departamento
order by 3 asc; 

select  departamento,
		sum(salario) as "Montante total salários",
		avg(salario) as "Média"
from funcionarios
group by departamento
order by 3 desc;

/* aula 123 e 124 - teórica de estatisticas */

/* aula 125 */

/* Modelagem Banco de Dados x Data Science */

/* Banco de Dados -> 1,2 e 3 Formas normais
Evitam reduncancia, consequentemente poupam espaço em disco.
Consomem muito processamento em função de Joins. Queries lentas

Data Science e B.I -> Focam em agregaçoes e performance. Não se 
preocupam com espaço em disco. Em B.I, modelagem mínima (DW)
em Data Science, preferencialmente modelagem Colunar */

/* aula 126 */

/* O servidor de maquinas gerou um arquivo de log CSV.
Vamos importá-lo e analisa-lo dentro do nosso banco */

/* Importando csv */

CREATE TABLE MAQUINAS(
	MAQUINA VARCHAR(20),
	DIA INT,
	QTD NUMERIC(10,2)
);

COPY MAQUINAS
FROM '/home/rodolfo/Documentos/LogMaquinas.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM MAQUINAS;

-- QUAL A MÉDIA DE CADA MAQUINA

SELECT MAQUINA, AVG(QTD) AS "MEDIA_QTD"
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 2 DESC;

-- ARREDONDANDO

SELECT MAQUINA, ROUND(AVG(QTD),2) AS "MEDIA_QTD"
FROM MAQUINAS
GROUP BY MAQUINA
ORDER BY 2 DESC;


-- QUAL A MODA DAS QUANTIDADES? (quantos com mesmas quantidade)

SELECT MAQUINA, QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC;

-- QUAL A MODA DAS QUANTIDADES DE CADA MAQUINA

SELECT MAQUINA, QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

SELECT MAQUINA, QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

SELECT MAQUINA, QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03'
GROUP BY MAQUINA, QTD
ORDER BY 3 DESC
LIMIT 1;

/* AULA 127 */

-- QUAL A MODA DO DATASET INTEIRO (GRAFICO DISSO CHAMA HISTOGRAMA)

SELECT QTD, COUNT(*) AS "MODA"
FROM MAQUINAS
GROUP BY QTD
ORDER BY 2 DESC

-- QUAL O MAXIMO E MINIMO E AMPLITUDE DE CADA MAQUINA?

SELECT 	MAQUINA,
		MAX(QTD) AS "MAXIMO",
		MIN(QTD) AS "MINIMO",
		MAX(QTD) - MIN(QTD) AS "AMPLITUDE"
		FROM MAQUINAS
		GROUP BY MAQUINA
		ORDER BY 4 DESC;

-- ACRESCENTE A MEDIA AO RELATORIO

SELECT 	MAQUINA,
		ROUND(AVG(QTD),2) AS "MEDIA",
		MAX(QTD) AS "MAXIMO",
		MIN(QTD) AS "MINIMO",
		MAX(QTD) - MIN(QTD) AS "AMPLITUDE"
		FROM MAQUINAS
		GROUP BY MAQUINA
		ORDER BY 5 DESC;

/* AULA 128 */

-- DESVIO PADRAO STDDEV_POP(coluna) E VARIANCIA VAR_POP(coluna)

SELECT 	MAQUINA,
		ROUND(AVG(QTD),2) AS "MEDIA",
		MAX(QTD) AS "MAXIMO",
		MIN(QTD) AS "MINIMO",
		MAX(QTD) - MIN(QTD) AS "AMPLITUDE",
		ROUND(STDDEV_POP(QTD),2) AS "DESVIO PADRAO",
		ROUND(VAR_POP(QTD),2) AS "VARIANCIA"
		FROM MAQUINAS
		GROUP BY MAQUINA
		ORDER BY 6 DESC;

/* AULA 129 - MEDIANA */

-- PEGO NA PAGINA WEB: https://wiki.postgresql.org/wiki/Aggregate_Median

CREATE OR REPLACE FUNCTION _final_median(numeric[])
   RETURNS numeric AS
$$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$$
LANGUAGE 'sql' IMMUTABLE;

CREATE AGGREGATE median(numeric) (
  SFUNC=array_append,
  STYPE=numeric[],
  FINALFUNC=_final_median,
  INITCOND='{}'
);

-- MODO DE USO:

SELECT median(num_value) AS median_value FROM t;

SELECT MEDIAN(QTD) AS "MEDIANA"
FROM MAQUINAS;

SELECT MEDIAN(QTD) AS "MEDIANA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 01';

SELECT MEDIAN(QTD) AS "MEDIANA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 02';

SELECT MEDIAN(QTD) AS "MEDIANA"
FROM MAQUINAS
WHERE MAQUINA = 'Maquina 03';

SELECT MAQUINA, MEDIAN(QTD) AS "MEDIANA"
FROM MAQUINAS
GROUP BY MAQUINA;

SELECT 	MAQUINA,
		ROUND(AVG(QTD),2) AS "MEDIA",
		MAX(QTD) AS "MAXIMO",
		MIN(QTD) AS "MINIMO",
		MAX(QTD) - MIN(QTD) AS "AMPLITUDE",
		ROUND(MEDIAN(QTD),2) AS "MEDIANA",
		ROUND(STDDEV_POP(QTD),2) AS "DESVIO PADRAO",
		ROUND(VAR_POP(QTD),2) AS "VARIANCIA"
		FROM MAQUINAS
		GROUP BY MAQUINA
		ORDER BY 6 DESC;

-- inserindo mais dados para teste e apagando depois

INSERT INTO MAQUINAS VALUES('Maquina 01',11,15.9);
INSERT INTO MAQUINAS VALUES('Maquina 02',11,15.4);
INSERT INTO MAQUINAS VALUES('Maquina 03',11,15.7);
INSERT INTO MAQUINAS VALUES('Maquina 01',12,30);
INSERT INTO MAQUINAS VALUES('Maquina 02',12,24);
INSERT INTO MAQUINAS VALUES('Maquina 03',12,45);

delete from maquinas where dia = 11 or dia = 12;

/* AULA 130 - RESUMINDO TUDO */

/*
	QUANTIDADE
	TOTAL
	MEDIA
	MAXIMO
	MINIMO
	AMPLITUDE
	VARIANCIA
	DESVIO PADRAO
	MEDIANA
	COEF. VAR.
*/

SELECT 	MAQUINA,
		COUNT(*) AS "QUANTIDADE",
		SUM(QTD) AS "TOTAL KG",
		ROUND(AVG(QTD),2) AS "MEDIA",
		MAX(QTD) AS "MAXIMO",
		MIN(QTD) AS "MINIMO",
		MAX(QTD) - MIN(QTD) AS "AMPLITUDE",
		ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
		ROUND(STDDEV_POP(QTD),2) AS "DESVIO PADRAO",
		ROUND(MEDIAN(QTD),2) AS "MEDIANA",
		ROUND((STDDEV_POP(QTD)/AVG(QTD)*100),2) AS "COEF VARIACAO"
	FROM MAQUINAS
	GROUP BY MAQUINA
	ORDER BY 1;

/* AULA 131 - MODA: MODE() WITHIN GROUP(ORDER BY COLUNA)  */

SELECT MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA"
FROM MAQUINAS;

SELECT 	MAQUINA,
		MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA"
	FROM MAQUINAS
	GROUP BY MAQUINA;

SELECT 	MAQUINA,
		COUNT(*) AS "QUANTIDADE",
		SUM(QTD) AS "TOTAL KG",
		ROUND(AVG(QTD),2) AS "MEDIA",
		MAX(QTD) AS "MAXIMO",
		MIN(QTD) AS "MINIMO",
		MAX(QTD) - MIN(QTD) AS "AMPLITUDE",
		ROUND(VAR_POP(QTD),2) AS "VARIANCIA",
		ROUND(STDDEV_POP(QTD),2) AS "DESVIO PADRAO",
		ROUND(MEDIAN(QTD),2) AS "MEDIANA",
		ROUND((STDDEV_POP(QTD)/AVG(QTD)*100),2) AS "COEF VARIACAO",
		MODE() WITHIN GROUP(ORDER BY QTD) AS "MODA"
	FROM MAQUINAS
	GROUP BY MAQUINA
	ORDER BY 1;

/* AULA 132 - FORMATO COLUNAR */

-- CRIANDO NUM DATASET RELACIONAL PARA DEPOIS TRANFORMAR EM COLUNAR

CREATE TABLE GENERO(
	IDGENERO INT PRIMARY KEY,
	NOME VARCHAR(30)
);

INSERT INTO GENERO VALUES(1,'FANTASIA');
INSERT INTO GENERO VALUES(2,'AVENTURA');
INSERT INTO GENERO VALUES(3,'SUSPENSE');
INSERT INTO GENERO VALUES(4,'AÇÃO');
INSERT INTO GENERO VALUES(5,'DRAMA');

CREATE TABLE FILME(
	IDFILME INT PRIMARY KEY,
	NOME VARCHAR(50),
	ANO INT,
    ID_GENERO INT,
	FOREIGN KEY(ID_GENERO)
	REFERENCES GENERO(IDGENERO)
);

INSERT INTO FILME VALUES(100,'KILL BILL I',2007,2);
INSERT INTO FILME VALUES(200,'DRACULA',1998,3);
INSERT INTO FILME VALUES(300,'SENHOR DOS ANEIS',2008,1);
INSERT INTO FILME VALUES(400,'UM SONHO DE LIBERDADE',2008,5);
INSERT INTO FILME VALUES(500,'OS BAD BOYS',2008,4);
INSERT INTO FILME VALUES(600,'GUERRA CIVIL',2016,2);
INSERT INTO FILME VALUES(700,'CADILLAC RECORDS',2009,5);
INSERT INTO FILME VALUES(800,'O HOBBIT',2008,1);
INSERT INTO FILME VALUES(900,'TOMATES VERDES FRITOS',2008,5);
INSERT INTO FILME VALUES(1000,'CORRIDA MORTAL',2008,4);

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA DATE,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)

);

INSERT INTO LOCACAO VALUES(1,'01/08/2019',23,3,100);
INSERT INTO LOCACAO VALUES(2,'01/02/2019',56,1,400);
INSERT INTO LOCACAO VALUES(3,'02/07/2019',23,3,400);
INSERT INTO LOCACAO VALUES(4,'02/02/2019',43,1,500);
INSERT INTO LOCACAO VALUES(5,'02/02/2019',23,2,100);
INSERT INTO LOCACAO VALUES(6,'03/07/2019',76,3,700);
INSERT INTO LOCACAO VALUES(7,'03/02/2019',45,1,700);
INSERT INTO LOCACAO VALUES(8,'04/08/2019',89,3,100);
INSERT INTO LOCACAO VALUES(9,'04/02/2019',23,3,800);
INSERT INTO LOCACAO VALUES(10,'05/07/2019',23,3,500);
INSERT INTO LOCACAO VALUES(11,'05/02/2019',38,3,800);
INSERT INTO LOCACAO VALUES(12,'01/10/2019',56,1,100);
INSERT INTO LOCACAO VALUES(13,'06/12/2019',23,3,400);
INSERT INTO LOCACAO VALUES(14,'01/02/2019',56,2,300);
INSERT INTO LOCACAO VALUES(15,'04/10/2019',76,3,300);
INSERT INTO LOCACAO VALUES(16,'01/09/2019',32,2,400);
INSERT INTO LOCACAO VALUES(17,'08/02/2019',89,3,100);
INSERT INTO LOCACAO VALUES(18,'01/02/2019',23,1,200);
INSERT INTO LOCACAO VALUES(19,'08/09/2019',45,3,300);
INSERT INTO LOCACAO VALUES(20,'01/12/2019',89,1,400);
INSERT INTO LOCACAO VALUES(21,'09/07/2019',23,3,1000);
INSERT INTO LOCACAO VALUES(22,'01/12/2019',21,3,1000);
INSERT INTO LOCACAO VALUES(23,'01/02/2019',34,2,100);
INSERT INTO LOCACAO VALUES(24,'09/08/2019',67,1,1000);
INSERT INTO LOCACAO VALUES(25,'01/02/2019',76,3,1000);
INSERT INTO LOCACAO VALUES(26,'01/02/2019',66,3,200);
INSERT INTO LOCACAO VALUES(27,'09/12/2019',90,1,400);
INSERT INTO LOCACAO VALUES(28,'03/02/2019',23,3,100);
INSERT INTO LOCACAO VALUES(29,'01/12/2019',65,5,1000);
INSERT INTO LOCACAO VALUES(30,'03/08/2019',43,1,1000);
INSERT INTO LOCACAO VALUES(31,'01/02/2019',27,31,200);

SELECT F.NOME, G.NOME, L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME;

/* Podemos criar uma tabela com o resultado de uma querie
e essa é a forma de realizar uma modelagem colunar 
CREATE TABLE AS SELECT
*/

CREATE TABLE REL_LOCADORA AS
SELECT F.NOME AS "FILME", G.NOME AS "GENERO", L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON F.IDFILME = L.ID_FILME;

SELECT * FROM REL_LOCADORA;

/* EXPORTANDO PARA ARQUIVO */

COPY REL_LOCADORA
TO '/home/rodolfo/Documentos/rel_locadora.csv'
DELIMITER ';'
CSV HEADER;

/* AULA 133 - TEÓRICA */

/* AULA 134 - SINCRONIZANDO TABELAS E RELATORIOS */

DROP TABLE LOCACAO;

CREATE TABLE LOCACAO(
	IDLOCACAO INT PRIMARY KEY,
	DATA TIMESTAMP,
	MIDIA INT,
	DIAS INT,
	ID_FILME INT,
	FOREIGN KEY(ID_FILME)
	REFERENCES FILME(IDFILME)

);

CREATE SEQUENCE SEQ_LOCACAO;

-- comando para pegar o proximo valor da sequence
NEXTVAL('SEQ_LOCACAO');

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/08/2018',23,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',56,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/07/2018',23,3,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/02/2018',43,1,500);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'02/02/2018',23,2,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/07/2018',76,3,700);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/02/2018',45,1,700);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/08/2018',89,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/02/2018',23,3,800);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'05/07/2018',23,3,500);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'05/02/2018',38,3,800);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/10/2018',56,1,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'06/12/2018',23,3,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',56,2,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'04/10/2018',76,3,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/09/2018',32,2,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'08/02/2018',89,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',23,1,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'08/09/2018',45,3,300);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',89,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/07/2018',23,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',21,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',34,2,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/08/2018',67,1,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',76,3,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',66,3,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'09/12/2018',90,1,400);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/02/2018',23,3,100);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/12/2018',65,5,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'03/08/2018',43,1,1000);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),'01/02/2018',27,31,200);

SELECT * FROM LOCACAO;	
SELECT * FROM GENERO;
SELECT * FROM FILME;
SELECT * FROM REL_LOCADORA;

DROP TABLE REL_LOCADORA;

SELECT L.IDLOCACAO, F.NOME AS "FILME", G.NOME AS "GENERO", L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME

CREATE TABLE RELATORIO_LOCADORA AS
SELECT L.IDLOCACAO, F.NOME AS "FILME", G.NOME AS "GENERO", L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

SELECT * FROM RELATORIO_LOCADORA;
SELECT * FROM LOCACAO;

/* SELECT PARA TRAZER OS REGISTROS NOVOS */

-- VERIFICA SE ESTAO SINCRONIZADOS OS IDS MAXIMOS SÃO IGUAIS
SELECT MAX(IDLOCACAO) AS RELATORIO, (SELECT MAX(IDLOCACAO) FROM LOCACAO) AS LOCACAO
FROM RELATORIO_LOCADORA;

-- SEELECT QUE TRAZ SOMENTE OS REGISTROS QUE NÃO ESTAO NO RELATORIO
SELECT L.IDLOCACAO, F.NOME AS "FILME", G.NOME AS "GENERO", L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

/* INSERINDO OS REGISTROS NOVOS */

INSERT INTO RELATORIO_LOCADORA
SELECT L.IDLOCACAO, F.NOME AS "FILME", G.NOME AS "GENERO", L.DATA, L.DIAS, L.MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME
WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

/* AULA 135 - PROGRAMANDO A SINCRONIZACAO */

/* VAMOS DEIXAR ESSE PROCEDIMENTO AUTOMATICO USANDO UMNA TRIGGER */

-- NO POSTGRESQL PRIMEIRO PRECISAMOS CRIAR A FUNÇÃO QUE A TRIGGER CHAMARÁ
CREATE OR REPLACE FUNCTION ATUALIZA_REL()
RETURNS TRIGGER AS $$
BEGIN

	INSERT INTO RELATORIO_LOCADORA
	SELECT L.IDLOCACAO, F.NOME AS "FILME", G.NOME AS "GENERO", L.DATA, L.DIAS, L.MIDIA
	FROM GENERO G
	INNER JOIN FILME F
	ON G.IDGENERO = F.ID_GENERO
	INNER JOIN LOCACAO L
	ON L.ID_FILME = F.IDFILME
	WHERE IDLOCACAO NOT IN (SELECT IDLOCACAO FROM RELATORIO_LOCADORA);

	COPY RELATORIO_LOCADORA 
	TO '/home/rodolfo/Documentos/RELATORIO_LOCADORA.csv'
	DELIMITER ';'
	CSV HEADER;

RETURN NEW;	

END;
$$
LANGUAGE PLPGSQL;

-- COMANDO PARA APAGAR UMA TRIGGER
DROP TRIGGER TG_RELATORIO ON LOCACAO;

-- CRIANDO A TRIGGER
CREATE TRIGGER TG_RELATORIO
	AFTER INSERT ON LOCACAO
	FOR EACH ROW
	EXECUTE PROCEDURE ATUALIZA_REL();

-- INSERINDO NOVOS REGISTROS 

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),100,7,300);

SELECT * FROM LOCACAO;
SELECT * FROM RELATORIO_LOCADORA;

INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),500,1,200);
INSERT INTO LOCACAO VALUES(NEXTVAL('SEQ_LOCACAO'),NOW(),800,6,500);

/* AULA 136 - SINCRONIZANDO COM REGISTROS DELETADOS */

CREATE OR REPLACE FUNCTION DELETE_LOCACAO()
RETURNS TRIGGER AS
$$
BEGIN

	DELETE FROM RELATORIO_LOCADORA
	WHERE IDLOCACAO = OLD.IDLOCACAO;

	COPY RELATORIO_LOCADORA 
	TO '/home/rodolfo/Documentos/RELATORIO_LOCADORA.csv'
	DELIMITER ';'
	CSV HEADER;

RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER DELETE_REG
	BEFORE DELETE ON LOCACAO
	FOR EACH ROW
	EXECUTE PROCEDURE DELETE_LOCACAO();

SELECT * FROM LOCACAO;
SELECT * FROM RELATORIO_LOCADORA;

DELETE FROM LOCACAO 
WHERE IDLOCACAO = 1;

/* AULA 137 - EXERCÍCIOS SALARIOS */

-- Qual a moda dos salarios. A moda dos salários diz algo relevante?

SELECT MODE() WITHIN GROUP(ORDER BY SALARIO) AS "MODA"
FROM FUNCIONARIOS; -- 47281 É O SALARIO QUE MAIS APARECE

-- Qual a moda departamental = Qual o departamento que mais emprega?

SELECT MODE() WITHIN GROUP(ORDER BY DEPARTAMENTO) AS "MODA"
FROM FUNCIONARIOS; -- BELEZA 

-- Qual o desvio padrao de cada departamento?

SELECT 	DEPARTAMENTO, 
		ROUND(STDDEV_POP(SALARIO),2) AS "DESVIO PADRAO"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO
ORDER BY 2; -- OUTDOOR MENOR DESVIO PADRAO

-- Calcule a mediana salarial de todo o set de dados

SELECT ROUND(MEDIAN(SALARIO),2) AS "MEDIANA"
FROM FUNCIONARIOS; -- 96278.50

-- Qual a amplitude de todos os salarios?

SELECT MAX(SALARIO) - MIN(SALARIO) AS "AMPLITUDE"
FROM FUNCIONARIOS; -- 109791

-- Calcule as principais medidas estatísticas por departamento

SELECT 	DEPARTAMENTO, 
		COUNT(*) AS "N FUNCIONARIOS",
		SUM(SALARIO) AS "TOTAL SALARIAL",
		MIN(SALARIO) AS "MINIMO",
		MAX(SALARIO) AS "MAXIMO",
		MAX(SALARIO) - MIN(SALARIO) AS "AMPLITUDE",
		MODE() WITHIN GROUP(ORDER BY SALARIO) AS "MODA",
		ROUND(AVG(SALARIO),0) AS "MEDIA",
		ROUND(MEDIAN(SALARIO),0) AS "MEDIANA",
		ROUND(STDDEV_POP(SALARIO),0) AS "DESVIO PADRAO",
		ROUND(VAR_POP(SALARIO),0) AS "VARIANCIA",
		ROUND((STDDEV_POP(SALARIO)/AVG(SALARIO)*100),2) AS "COEF VARIACAO"
FROM FUNCIONARIOS
GROUP BY DEPARTAMENTO
ORDER BY "COEF VARIACAO";

-- Qual departamento te dá uma maior probabilidade de ganhar mais? -- Outdoor?

-- OUTDOOR PORQUE TEM MAIOR MEDIA E MEDIANA SALARIAL 
-- E TEM O MENOR COEFICIENTE DE VARIAÇÃO (DESVIO PADRAO / MEDIA * 100);

/* Aula 138 - Variáveis Dummy - Machine Learning */

-- Utilizando o Case

SELECT CARGO FROM FUNCIONARIOS;

SELECT NOME, CARGO,
CASE
	WHEN CARGO = 'Financial Advisor' THEN 'Condicao 01'
	WHEN CARGO = 'Structural Engineer' THEN 'Condicao 02'
	WHEN CARGO = 'Executive Secretary' THEN 'Condicao 03'
	WHEN CARGO = 'Sales Associate' THEN 'Condicao 04'
	ELSE 'Outras Condicoes'
END AS "CONDICOES"
FROM FUNCIONARIOS;

SELECT NOME, SEXO FROM FUNCIONARIOS;

SELECT NOME,
CASE
	WHEN SEX0 = 'Masculino' THEN 'M'
	ELSE 'F'
END AS "SEXO"
FROM FUNCIONARIOS;

-- Utilizando Valores Booleanos

SELECT 	NOME, 
		CARGO, 
		(SEXO = 'Masculino') AS "MASCULINO",
		(SEXO = 'Feminino') AS "FEMININO"
FROM FUNCIONARIOS;

-- Mesclando as técnicas

SELECT NOME, CARGO,
CASE
	WHEN (SEXO = 'Masculino') = true THEN 1
	ELSE 0
END AS "MASCULINO",
CASE
	WHEN (SEXO = 'Feminino') = true THEN 1
	ELSE 0
END AS "FEMININO"
FROM FUNCIONARIOS;

/* Aula 139 - Filtros */

/* Filtros de Grupo */

-- Filtros baseados em valores numericos

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE SALARIO > 100000;

SELECT NOME, DEPARTAMENTO
FROM FUNCIONARIOS
WHERE SALARIO > 100000;

-- Filtros baseados em strings

SELECT NOME, DEPARTAMENTO, salario -- coluna não é case sensitive
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas';

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'FERRAMENTAS'; -- nada retorna filtro é case sensitive

-- Filtros baseados em multiplos tipos e colunas - considerar OR e AND

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'
AND
SALARIO > 100000;

-- Filtro baseado em unico tipo e coluna - atenção para a regra do AND e OR

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'
OR
DEPARTAMENTO = 'Books';

SELECT NOME, DEPARTAMENTO, SALARIO
FROM FUNCIONARIOS
WHERE DEPARTAMENTO = 'Ferramentas'
AND
DEPARTAMENTO = 'Books'; -- com AND não retorna nada.
/* obs: em relacionamentos 1 x 1 o filtro AND tratando de uma unica coluna
sempre dará falso */

-- Filtros baseados em padrao de caracteres

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'B%'
GROUP BY DEPARTAMENTO;

-- Filtros baseados em padrao de caracteres com mais letras

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'Be%' -- É CASE SENSITIVE
GROUP BY DEPARTAMENTO;

-- Utilizando o caracter coringa no meio da palavra 

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'B%s'
GROUP BY DEPARTAMENTO;

-- e se eu quisesse filtar o agrupamento pelo salario? (ex: > 40000000)

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'B%' AND SUM(SALARIO) > 40000000
GROUP BY DEPARTAMENTO; -- ERRO
/* OBS: COLUNAS NÃO AGREGADAS - WHERE
		COLUNAS AGREGADAS - HAVING */

SELECT DEPARTAMENTO, SUM(SALARIO) AS "TOTAL"
FROM FUNCIONARIOS
WHERE DEPARTAMENTO LIKE 'B%'
GROUP BY DEPARTAMENTO
HAVING SUM(SALARIO) > 4000000;

/* Aula 140 - Filtros de contadores */

-- Multiplos contadores

SELECT COUNT(*) FROM FUNCIONARIOS;

SELECT  COUNT(*) AS "QTD TOTAL",
		COUNT('Masculino') AS "MASCULINO"
FROM FUNCIONARIOS; -- deu errado

SELECT SEXO, COUNT(*)
FROM FUNCIONARIOS
WHERE SEXO = 'Masculino'
GROUP BY SEXO;
--QUERY QUE TRAZ OS MASCULINOS

SELECT  COUNT(*) AS "QTD TOTAL",
		COUNT(SELECT SEXO, COUNT(*)
		FROM FUNCIONARIOS
		WHERE SEXO = 'Masculino'
		GROUP BY SEXO) AS "MASCULINO"
FROM FUNCIONARIOS; -- ERRO SINTAXE

SELECT  COUNT(*) AS "QTD TOTAL",
		(SELECT SEXO, COUNT(*)
		FROM FUNCIONARIOS
		WHERE SEXO = 'Masculino'
		GROUP BY SEXO) AS "MASCULINO"
FROM FUNCIONARIOS; -- ERRO

SELECT  COUNT(*) AS "QTD TOTAL",
		(SELECT COUNT(*)
		FROM FUNCIONARIOS
		WHERE SEXO = 'Masculino'
		GROUP BY SEXO) AS "MASCULINO"
FROM FUNCIONARIOS;
-- ACIMA FUNCIONA MAS DEGRADA PERFORMANCE

SELECT  COUNT(*) AS "QTD TOTAL",
		COUNT(*) FILTER(WHERE SEXO = 'Masculino') AS "MASCULINO"
FROM FUNCIONARIOS;

SELECT  COUNT(*) AS "QTD TOTAL",
		COUNT(*) FILTER(WHERE SEXO = 'Masculino') AS "MASCULINO",
		COUNT(*) FILTER(WHERE DEPARTAMENTO = 'Books') AS "LIVROS"
FROM FUNCIONARIOS;

SELECT  COUNT(*) AS "QTD TOTAL",
		COUNT(*) FILTER(WHERE SEXO = 'Masculino') AS "MASCULINO",
		COUNT(*) FILTER(WHERE DEPARTAMENTO = 'Books') AS "LIVROS",
		COUNT(*) FILTER(WHERE SALARIO > 140000) AS "SALARIO > 140K"
FROM FUNCIONARIOS;
-- obs FILTER SÓ FUNCIONA COM COUNT(*)

/* AULA 141 - Formatando strings */

-- listando

SELECT DEPARTAMENTO FROM FUNCIONARIOS;

-- DISTINCT

SELECT DISTINCT DEPARTAMENTO FROM FUNCIONARIOS;

-- UPPER CASE

SELECT DISTINCT UPPER(DEPARTAMENTO) FROM FUNCIONARIOS;

-- LOWER CASE

SELECT DISTINCT lOWER(DEPARTAMENTO) FROM FUNCIONARIOS;

-- CONCATENAÇÃO DE STRINGS

SELECT CARGO || ' - ' || DEPARTAMENTO
FROM FUNCIONARIOS;

SELECT UPPER(CARGO || ' - ' || DEPARTAMENTO) AS "CARGO COMPLETO"
FROM FUNCIONARIOS;

-- REMOVER ESPAÇOS 

SELECT '     UNIDADOS    ';

-- CONTANDO CARACTERES

SELECT LENGTH('     UNIDADOS    ');

-- APLICANDO TRIM

SELECT TRIM('     UNIDADOS    ');

SELECT LENGTH(TRIM('     UNIDADOS    '));

/* DESAFIO - CRIAR UMA COLUNA AO LADO DA COLUNA CARGO 
QUE DIGA SE A PESSOA É ASSISTENTE OU NÃO */

SELECT 	NOME,
		CARGO,
		CASE
			WHEN (CARGO LIKE '%Assistant%') = TRUE THEN 'sim'
			ELSE 'não'
		END AS "ASSISTENTE?"
	FROM FUNCIONARIOS;

SELECT NOME, (CARGO LIKE '%Assistant%') AS "ASSISTENTE?"
FROM FUNCIONARIOS;

/* FIM DO MÓDULO DE POSTGRESQL */