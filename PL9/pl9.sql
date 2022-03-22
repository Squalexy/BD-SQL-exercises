-- ex3
CREATE OR REPLACE PROCEDURE public.ex3(p_livro numeric)
LANGUAGE 'plpgsql'
AS $BODY$
begin
	if NOT exists(select 1 from autores where id_autor=80) then
		INSERT INTO autores (id_autor, nome, morada, sexo, nacionalidade, genero)
		values(80, 'Luis Morenos Campos', 'Lisboa', 'M', 'Portuguesa', 'Informatica');
	end if;
	
	if exists(select 1 from livros where id_autor = 17 and id_livro = p_livro) then
		update livros set id_autor = 80 where id_livro = p_livro;
	end if;
	
end;
$BODY$
call ex3(5);



-- ex5

CREATE OR REPLACE PROCEDURE public.ex5a(p_livro numeric)
LANGUAGE 'plpgsql'
AS $BODY$
	declare 
	v_preco livros.preco%type;
	c1 cursor for 
		select preco
		from livros
		where genero not in ('Aventura') and id_livro = p_livro
		for update;
	begin
		open c1;
		loop;
			fetch c1 into v_preco;
			exit when not found;
			if v_preco < 25 then
				update livros set preco = preco * 1.1 where current pf c1;
			else
				update livros set preco = preco * 1.06 where current of c1;
			end if;
		end loop;
		close c1;
end;
$BODY$


-- ex8

do $$
declare
	v_id_livro livros.id_livro%type;
	v_preco livros.preco%type;
	c1 cursor for
		select id_livro,preco
		from livros
		where genero in ('Aventura','Romance') and preco<=50
		for update;
begin
	open c1;
	loop
		fetch c1 into v_id_livro,v_preco;
		exit when not found;
		if v_preco<=25 then
			update livros set preco=preco*1.1 where current of c1;
		else if v_preco >
			update livros set preco=preco*1.06 where current of c1;
		end if;
	end loop;
end;
$$;