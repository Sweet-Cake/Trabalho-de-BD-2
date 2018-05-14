use atletismo
 drop table prova_corrida
 drop table prova_atleta
 drop table prova_cs
	
CREATE TABLE desempenho(
	cod_prova INT,
	cod_atleta INT,
	cod_bateria INT,
	cod_fase INT,
	resultado VARCHAR(20)
	PRIMARY KEY(cod_prova,cod_atleta,cod_bateria,cod_fase),
	FOREIGN KEY (cod_prova) REFERENCES prova(cod),
	FOREIGN KEY (cod_atleta) REFERENCES atleta(cod),
	FOREIGN KEY (cod_bateria) REFERENCES bateria(id),
	FOREIGN KEY (cod_fase) REFERENCES fase(id)
)
CREATE FUNCTION fn_tabelaDes (@prova VARCHAR(100), @bateria VARCHAR(20), @fase VARCHAR(20))
	RETURNS @tabelaDesempenho table (
		Codigo INT,
		Nome VARCHAR(100),
		Pais VARCHAR(50),
		Resultado VARCHAR(20)
	)
BEGIN
	DECLARE @codp INT,
			@codb INT,
			@codf INT
		SET @codp = (SELECT cod FROM prova WHERE prova=@prova)
		SET @codf =(SELECT id FROM fase WHERE nome=@fase)
		SET @codb=(SELECT id FROM bateria WHERE nome=@bateria)

		INSERT INTO @tabelaDesempenho(Codigo,Nome,Pais,Resultado)
		SELECT atl.cod,atl.nome,ps.nome,d.resultado FROM desempenho d
		INNER JOIN prova p
		ON d.cod_prova=p.cod
		INNER JOIN fase f
		ON d.cod_fase=f.id
		INNER JOIN bateria b
		ON d.cod_bateria=b.id
		INNER JOIN atleta atl
		ON d.cod_atleta=atl.cod
		INNER JOIN pais ps
		ON atl.cod_pais=ps.cod
		WHERE
		p.cod=@codp AND f.id=@codf AND b.id=@codb 
	RETURN
END

CREATE FUNCTION fn_tabelaProva (@fase VARCHAR(20),@prova VARCHAR(100))
	RETURNS @tabelaProva table (
		Codigo INT,
		Nome VARCHAR(100),
		Pais VARCHAR(50),
		Resultado VARCHAR(20)
	)
BEGIN
	DECLARE @codp INT,
			@codb INT,
			@codf INT
		SET @codp = (SELECT cod FROM prova WHERE prova=@prova)
		SET @codf =(SELECT id FROM fase WHERE nome=@fase)

		INSERT INTO @tabelaProva(Codigo,Nome,Pais,Resultado)
		SELECT atl.cod,atl.nome,ps.nome,d.resultado FROM desempenho d
		INNER JOIN prova p
		ON d.cod_prova=p.cod
		INNER JOIN fase f
		ON d.cod_fase=f.id
		INNER JOIN bateria b
		ON d.cod_bateria=b.id
		INNER JOIN atleta atl
		ON d.cod_atleta=atl.cod
		INNER JOIN pais ps
		ON atl.cod_pais=ps.cod
		WHERE
		p.cod=@codp AND f.id=@codf
	RETURN
END

select * FROM dbo.fn_tabelaDes('Lançamento de Dado / Javelin Throw','1ºCiclo','FINAL') as tabela
select * FROM dbo.fn_tabelaDes('3000m / 3000m','1ºCiclo','FINAL') as tabelac
select * FROM dbo.fn_tabelaProva('FINAL','Lançamento de Dado / Javelin Throw') as tabelak