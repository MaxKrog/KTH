DROP FUNCTION somename() CASCADE;
CREATE FUNCTION somename() RETURNS trigger AS $pname$
	BEGIN

		IF 0 = (SELECT stock FROM stock WHERE isbn = NEW.isbn) THEN
			RAISE EXCEPTION 'There is no stock to ship';

		ELSE
			UPDATE STOCK
			SET stock = stock - 1
			WHERE isbn = NEW.isbn;

		END IF;
		RETURN NEW;
	END;
$pname$ LANGUAGE plpgsql;




CREATE TRIGGER reduceStock
	BEFORE INSERT ON shipments
	FOR EACH ROW
		EXECUTE PROCEDURE somename()

	;



/* Shipments: shipment_id, customer_id, isbn, ship_date */
/* Stock: isbn, cost, retail_proce, stock */

SELECT * 
FROM STOCK
;

INSERT INTO shipments
VALUES (2000, 860, '0394900014', '2012-12-07')
;
SELECT * FROM shipments WHERE shipment_id = 2000;

INSERT INTO shipments
VALUES(2001, 860, '044100590X', '2012-12-07')
;

SELECT * FROM shipments WHERE shipment_id = 2001;

SELECT * 
FROM stock
;

SELECT * 
FROM shipments 
WHERE shipment_id > 1999;


DELETE FROM shipments 
WHERE shipment_id > 1999
;

UPDATE stock 
SET stock = 89 
WHERE isbn = '044100590X'
;