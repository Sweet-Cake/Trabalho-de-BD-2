create trigger t_protegeresultadocs
on prova_cs
for delete, update
as
begin
	rollback transaction
	raiserror('Não é possivel excluir o resultado', 16, 1)
end

create trigger t_protegeresultadocorrida
on prova_corrida
for delete, update
as
begin
	rollback transaction
	raiserror('Não é possivel excluir o resultado', 16, 1)
end

create trigger t_protegeatleta
on atleta
for delete, update
as
begin
	rollback transaction
	raiserror('Não é possivel excluir o atleta', 16, 1)
end

create trigger t_protegepais
on pais
for delete, update
as
begin
	rollback transaction
	raiserror('Não é possivel excluir o pais', 16, 1)
end

delete atleta
where cod=6

disable trigger t_protegeresultadocs on prova_cs
disable trigger t_protegeresultadocorrida on prova_corrida
disable trigger t_protegeatleta on atleta
disable trigger t_protegepais on pais


----Trigger para garantir que não sejam adicionadas notas da fase final antes da hora, trigger temporária
----A função fn_qtacountprova deve ser criada antes
create trigger tr_verificafinal on desempenho 
for insert
as
begin
	declare @fase int, 
		    @prova int
	set @fase = (select cod_fase from inserted)
	set @prova = (select cod_prova from inserted)
	if (@fase = 2)
	begin
		if ((select count(d.cod_prova) from desempenho d where  d.cod_prova = @prova) < (dbo.fn_qtacountprova((select tipo from prova where cod = @prova), @prova)))
		begin
			rollback transaction
			raiserror('Não é possivel adicionar nota na parte final no momento', 16, 16)
		end
	end
end

