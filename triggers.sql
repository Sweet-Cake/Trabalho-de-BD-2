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