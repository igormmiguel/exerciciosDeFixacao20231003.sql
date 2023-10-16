CREATE OR REPLACE FUNCTION total_livros_por_genero(genre_name text) RETURNS integer AS $$
DECLARE
  total_count integer;
BEGIN
  total_count := 0;
  FOR livros IN
    SELECT * FROM books WHERE genre = genre_name
  LOOP
    total_count := total_count + 1;
  END LOOP;
  RETURN total_count;
END;



--- 2

CREATE OR REPLACE FUNCTION listar_livros_por_autor(
    first_name text, 
    last_name text
) RETURNS SETOF text AS $$
DECLARE
  book_title text;
  book_cursor CURSOR FOR
    SELECT b.title
    FROM Livro_Autor la
    JOIN Livro b ON la.livro_id = b.id
    JOIN Autor a ON la.autor_id = a.id
    WHERE a.first_name = first_name AND a.last_name = last_name;
BEGIN
  OPEN book_cursor;
  LOOP
    FETCH book_cursor INTO book_title;
    EXIT WHEN NOT FOUND;
    RETURN NEXT book_title;
  END LOOP;
  CLOSE book_cursor;
END;

---3
CREATE OR REPLACE FUNCTION atualizar_resumos() RETURNS void AS $$
DECLARE
    livro_record Livro%ROWTYPE;
BEGIN
    FOR livro_record IN SELECT * FROM Livro LOOP
        UPDATE Livro 
        SET resumo = CONCAT(resumo, ' livro bom!') 
        WHERE id = livro_record.id;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
