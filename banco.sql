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
$$ LANGUAGE plpgsql;
