/* 
Who wrote the shining?
Answer: King, Stephen 
*/

SELECT last_name, first_name
FROM authors
WHERE author_id = (
	SELECT author_id
	FROM books
	WHERE title = 'The Shining'
	)
;

/* Titles written by Paulette Bourgeois
Answer: Frankin in the dark
*/
SELECT title
FROM books
WHERE author_id IN (
	SELECT author_id
	FROM authors
	WHERE first_name = 'Paulette' AND last_name = 'Bourgeois'
	);

/* 
Who bourght books about horror?
Answer: Många
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
			WHERE subject_id IN (
				SELECT subject_id
				FROM subjects
				WHERE subject = 'Horror'
				)
			)
		)
	)
;

/*
4. Which book has the largest stock?
Answer: dune
*/

SELECT title
FROM books
WHERE book_id = (
	SELECT book_id
	FROM (
		SELECT sum(stock) AS totalStock, book_id
		FROM(
			SELECT stock.stock, stock.isbn, book_id
			FROM stock INNER JOIN (
				SELECT books.book_id, isbn
				FROM books, editions
				WHERE books.book_id = editions.book_id
				) AS book_isbn
				ON stock.isbn = book_isbn.isbn
		) AS blajj
		GROUP BY book_id
		ORDER BY totalStock DESC
	) as yo
	LIMIT 1 
)
;

/*
5. How  much  money  has  Booktown  collected  for  the  books  about  Science  Fiction?
They collect the retail price of each book shipped.
Answer: 137.80
*/

SELECT sum(retail_price)
FROM stock
WHERE isbn IN (
	SELECT shipments.isbn
	FROM shipments, editions
	WHERE shipments.isbn = editions.isbn AND book_id IN(
		SELECT book_id
		FROM books
		WHERE subject_id = (
			SELECT subject_id
			FROM subjects
			WHERE subject = 'Science Fiction'
		)
	)
);

/*
6. Which books have been sold to only two people?
Note  that  some  people  buy  more  than  one  copy  and  some  books  appear  as 
several editions.
Answer: Dune, Little Women, The Velveteen Rabbit, 2001: A Space oddysey
*/

SELECT title
FROM books
WHERE book_id IN (
	SELECT book_id
	FROM (
		SELECT book_id, customer_id
		FROM editions JOIN shipments
			ON editions.isbn = shipments.isbn

		GROUP BY book_id, customer_id
	) AS A
	GROUP BY book_id
	HAVING count(book_id) = 2
);

/* 7. Which publisher has sold the most to Booktown?
Note  that all shipped books were sold at ‘cost’ to as well as all the books in the stock.
Answer: Ace Books, 4566.00
*/
SELECT name, totalRevenue
FROM publishers INNER JOIN(
	SELECT publisher_id, totalRevenue
	FROM(
		SELECT publisher_id, sum(revenue) as totalRevenue
		FROM(
			SELECT publisher_id , afterCalc.isbn, afterCalc.revenue
			FROM editions INNER JOIN(
				SELECT isbn, (beforeCalc.stock + beforeCalc.soldBooks) * beforeCalc.cost as revenue
				FROM(
					SELECT alreadyShipped.isbn, stock, alreadyshipped.soldBooks, stock.cost
					FROM stock INNER JOIN (
						SELECT isbn, count(*) as soldBooks
						FROM shipments
						GROUP BY isbn
					) AS alreadyShipped
					ON stock.isbn = alreadyShipped.isbn
				) AS beforeCalc
			) AS afterCalc
			ON editions.isbn = afterCalc.isbn
		) AS BAJS
		GROUP BY publisher_id
		ORDER BY totalRevenue DESC
	) AS ORKA
	LIMIT 1
) AS ORKAORKA
ON publishers.publisher_id = ORKAORKA.publisher_id
;

/*
8. How much money has booktown earned (so far)?
Explain how to reason about income/costs.
Possible answer: -12789.85
*/

SELECT sum(infoTable.timesSold * ( infoTable.retail_price - infoTable.cost) - (infoTable.cost * infoTable.stock) ) as NAGOT
FROM(
	SELECT alreadyShipped.isbn, stock.stock, stock.cost, stock.retail_price, alreadyShipped.timesSold
	FROM stock INNER JOIN(
		SELECT isbn, count(*) AS timesSold
		FROM shipments
		GROUP BY isbn
	) AS alreadyShipped
	ON stock.isbn = alreadyShipped.isbn
) as infoTable
;

/*
9. Which customers bought books about ATLEAST three subjects ?
Answer: Jackson, Annie
*/

SELECT last_name, first_name
FROM customers
WHERE customer_id = (
	SELECT shipEdit.customer_id
	FROM books INNER JOIN (
		SELECT shipments.isbn, shipments.customer_id, editions.book_id
		FROM shipments FULL JOIN editions
		ON shipments.isbn = editions.isbn
	) AS shipEdit
	ON books.book_id = shipEdit.book_id
	GROUP BY subject_id, customer_id
	HAVING COUNT(customer_id) >= 3
)
;


/*
10. Which subjects have not sold any books?
Answer: Många
*/

SELECT subject 
FROm subjects
WHERE subject_id NOT IN( /* GET ALL SUBJECT_IDs FROM BOOK_IDS */
	SELECT subject_id
	FROM books
	WHERE book_id IN ( /* CONVERT ISBN TO BOOK_ID */
		SELECT book_id
		FROM editions
		WHERE isbn IN ( /* GET ALL SOLD BOOKS ISBN */
			SELECT isbn
			FROM shipments
		)
	)
);
	
