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
CREATE TABLE prova_corrida(
	cod_prova INT,
	cod_atleta INT,
	cod_fase INT,
	resultado DATETIME,
	PRIMARY KEY(cod_prova, cod_atleta, cod_fase),
	FOREIGN KEY (cod_prova) REFERENCES prova(cod),
	FOREIGN KEY (cod_atleta) REFERENCES atleta(cod),
	FOREIGN KEY (cod_fase) REFERENCES fase(id)
)

select *from prova_corrida
INSERT INTO prova_corrida VALUES
(2,2,2,'01:15:10:000'),
(2,2,1,'01:15:10:000')

select SUBSTRING(CONVERT(VARCHAR,resultado,114),1,12) as HORA FROM prova_corrida

CREATE TABLE prova_cs(
	cod_prova INT NOT NULL,
	cod_atleta INT NOT NULL,
	cod_fase INT NOT NULL,
	cod_bateria INT NOT NULL,
	resultado DECIMAl(7,2),
	PRIMARY KEY(cod_prova, cod_atleta,cod_fase,cod_bateria),
	FOREIGN KEY (cod_prova) REFERENCES prova(cod),
	FOREIGN KEY (cod_atleta) REFERENCES atleta(cod),
	FOREIGN KEY (cod_fase) REFERENCES fase(id),
	FOREIGN KEY (cod_bateria) REFERENCES bateria(id)
)

select * from prova_cs

CREATE TABLE recorde(
cod_prova INT NOT NULL,
cod_atleta INT NOT NULL,
resultado DECIMAL (7, 2),
PRIMARY KEY (cod_prova, cod_atleta),
FOREIGN KEY (cod_prova) REFERENCES prova(cod),
FOREIGN KEY (cod_atleta) REFERENCES atleta(cod)
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
('Arm', 'Armenia'),
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
('Lançamento de Dado / Javelin Throw', 'F', 1),
('Salto em Distancia / Long Jump', 'M', 1),
('Salto com Vara / Pole Vault', 'M', 1),
('Salto com Vara / Pole Vault', 'M', 1),
('Arremesso de Peso / Shot Put', 'F', 1),
('Lançamento do Disco / Discus Throw', 'M', 1),
('Salto Triplo ', 'F', 1),
('400m com Barreiras / 400m Hurdles', 'M', 2),
('100m / 100m', 'F', 2),
('100m / 100m', 'M', 2),
('3000m / 3000m', 'M', 2),
('3000m com obstaculo / 3000m Steeplechase', 'F', 2),
('400m / 400m', 'M', 2),
('800m / 800m', 'F', 2),
('800m / 800m', 'M', 2),
('200m / 200m', 'F', 2),
('200m / 200m', 'M', 2)
select * from atleta
INSERT INTO atleta VALUES
('AFG', 'Skender Halil', 'M'),
('AFG', 'Moema Partha', 'F'),
('ALB', 'Rosenda Mouses', 'F'),
('ALB', 'Macsen Betania', 'M'),
('ALG', 'Tanja Emilija', 'F'),
('ALG', 'Eudocia Erlendr', 'M'),
('AND', 'Bradley Jodocus', 'M'),
('AND', 'Bozhidara Katrina', 'M')


INSERT INTO bateria VALUES
(1, '1ºCiclo'),
(2, '2ºCiclo'),
(3, '3ºCiclo'),
(4, '4ºCiclo'),
(5, '5ºCiclo'),
(6, '6ºCiclo')


-------------

CREATE alter PROCEDURE sp_adiciona(@prova VARCHAR(50), @cod_atleta INT, @cod_fase INT,
							 @bateria VARCHAR(50), @resultado VARCHAR(50))
AS
	DECLARE @cod_prova INT, @cod_bateria INT
	DECLARE @sexo VARCHAR(1), @tipo int
	declare @salto int
	SET @sexo = (SELECT sexo FROM atleta where cod = @cod_atleta)
	SET @cod_prova = (SELECT cod FROM prova WHERE prova = @prova and sexo = @sexo)
	SET @cod_bateria = (SELECT id FROM bateria WHERE nome = @bateria)
	set @tipo = (select tipo from prova where cod = @cod_prova)
	set @salto = ((select count(cod_atleta) from desempenho where cod_fase = @cod_fase and cod_atleta = @cod_atleta and cod_prova = @cod_prova)+1)
	Begin try
	if (@tipo = 1)
	begin
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
	exec sp_verifrecordeC @resultado, @tipo, @cod_prova, @cod_atleta
	end try
	begin catch
		raiserror('Erro já inserido', 16, 16)
	end catch
	
-------------

CREATE PROCEDURE sp_adiciona(@prova VARCHAR(50), @cod_atleta INT, @cod_fase INT,
							 @bateria VARCHAR(50), @resultado VARCHAR(50))
AS
	DECLARE @cod_prova INT, @cod_bateria INT
	DECLARE @sexo VARCHAR(1), @tipo int
	declare @salto int
	SET @sexo = (SELECT sexo FROM atleta where cod = @cod_atleta)
	SET @cod_prova = (SELECT cod FROM prova WHERE prova = @prova and sexo = @sexo)
	SET @cod_bateria = (SELECT id FROM bateria WHERE nome = @bateria)
	set @tipo = (select tipo from prova where cod = @cod_prova)
	set @salto = ((select count(cod_atleta) from desempenho where cod_fase = @cod_fase and cod_atleta = @cod_atleta and cod_prova = @cod_prova)+1)

	if (@tipo = 1)
	begin
		if((select count(cod_atleta) from desempenho where cod_fase = @cod_fase and cod_atleta = @cod_atleta and cod_prova = @cod_prova) > 5)
	begin
			raiserror('Atleta já inserido', 16, 16)
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
