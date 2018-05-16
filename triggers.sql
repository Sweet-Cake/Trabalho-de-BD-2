create trigger t_protegeresultadocs
on prova_cs
for delete, update
as
begin
	rollback transaction
	raiserror('N�o � possivel excluir o resultado', 16, 1)
end

create trigger t_protegeresultadocorrida
on prova_corrida
for delete, update
as
begin
	rollback transaction
	raiserror('N�o � possivel excluir o resultado', 16, 1)
end

create trigger t_protegeatleta
on atleta
for delete, update
as
begin
	rollback transaction
	raiserror('N�o � possivel excluir o atleta', 16, 1)
end

create trigger t_protegepais
on pais
for delete, update
as
begin
	rollback transaction
	raiserror('N�o � possivel excluir o pais', 16, 1)
end

delete atleta
where cod=6

disable trigger t_protegeresultadocs on prova_cs
disable trigger t_protegeresultadocorrida on prova_corrida
disable trigger t_protegeatleta on atleta
disable trigger t_protegepais on pais


----Trigger para garantir que n�o sejam adicionadas notas da fase final antes da hora, trigger tempor�ria

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
		if ((select count(d.cod_prova) from desempenho d where  d.cod_prova = @prova) < (select count(cod) from atleta where sexo = (select sexo from prova where cod = @prova)))
		begin
			rollback transaction
			raiserror('N�o � possivel adicionar notas da fase final nessa prova no momento', 16, 16)
		end
	end
end
