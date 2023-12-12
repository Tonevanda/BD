--Levantar erro se tentar adicionar uma equipa com um treinador já em outra equipa
CREATE TRIGGER checkInsertTreinador
Before insert on Equipa   
For each row
When new.idTreinador=(select idTreinador from equipa where idTreinador=new.idTreinador)
Begin
	Select raise(abort,"invalid insert-The Coach is already on an existing team");
end;
