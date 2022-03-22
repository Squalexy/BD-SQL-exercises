-- ex1

select * from temp;
select * from livros;

select genero, preco, id_autor from livros
order by 3 ;


delete  from temp 
    where 1=1;

select genero, preco
        from livros
        order by genero;


CREATE or replace PROCEDURE f11_e1()
LANGUAGE plpgsql as $$
declare 
begin
    delete from temp;
    insert into temp
        (select sum(preco), count(*), genero
            from livros 
            group by genero);
end;
$$;


call f11_e1();


-- ex2

CREATE or replace function f11_e2() returns TRIGGER
LANGUAGE plpgsql as $$
declare 
begin
    delete from temp;
    insert into temp
        (select sum(preco), count(*), genero
            from livros 
            group by genero);
    return null;
end;
$$;

CREATE TRIGGER update_temp
after insert or update of genero, preco or delete on livros
for each STATEMENT
--when (new.genero != old.genero or new.preco != old.preco)
EXECUTE PROCEDURE f11_e2();


SELECT * from autores;

UPDATE livros set preco= 100 where preco=71;


-- ex3
CREATE or replace function f11_e3() returns TRIGGER
LANGUAGE plpgsql
as $$
DECLARE

begin 
    delete from livros 
        where id_autor = old.id_autor;
    return old;
end;
$$;

drop TRIGGER delete_books on autores;

CREATE trigger delete_books
before delete on autores
for each ROW
EXECUTE PROCEDURE f11_e3();

DELETE from autores where id_autor =1;



-- ex4

CREATE table livros_removidos 
as table livros
with no data;

alter table livros_removidos drop COLUMN id_autor;
alter table livros_removidos drop COLUMN id_editora;
alter TABLE livros_removidos add COLUMN utilizador varchar(40);
alter TABLE livros_removidos add COLUMN data DATE;

select * from livros_removidos;


create or replace function f11_e4() returns TRIGGER
language plpgsql
as $$
declare 

BEGIN
    insert into livros_removidos(id_livro,
                                    titulo,
                                    isbn,
                                    genero,
                                    paginas,
                                    preco,
                                    unidades_vendidas,
                                    data_edicao, utilizador, data)
     values(old.id_livro, old.titulo, old.isbn, old.genero, old.paginas, old.preco, old.unidades_vendidas, old.data_edicao, current_user, current_date);
    return old;
end;
$$;

drop TRIGGER log_removed_books on livros;

create TRIGGER log_removed_books
before delete on livros
for each ROW
execute PROCEDURE f11_e4();




