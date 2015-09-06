/* 
1. Create a view that contains isbn and title of all the books in the database. 
Then query it to list all the titles and isbns. 
Then delete (drop) the new view. 
Why might this view be nice to have?
*/

CREATE VIEW summary AS(
	SELECT isbn, title
	FROM books JOIN editions
	ON books.book_id = editions.book_id);

SELECT * from summary;

DROP VIEW summary;


/* 
2. Try to insert into editions a new tuple ('5555', 12345, 1,59, '2012-12-02'). 
Explain what happened. 
*/

INSERT INTO editions
VALUES ('5555', 12345, 1,59, '2012-12-02')
;

/* 
Since there is no book_id = '5555' in books this insert is not allowed.
There is a foreign key constraint.
*/

/*
3. Try to insert into editions a new tuple only setting its isbn='5555'. 
Explain what happened.
*/

INSERT INTO editions
VALUES ('5555');

/* Some fail on integrity */

