--pesquisa salto
create alter function fn_maiorvalor(@prova int, @atleta int)
returns decimal (7, 2)
as
begin
return (select top 1 dbo.fn_convertemetro(d.resultado) from desempenho d
where d.cod_atleta = 2 and d.cod_prova = 5
order by dbo.fn_convertemetro(d.resultado)  desc)
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
		set @valor = '00:00:00:000'
	end
	else
	begin
		set @valor = cast(@resultado as datetime)
	end
	return @valor
end

select top 3 a.nome, dbo.fn_convertehora(d.resultado) from desempenho d, atleta a
where d.cod_prova = 8 and a.cod = d.cod_atleta 
order by dbo.fn_convertehora(d.resultado) desc