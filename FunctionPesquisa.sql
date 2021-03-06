CREATE FUNCTION fn_tabelaDes (@prova VARCHAR(100), @bateria VARCHAR(20), @fase VARCHAR(20))
	RETURNS @tabelaDesempenho table (
		Codigo INT,
		Nome VARCHAR(100),
		Pais VARCHAR(50),
		Resultado DECIMAL(7,2)
	)
BEGIN
	DECLARE @codp INT,
			@codb INT,
			@codf INT
		SET @codp = (SELECT cod FROM prova WHERE prova=@prova)
		SET @codf =(SELECT id FROM fase WHERE nome=@fase)
		SET @codb=(SELECT id FROM bateria WHERE nome=@bateria)

		INSERT INTO @tabelaDesempenho(Codigo,Nome,Pais,Resultado)
		SELECT atl.cod,atl.nome,ps.nome,pcs.resultado FROM prova_cs pcs 
		INNER JOIN prova p
		ON pcs.cod_prova=p.cod
		INNER JOIN fase f
		ON pcs.cod_fase=f.id
		INNER JOIN bateria b
		ON pcs.cod_bateria=b.id
		INNER JOIN atleta atl
		ON pcs.cod_atleta=atl.cod
		INNER JOIN pais ps
		ON atl.cod_pais=ps.cod
		WHERE
		p.cod=@codp AND f.id=@codf AND b.id=@codb 
	RETURN
END
	
select * FROM dbo.fn_tabelaDes('Lançamento de Dado / Javelin Throw','1ºCiclo','FINAL') as tabela

CREATE FUNCTION fn_tabelaCorrida (@prova VARCHAR(100), @fase VARCHAR(20))
	RETURNS @tabelaDesempenho table (
		Codigo INT,
		Nome VARCHAR(100),
		Pais VARCHAR(50),
		Resultado DATETIME
	)
BEGIN
	DECLARE @codp INT,
			@codb INT,
			@codf INT
		SET @codp = (SELECT cod FROM prova WHERE prova=@prova)
		SET @codf =(SELECT id FROM fase WHERE nome=@fase)

		INSERT INTO @tabelaDesempenho(Codigo,Nome,Pais,Resultado)
		SELECT atl.cod,atl.nome,ps.nome,pc.resultado FROM prova_corrida pc 
		INNER JOIN prova p
		ON pc.cod_prova=p.cod
		INNER JOIN fase f
		ON pc.cod_fase=f.id
		INNER JOIN atleta atl
		ON pc.cod_atleta=atl.cod
		INNER JOIN pais ps
		ON atl.cod_pais=ps.cod
		WHERE
		p.cod=@codp AND f.id=@codf
	RETURN
END

--função que calcula o total de notas que devem ser inseridas naquela prova
create function fn_qtacountprova(@tipo int, @cod int)
returns int
as
begin
	if (@tipo = 1)
	begin
		return ((select count(cod) from atleta where sexo = (select sexo from prova where cod = @cod))*6)
	end
		return (select count(cod) from atleta where sexo = (select sexo from prova where cod = @cod))
end

---tabela de provas com finais
create function fn_pesquisafinal()
returns @tabelaFinal table(
prova varchar(50))
as
begin
	INSERT INTO @tabelaFinal(prova)
	(select p.prova from desempenho d, prova p
	where d.cod_prova = p.cod
	group by p.prova, d.cod_prova, p.tipo
	having count(d.cod_prova) >= (dbo.fn_qtacountprova(p.tipo, d.cod_prova)))
	return
end

select * FROM dbo.fn_pesquisaFinal() as tabela

-----selects para os finalistas
create function fn_maiorvalor(@prova int, @atleta int)
returns decimal (7, 2)
as
begin
return (select top 1 d.resultado from desempenho d
where d.cod_atleta = @atleta and d.cod_prova = @prova
order by cast(d.resultado as int) desc)
end

print dbo.fn_maiorvalor(2, 1)

---select para o tipo 1
select a.nome, cast(d.resultado as decimal(7, 2)) from desempenho d, atleta a
where d.cod_prova = 2 and a.cod = d.cod_atleta and cast(d.resultado as decimal(7, 2)) = dbo.fn_maiorvalor(d.cod_prova, d.cod_atleta)
order by cast(d.resultado as decimal(7, 2)) desc

---select´para o tipo 2
select a.nome, cast(d.resultado as datetime) from desempenho d, atleta a
where d.cod_prova = 8 and a.cod = d.cod_atleta 
order by cast(d.resultado as datetime) desc

--select atletas
create alter function fn_pesquisaatleta(@prova varchar(50))
returns @tabelaAtleta table(
nome varchar(50),
cod int)
as
begin
declare @cod_prova int,  @sexo varchar(1)
set @cod_prova = (select cod from prova where prova = @prova)
set @sexo = (select sexo from prova where cod = @cod_prova)
INSERT INTO @tabelaAtleta(cod, nome)
(select cod, nome from atleta where sexo = @sexo)
return
end

select * FROM dbo.fn_pesquisaatleta('100m / 100m') as tabela

---

create alter function fn_checaadicionado(@atleta int, @fase int, @prova int, @bateria int, @salto int)
returns bit
as
begin
	if((select cod_bateria from desempenho	where cod_atleta = @atleta and cod_fase = @fase and @bateria = cod_bateria 
	and ((@salto)-1) = salto) = @bateria)
	begin
		return 0
	end
	return 1
end

print dbo.fn_checaadicionado(1, 1, 2, 1, 3)