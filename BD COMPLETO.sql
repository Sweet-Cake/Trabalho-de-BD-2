CREATE DATABASE atletismo
GO
USE atletismo


CREATE TABLE pais(
	cod VARCHAR(3) NOT NULL,
	nome VARCHAR(100),
	PRIMARY KEY(cod)
)
CREATE TABLE atleta(
	cod INT IDENTITY NOT NULL,
	cod_pais VARCHAR(3),
	nome VARCHAR (100),
	sexo VARCHAR(1),
	PRIMARY KEY(cod),
	FOREIGN KEY (cod_pais) REFERENCES pais(cod)
)
CREATE TABLE prova(
cod INT IDENTITY NOT NULL,
prova VARCHAR(50) NOT NULL,
sexo varchar(1) NOT NULL,
tipo INT NOT NULL,
PRIMARY KEY (cod)
)

CREATE TABLE prova_atleta(
cod_prova INT NOT NULL,
cod_atleta INT NOT NULL,
resultado DECIMAL (7, 2),
PRIMARY KEY(cod_prova, cod_atleta),
FOREIGN KEY (cod_prova) REFERENCES prova(cod),
FOREIGN KEY (cod_atleta) REFERENCES atleta(cod)
)
CREATE TABLE fase(
	id INT NOT NULL,
	nome VARCHAR(10),
	PRIMARY KEY (id)
)
CREATE TABLE bateria(
	id INT NOT NULL,
	nome VARCHAR (10),
	PRIMARY KEY (id)
)
INSERT INTO fase VALUES
(1,'INICIAL'),
(2,'FINAL')

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

CREATE TABLE recorde(
id_prova INT NOT NULL,
nome_atleta VARCHAR(50)NOT NULL,
tipoR int not null,
pais varchar(3) not null,
resultadoE VARCHAR(20),
resultadoM VARCHAR(20),
PRIMARY KEY (id_prova, tipoR),
FOREIGN KEY (id_prova) REFERENCES prova(cod)
)

INSERT INTO pais VALUES
('AFG', 'Afeganistao'),
('ALB', 'Albania'),
('ALG', 'Argelia'),
('AND', 'Andorra'),
('ANG', 'Angola'),
('ANT', 'Antiga e Barbuda'),
('ASA', 'Samoa Americana'),
('ARG', 'Argentina'),
('ARM', 'Armenia'),
('ARU', 'Aruba'),
('AUS', 'Australia'),
('AUT', 'Austria'),
('AZE', 'Azerbaijao'),
('BAH', 'Bahamas'),
('BAN', 'Bangladesh'),
('BAR', 'Barbados'),
('BDI', 'Burundi'),
('BEL', 'Belgica'),
('BEN', 'Benim'),
('BER', 'Bermudas'),
('BHU', 'Butao'),
('BIH', 'Bosnia e Herzegovina'),
('BIZ', 'Belize'),
('BLR', 'Bielorrusia'),
('BOL', 'Bolivia'),
('BOT', 'Botswana'),
('BRA', 'Brasil')

INSERT INTO prova VALUES
('Lancamento de Dado / Javelin Throw (F)', 'F', 1),
('Salto em Distancia / Long Jump (M)', 'M', 1),
('Salto com Vara / Pole Vault (M)', 'M', 1),
('Arremesso de Peso / Shot Put (F)', 'F', 1),
('Lancamento do Disco / Discus Throw (M)', 'M', 1),
('Salto Triplo (F)', 'F', 1),
('400m com Barreiras / 400m Hurdles (M)', 'M', 2),
('100m / 100m (F)', 'F', 2),
('100m / 100m (M)', 'M', 2),
('3000m / 3000m (M)', 'M', 2),
('3000m com obstaculo / 3000m Steeplechase (F)', 'F', 2),
('400m / 400m (M)', 'M', 2),
('800m / 800m (F)', 'F', 2),
('800m / 800m (M)', 'M', 2),
('200m / 200m (F)', 'F', 2),
('200m / 200m (M)', 'M', 2)

