-- ex2

CREATE OR REPLACE PROCEDURE public.ficha10Ex2()
LANGUAGE 'plpgsql'
AS $BODY$
declare
		v_id_autor livros.id_autor%type;
		v_autor_nome autores.nome%type;
		counter_livros numeric := 0;
		c1 cursor for
			select distinct id_autor
			from livros
			where genero = 'Informatica';
	begin
	
		open c1;
		loop
			fetch c1 into v_id_autor;
			exit when not found;
      
      select count(*) from livros where id_autor = v_id_autor into counter_livros;
      select nome from autores where id_autor = v_id_autor into v_autor_nome;
      
      Insert into temp values(v_id_autor, counter_livros, reverse(v_autor_nome));
      
      
      end loop;
		close c1;
		
end;
$BODY$;

CALL ficha10Ex2();

-- ex4

CREATE OR REPLACE PROCEDURE public.ficha10Ex4(p_livro numeric)
LANGUAGE 'plpgsql'
AS $BODY$
	begin	
		insert into temp (col1, message) SELECT preco, titulo FROM livros WHERE preco > p_livro;
end;
$BODY$;

CALL ficha10Ex4(20);

-- ex5

create or replace procedure ex4m(p_livro livros.id_livro%type) language plpgsql
as $$
declare
v_id_livro livros.id_livro%type;
v_id_autor livros.id_autor%type; 

begin

select id_livro,id_autor
into strict v_id_livro,v_id_autor from livros
where id_livro=p_livro;

if v_id_autor=17 then 
	insert into autores (id_autor,nome,morada,sexo,nacionalidade,genero) values(80,'Luís Moreno Campos','Lisboa','M','Portuguesa', 'Informática');
 end if;
 exception
 when unique_violation then
       insert into erros (cod,msg,t) values(sqlstate,sqlerrm,current_date);
	     update livros set id_autor=80 where id_livro=v_id_livro;
 when others then
        insert into erros (cod,msg,t) values(sqlstate,sqlerrm,current_date);
		RAISE 'No ID: %', p_livro USING ERRCODE = 'Erro 98989';
 end;
$$;

