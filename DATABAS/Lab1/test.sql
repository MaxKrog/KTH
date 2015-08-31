/* Who wrote "The Shining?" */
/* Answer: King, Stephen */

SELECT first_name, last_name
	FROM authors 
	WHERE author_id = (SELECT author_id FROM books WHERE books.title = 'The Shining');

/* Which titles are written by Paulette Bourgeois? 
Answer: Franklin in the dark */

SELECT title 
FROM books
WHERE author_id = (
	SELECT author_id 
	FROM authors 
	WHERE first_name = 'Paulette' 
		AND last_name = 'Bourgeois');

/* Who bought books about “Horror”?
Answer: Morrill, Royce Jackson, Annie
Holloway, Adam Black, Jean
King, Jenny Anderson, Jonathan Gould, Ed
Becker, Owen Brown, Chuck
*/

SELECT last_name, first_name
FROM customers
WHERE customer_id IN (
	SELECT customer_id
	FROM shipments
	WHERE isbn IN (
		SELECT isbn
		FROM editions
		WHERE book_id IN (
			SELECT book_id
			FROM books
			WHERE subject_id = (
				SELECT subject_id
				FROM subjects
				WHERE subject = 'Horror')
			)
		)
	);




/* Which book has the largest stock?
Answer: Dune
*/

SELECT title
FROM books
WHERE book_id = (
	SELECT book_id
	FROM editions
	WHERE isbn = (
		SELECT isbn
		FROM stock
		WHERE stock = (
			SELECT max(stock)
			FROM stock)
		)
	);

/* 
How much money has Booktown collected for the books about Science Fiction?
They collect the retail price of each book shiped.
Answer: 137.80
*/

SELECT SUM(retail_price)
FROM stock
WHERE isbn IN (
	SELECT isbn
	FROM shipments
	WHERE isbn IN (
		SELECT isbn
		FROM editions
		WHERE book_id IN(
			SELECT book_id
			FROM books
			WHERE subject_id = (
				SELECT subject_id
				FROM subjects
				WHERE subject = 'Science Fiction'
				)
			)
		)
	);