select * from atleta
INSERT INTO atleta VALUES
('AFG', 'Skender Halil', 'M'),
('AFG', 'Moema Partha', 'F'),
('ALB', 'Rosenda Mouses', 'F'),
('ALB', 'Macsen Betania', 'M'),
('ALG', 'Tanja Emilija', 'F'),
('ALG', 'Eudocia Erlendr', 'M'),
('AND', 'Bradley Jodocus', 'M'),
('AND', 'Bozhidara Katrina', 'M'),
('AND', 'Takane Shijou', 'F'),
('ANG', 'Tenshi Momo', 'F'),
('ANG', 'Amir Singh', 'M'),
('ANT', 'Anthy Himemiya', 'F'),
('ANT', 'Stella Sunnistar', 'F'),
('ASA', 'Rod Scott', 'M'),
('ARG', 'Elena Shimamura', 'F'),
('ARM', 'Allen Gill', 'M'),
('ARU', 'Haley Burke', 'M'),
('AUS', 'Rowan Watts', 'M'),
('AUT', 'Nana Abe', 'F'),
('AZE', 'Rosetta Benheur', 'F')



INSERT INTO bateria VALUES
(1, '1ºCiclo'),
(2, '2ºCiclo'),
(3, '3ºCiclo'),
(4, '4ºCiclo'),
(5, '5ºCiclo'),
(6, '6ºCiclo')

---------------------------------------------------------------------
--Procedures e functions                                           --
---------------------------------------------------------------------

---------------converter
CREATE FUNCTION fn_convertehora(@resultado varchar(50))
returns time
as
begin
	declare @valor time
	if ((@resultado = 'DNF'))
	begin
		set @valor = '23:59:59:999'
	end
	else
	begin
		set @valor = CONVERT(datetime,@resultado,105)
	end
	return @valor
end

CREATE FUNCTION fn_convertemetro(@resultado varchar(50))
returns decimal(7, 2)
as
begin
	declare @valor decimal(7, 2)
	if ((@resultado = 'FAULT'))
	begin
		set @valor = 0.0
	end
	else
	begin
		set @valor = cast(@resultado as decimal(7, 2))
	end
	return @valor
end

-----Verifica recorde

CREATE function fn_maiorvalor(@prova int, @atleta int, @codf int)
returns decimal (7, 2)
as
begin
declare @valor decimal(7, 2)
set @valor = (select max(dbo.fn_convertemetro(resultado)) from desempenho where cod_prova = @prova and cod_atleta = @atleta and cod_fase = @codf)
return dbo.fn_convertemetro(@valor)
end


create procedure sp_verifrecordeC(@resultado varchar(50), @tipo int, @prova int, @atleta int)
as
	if (@tipo = 1)
	begin
		declare @resultadoS decimal (7,2)
		set @resultadoS = dbo.fn_convertemetro(@resultado)
		if (@resultadoS > (select resultadoE from recorde where id_prova = @prova and tipoR = 1))
		begin
			update recorde
			set resultadoE = @resultadoS,
			pais = (select cod_pais from atleta where cod = @atleta),
			nome_atleta = (select nome from atleta where cod = @atleta) 			
			where id_prova = @prova and tipoR = 1
			if (@resultadoS > (select resultadoM from recorde where id_prova = @prova and tipoR = 2))
			begin
				print @resultado
				update recorde
				set resultadoM = @resultadoS, 
				pais = (select cod_pais from atleta where cod = @atleta),
				nome_atleta = (select nome from atleta where cod = @atleta) 
				where id_prova = @prova and tipoR = 2
			end
		end
	end
	else
	begin
		declare @resultadoC time, @recordeAtual time
		print 'dokidoki'
		set @resultadoC = dbo.fn_convertehora(@resultado)
		set @recordeAtual = (select resultadoE from recorde where id_prova = @prova and tipoR = 1)
		print @recordeAtual
		if (@resultadoC < (select resultadoE from recorde where id_prova = @prova and tipoR = 1))
		begin
			print 'pukyun'
			update recorde
			set resultadoE = @resultadoC, 
			pais = (select cod_pais from atleta where cod = @atleta),
			nome_atleta = (select nome from atleta where cod = @atleta) 
			where id_prova = @prova and tipoR = 1
			declare @a time set @a = (select resultadoM from recorde where id_prova = @prova and tipoR = 2)
			print @a print @resultadoC
			if (@resultadoC < (select resultadoM from recorde where id_prova = @prova and tipoR = 2))
			begin
				print 'mugen'
				update recorde 
				set resultadoM = @resultadoC,
				pais = (select cod_pais from atleta where cod = @atleta),
				nome_atleta = (select nome from atleta where cod = @atleta) 
				where id_prova = @prova and tipoR = 2
			end
		end
	end

