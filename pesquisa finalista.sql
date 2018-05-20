--pesquisa salto
create alter function fn_maiorvalor(@prova int, @atleta int, @codf int)
returns decimal (7, 2)
as
begin
declare @valor decimal(7, 2)
set @valor = (select max(dbo.fn_convertemetro(resultado)) from desempenho where cod_prova = @prova and cod_atleta = @atleta and cod_fase = @codf)
return dbo.fn_convertemetro(@valor)
end

CREATE alter FUNCTION fn_convertemetro(@resultado varchar(50))
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


select a.nome, dbo.fn_convertemetro(d.resultado) as resultado from desempenho d, atleta a
where d.cod_prova = 5 and a.cod = d.cod_atleta and dbo.fn_convertemetro(d.resultado) = dbo.fn_maiorvalor(d.cod_prova, d.cod_atleta)
order by dbo.fn_convertemetro(d.resultado) desc


---pesquisa corrida

CREATE FUNCTION fn_convertehora(@resultado varchar(50))
returns datetime
as
begin
	declare @valor datetime
	if ((@resultado = 'DNF'))
	begin
		set @valor = '23:59:59:999'
	end
	else
	begin
		set @valor = cast(@resultado as datetime)
	end
	return @valor
end

select top 3 a.nome, dbo.fn_convertehora(d.resultado) from desempenho d, atleta a
where d.cod_prova = 8 and a.cod = d.cod_atleta 
order by dbo.fn_convertehora(d.resultado)

--procedure da lista

create alter procedure sp_listaatletasf(@prova varchar(50))
as
declare @cod_prova int, @tipo int
set @cod_prova = (select cod from prova where prova = @prova)
set @tipo = (select tipo from prova where prova = @prova)
if (@tipo = 1)
begin
	select top 8 a.nome, d.cod_atleta as cod from desempenho d, atleta a
	where d.cod_prova = @cod_prova and a.cod = d.cod_atleta and dbo.fn_convertemetro(d.resultado) = dbo.fn_maiorvalor(d.cod_prova, d.cod_atleta)
	order by dbo.fn_convertemetro(d.resultado) desc
end
else
begin
	select top 8 a.nome, d.cod_atleta  as cod from desempenho d, atleta a
	where d.cod_prova = @cod_prova and a.cod = d.cod_atleta 
	order by dbo.fn_convertehora(d.resultado)
end
 