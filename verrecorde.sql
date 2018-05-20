CREATE TABLE recorde(
id_prova INT NOT NULL,
id_atleta INT NOT NULL,
tipoR int not null,
pais varchar(3) not null,
resultadoE VARCHAR(20),
resultadoM VARCHAR(20),
PRIMARY KEY (id_prova, tipoR),
FOREIGN KEY (id_prova) REFERENCES prova(cod),
FOREIGN KEY (id_atleta) REFERENCES atleta(cod)
)

insert into recorde(id_prova, id_atleta, tipoR,  pais, resultadoE) values
(2, 1, 1, 'AFG', 7.6)
insert into recorde(id_prova, id_atleta, tipoR, pais, resultadoM) values
(2, 1, 2, 'AFG', 10.6)
insert into recorde(id_prova, id_atleta, tipoR, pais, resultadoE) values
(12, 3, 1, 'ALB', '00:48:44:000')
insert into recorde(id_prova, id_atleta, tipoR, pais, resultadoM) values
(12, 3, 2, 'ALB', '00:45:44:000')

-----

create alter function fn_verRecordea(@prova int, @atleta int, @salto int, @fase int)
returns int
as
begin
	declare @resultado datetime
	set @resultado= (select resultado from desempenho
	where cod_atleta = @atleta and salto = @salto and cod_prova = @prova and cod_fase = @fase) 
	if ((select resultadoE from recorde where id_prova = @prova and tipoR = 1) > @resultado)
	begin
		if ((select resultadoM from recorde where id_prova = @prova and tipoR = 2) > @resultado)
		begin
			return 2
		end
		return 1
	end
	return 0
end


create alter function fn_verRecorde(@prova int, @atleta int, @salto int, @fase int)
returns int
as
begin
	declare @resultado decimal(7, 2)
	set @resultado= (select resultado from desempenho
	where cod_atleta = @atleta and salto = @salto and cod_prova = @prova and cod_fase = @fase) 
	if (@resultado > (select resultadoE from recorde where id_prova = @prova and tipoR = 1))
	begin
		if (@resultado > (select resultadoM from recorde where id_prova = 2 and tipoR = 2))
		begin
			return 2
		end
		return 1
	end
	return 0
end

----

declare @resultado decimal(7, 2), @emaior int
set @resultado= (select resultado from desempenho
where cod_atleta = 1 and salto = 1 and cod_prova = 2 and cod_fase = 1) 
set @emaior = dbo.fn_verRecorde(2, 1, 1, 1)
	print @emaior
if (@resultado > (select resultadoE from recorde where id_prova = 2 and tipoR = 1))
begin
	update recorde
	set resultadoE = @resultado where id_prova = 2 and tipoR = 1
	if (@resultado > (select resultadoM from recorde where id_prova = 2 and tipoR = 2))
	begin
		update recorde
		set resultadoM = @resultado, 
		where id_prova = 2 and tipoR = 2
	end
end

create alter procedure sp_verificaRecorde(@prova int, @atleta int, @salto int, @fase int,@tipo int)
as
	declare @emaior int
	if (@tipo = 2)
	begin
		declare @resultadoC datetime
		set @resultadoC = (select resultado from desempenho
		where cod_atleta = @atleta and salto = @salto and cod_prova = @prova and cod_fase = @fase) 
		set @emaior = dbo.fn_verRecordea(@prova, @atleta, @salto, @fase)
			print @emaior
		if (@emaior != 0)
		begin
			update recorde
			set resultadoE = @resultadoC, 
			pais = (select cod_pais from atleta where cod = @atleta)
			where id_prova = @prova and tipoR = 1
			if (@emaior = 2)
			begin
				select cod_pais from atleta where cod = @atleta
				update recorde 
				set resultadoM = @resultadoC,
				pais = (select cod_pais from atleta where cod = @atleta) 
				where id_prova = @prova and tipoR = 2
			end
		end
	end
	else
	begin
		declare @resultadoS decimal(7, 2)
		set @resultadoS = (select resultado from desempenho
		where cod_atleta = @atleta and salto = @salto and cod_prova = @prova and cod_fase = @fase) 
		set @emaior = dbo.fn_verRecorde(@prova, @atleta, @salto, @fase)
			print @emaior
		if (@resultadoS > (select resultadoE from recorde where id_prova = @prova and tipoR = 1))
		begin
			update recorde
			set resultadoE = @resultadoS,
			pais = (select cod_pais from atleta where cod = @atleta) 			
			where id_prova = @prova and tipoR = 1
			if (@resultadoS > (select resultadoM from recorde where id_prova = @prova and tipoR = 2))
			begin
				update recorde
				set resultadoM = @resultadoS, 
				pais = (select cod_pais from atleta where cod = @atleta) 
				where id_prova = @prova and tipoR = 2
			end
		end

end

exec sp_verificaRecorde 12, 3, 1, 1, 2
exec sp_verificaRecorde 2, 1, 1, 1, 1

-------
select * from recorde

update recorde
set resultadoE = '12:12:12', pais = 'AFG' 
where id_prova = 12 and tipoR = 1
update recorde
set resultadoM = '12:12:12', pais = 'AFG'  
where id_prova = 12 and tipoR = 2
update recorde
set resultadoE = '25', pais = 'AAA'  where id_prova = 2 and tipoR = 1
update recorde
set resultadoM = '80', pais = 'AAA'  where id_prova = 2 and tipoR = 2