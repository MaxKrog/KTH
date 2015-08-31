/* Who wrote "The Shining?" */
/* Answer: King, Stephen */

SELECT last_name, first_name
FROM authors 
WHERE author_id = (
	SELECT author_id 
	FROM books 
	WHERE books.title = 'The Shining');

/* Which titles are written by Paulette Bourgeois? 
Answer: Franklin in the dark */

SELECT title 
FROM books
WHERE author_id = (
	SELECT author_id 
	FROM authors 
	WHERE first_name = 'Paulette' AND last_name = 'Bourgeois'
	);

/* Who bought books about “Horror”?
Answer: Morrill, Royce Jackson, Annie
Holloway, Adam Black, Jean
King, Jenny Anderson, Jonathan Gould, Ed
Becker, Owen Brown, Chuck
*/

SELECT last_name, first_name
FROM customers
WHERE customer_id IN ( /* [CUSTOMER_ID] -> [NAME] */
	SELECT customer_id
	FROM shipments
	WHERE isbn IN ( /* [ISBN] -> [CUSTOMER_ID] */
		SELECT isbn
		FROM editions
		WHERE book_id IN ( /* [BOOK_ID] -> [ISBN] */
			SELECT book_id
			FROM books
			WHERE subject_id = ( /* SUBJECT_ID -> [BOOK_ID] */
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
			FROM stock
			)
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


/*
Which books have been sold to only two people?
Note that some people buy more than one copy and some books appear as several editions.
Answer: 
Dune
Little Women
The Velveteen Rabbit 
2001: A Space Odyssey

GO FROM ISBN TO BOOK ID.

*/

SELECT title /* BOOK_ID -> TITLE */
FROM books
WHERE book_id IN (
	SELECT book_id /* SELECT ONE book_id FROM TWO isbn */
	FROM shipments INNER JOIN editions
		ON shipments.isbn = editions.isbn 
	GROUP BY book_id
	HAVING count(*) = 2 /* ONLY KEEP THE BOOK_IDs THAT YOU SEE TWO TIMES */
	)
;

/*
Which publisher has sold the most to Booktown?
Note that all shipped books were sold at ‘cost’ to as well as all the books in the stock.

Answer: Ace Books, 4566.00

HITTA ANTAL BÖCKER I STOCK + SÅLDA * cost.
TA REDA PÅ VILKEN PUBLISHER MED SUM(PUBLISHERNS BÖCKER) SOM BLIR HÖGST.
*/

	SELECT sum(X.revenue) as revenue, X.publisher_id
	FROM (
		SELECT B.isbn, B.publisher_id, (A.stock + B.sold) * A.cost as revenue
		FROM stock AS A 
			INNER JOIN (
				SELECT B.isbn, C.publisher_id, count(*) as sold
				FROM shipments as B
					INNER JOIN(
						SELECT C.publisher_id, C.isbn
						FROM editions as C
						) AS C
					ON C.isbn = B.isbn

				GROUP BY C.isbn, B.isbn, C.publisher_id
			) AS B
			ON A.isbn = B.isbn
		GROUP BY A.isbn, B.publisher_id, B.isbn, B.sold
		) AS X
	GROUP BY X.publisher_id
	ORDER BY revenue DESC

	;


/* 
9. Which customers have bought books about at least three different subjects?
Answer: Jackson, Annie
*/

SELECT first_name, last_name
FROM customers
WHERE customer_id = (
	SELECT C.customer_id, count( DISTINCT B.subject_id) as subjectsCount
	FROM shipments AS C
		INNER JOIN(
			SELECT B.subject_id, B.book_id, A.isbn
			FROM books AS B
				INNER JOIN(
					SELECT A.isbn, A.book_id
					FROM editions AS A
					) AS A
				ON B.book_id = A.book_id
			) AS B
		ON B.isbn = C.isbn
	GROUP BY customer_id
	)
;






