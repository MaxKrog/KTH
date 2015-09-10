/* 
1. Create a view that contains isbn and title of all the books in the database. 
Then query it to list all the titles and isbns. 
Then delete (drop) the new view. 
Why might this view be nice to have?
*/

/* Create a view that contains isbn and title of all the books in the database. */
CREATE VIEW summary AS(
	SELECT isbn, title
	FROM books JOIN editions
	ON books.book_id = editions.book_id);

/* Then query it to list all the titles and isbns.  */
SELECT * from summary;

/* Then delete (drop) the new view. Why might this view be nice to have? */
DROP VIEW summary;


/* 
2. Try to insert into editions a new tuple ('5555', 12345, 1,59, '2012-12-02'). 
Explain what happened. 
*/

INSERT INTO editions
VALUES ('5555', 12345, 1,59, '2012-12-02')
;

/* 
Editions has a foreign key constraint on book_id (12345)
*/

/*
3. Try to insert into editions a new tuple only setting its isbn='5555'. 
Explain what happened.
*/

INSERT INTO editions
VALUES ('5555');

/* Editions has a Check Constraint on book_id and edition not being null. */

/* 
4. Try to first insert a book with (isbn, title) of (12345, 'How I Insert') then
One into editions as in 2. 
Show that this worked by making an appropriate query of the database. 
Why do we not need an author or subject?
*/

INSERT INTO books
VALUES (12345, 'How I Insert');

INSERT INTO editions
VALUES ('5555', 12345, 1, 59, '2012-12-02');

SELECT isbn, title, edition
FROM books, editions
WHERE books.book_id = 12345 AND editions.book_id = 12345;


/* 5. Update the new book by setting the subject to 'Mystery' */

UPDATE books
SET subject_id = (
	SELECT subject_id
	FROM subjects
	WHERE subject = 'Mystery')
WHERE book_id = 12345;

/* 6. Delete the new tuple from books. Explain what happens */

DELETE FROM books
where book_id = 12345;
/* An error is thrown because the book_id is still referenced as a foreign key from editions */

/* 7. Delete both new tuples from step 4 and query the database to confirm */

DELETE FROM editions
WHERE book_id = 12345;

DELETE FROM books
WHERE book_id = 12345;

SELECT isbn, title, edition
FROM books, editions
WHERE books.book_id = 12345 OR editions.book_id = 12345;


/* 8. Now insert a book with (isbn, title, subject_id) of (12345, 'How I Insert', 3443).
Explain what happened */

INSERT INTO books
VALUES (12345, 'How I Insert', NULL, 3443);
/* subject_id of 3443 is not present in subjects. This is a foreign key with a constraint */

ALTER TABLE books
	ADD CONSTRAINT hasSubject CHECK(
	 subject_id NOTNULL
	 )

	;
