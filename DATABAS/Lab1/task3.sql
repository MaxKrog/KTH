DROP FUNCTION somename() CASCADE;
CREATE FUNCTION somename() RETURNS trigger AS $pname$
	BEGIN
		RAISE EXCEPTION 'Hoho';


		RETURN NULL;
	END;
$pname$ LANGUAGE plpgsql;




CREATE TRIGGER reduceStock
	BEFORE INSERT ON shipments
		EXECUTE PROCEDURE somename()

	;