------adiciona notas
ALTER function fn_qtacountprova(@tipo int, @cod int)
returns int
as
begin
	if (@tipo = 1)
	begin
		return 30
	end
		return 10
end


 CREATE 
ALTER PROCEDURE sp_adiciona(@prova VARCHAR(50), @cod_atleta INT, @cod_fase INT,
							 @bateria VARCHAR(50), @resultado VARCHAR(50))
AS
	DECLARE @cod_prova INT, @cod_bateria INT
	DECLARE @sexo VARCHAR(1), @tipo int
	DECLARE
	@ErrorMessage   varchar(2000),
	@ErrorSeverity  tinyint,
	@ErrorState     tinyint

	declare @salto int
	SET @sexo = (SELECT sexo FROM atleta where cod = @cod_atleta)
	SET @cod_prova = (SELECT cod FROM prova WHERE prova = @prova and sexo = @sexo)
	SET @cod_bateria = (SELECT id FROM bateria WHERE nome = @bateria)
	set @tipo = (select tipo from prova where cod = @cod_prova)
	set @salto = ((select count(cod_atleta) from desempenho where cod_fase = @cod_fase and cod_atleta = @cod_atleta and cod_prova = @cod_prova)+1)
	Begin try
	if (@tipo = 1)
	begin
		if ((select count(cod_atleta) from desempenho where cod_fase = @cod_fase and cod_atleta = @cod_atleta and cod_prova = @cod_prova) > 0 and
		(select top 1 cod_bateria from desempenho where cod_atleta = @cod_atleta and cod_fase = @cod_fase and cod_prova = @cod_prova) != @cod_bateria
		)
		begin
			raiserror('Atleta inserido em outra bateria', 16, 16)
			return -1
		end
		if((select count(cod_atleta) from desempenho where cod_fase = @cod_fase and cod_atleta = @cod_atleta and cod_prova = @cod_prova) > 5)
	begin
			raiserror('Atleta já inserido', 16, 16)
			return -1
	end
	else
	begin
		if (cast(@resultado as decimal(7, 2)) <= 1)
		begin
			set @resultado = 'FAULT'
		end
		INSERT INTO desempenho VALUES
			(@cod_prova,@cod_atleta,@cod_bateria, @cod_fase,@salto,@resultado)
	end
	end
	else
	begin
		if((select count(cod_atleta) from desempenho where cod_fase = @cod_fase and cod_atleta = @cod_atleta and cod_prova = @cod_prova) > 0)
	begin
			raiserror('Atleta já inserido', 16, 16)
			return -1
	end
		
	else
	begin
		if ((@resultado = '') or (@resultado  = '00:00:00:000'))
		begin
			set @resultado = 'DNF'
		end
		INSERT INTO desempenho VALUES
			(@cod_prova,@cod_atleta,@cod_bateria, @cod_fase,@salto,@resultado)
	end
	end
	print 'hibiki'
	exec sp_verifrecordeC @resultado, @tipo, @cod_prova, @cod_atleta
	end try
	begin catch
		SET @ErrorMessage  = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState    = ERROR_STATE()
		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
	end catch

---listas
create procedure sp_listaatletasf(@prova varchar(50))
as
declare @cod_prova int, @tipo int
set @cod_prova = (select cod from prova where prova = @prova)
set @tipo = (select tipo from prova where prova = @prova)
if (@tipo = 1)
begin
	select top 8 a.nome, d.cod_atleta as cod from desempenho d, atleta a
	where d.cod_prova = @cod_prova and a.cod = d.cod_atleta and dbo.fn_convertemetro(d.resultado) = dbo.fn_maiorvalor(d.cod_prova, d.cod_atleta, 1)
	order by dbo.fn_convertemetro(d.resultado) desc
end
else
begin
	select top 8 a.nome, d.cod_atleta  as cod from desempenho d, atleta a
	where d.cod_prova = @cod_prova and a.cod = d.cod_atleta 
	order by dbo.fn_convertehora(d.resultado)
end


create procedure sp_verprovafinal
as
select p.prova from desempenho d, prova p
where d.cod_prova = p.cod
group by p.prova, d.cod_prova, p.tipo
having count(d.cod_prova) >= (dbo.fn_qtacountprova(p.tipo, d.cod_prova))


create function fn_pesquisaatleta(@prova varchar(50))
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


create function fn_pesquisafinal()
returns @tabelaFinal table(
prova varchar(50),
tipo int)
as
begin
	INSERT INTO @tabelaFinal(prova, tipo)
	(select p.prova, p.tipo from desempenho d, prova p
	where d.cod_prova = p.cod
	group by p.prova, d.cod_prova, p.tipo
	having count(d.cod_prova) >= (dbo.fn_qtacountprova(p.tipo, d.cod_prova)))
	return
end

---pesquisar

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
			@codf INT,
			@tipo INT
		SET @codp = (SELECT cod FROM prova WHERE prova=@prova)
		SET @codf =(SELECT id FROM fase WHERE nome=@fase)
		SET @codb=(SELECT id FROM bateria WHERE nome=@bateria)
		SET @tipo = (SELECT tipo FROM prova WHERE prova=@prova)
		IF (@tipo = 1)
		BEGIN
			INSERT INTO @tabelaDesempenho(Codigo,Nome,Pais,Resultado)
			SELECT top 30 atl.cod,atl.nome,ps.nome,d.resultado FROM desempenho d
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
			ORDER BY dbo.fn_convertemetro(d.resultado) DESC
		END
		ELSE
		BEGIN
			INSERT INTO @tabelaDesempenho(Codigo,Nome,Pais,Resultado)
			SELECT top 30 atl.cod,atl.nome,ps.nome,d.resultado FROM desempenho d
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
			ORDER BY dbo.fn_convertehora(d.resultado) ASC
		END
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
			@codf INT,
			@tipo INT
		SET @codp = (SELECT cod FROM prova WHERE prova=@prova)
		SET @codf =(SELECT id FROM fase WHERE nome=@fase)
		SET @tipo = (SELECT tipo FROM prova WHERE prova=@prova)
		IF (@tipo = 1)
		BEGIN
			INSERT INTO @tabelaProva(Codigo,Nome,Pais,Resultado)
			SELECT top 30 atl.cod,atl.nome,ps.nome,d.resultado FROM desempenho d
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
			AND dbo.fn_convertemetro(d.resultado) = dbo.fn_maiorvalor(@codp, atl.cod, @codf)
			ORDER BY dbo.fn_convertemetro(d.resultado) DESC
		END
		ELSE
		BEGIN
			INSERT INTO @tabelaProva(Codigo,Nome,Pais,Resultado)
			SELECT top 8 atl.cod,atl.nome,ps.nome,d.resultado FROM desempenho d
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
			ORDER BY dbo.fn_convertehora(d.resultado) ASC
		END
	RETURN
END