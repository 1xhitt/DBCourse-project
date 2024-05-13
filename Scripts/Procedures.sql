-- SELECT id FROM person;
CREATE OR REPLACE PROCEDURE RemovePerson(PersonID INTEGER)
LANGUAGE sql
AS $$
    DELETE FROM game_ownership WHERE person_id=PersonID;
    DELETE FROM time_spaces WHERE person_id=PersonID;
    DELETE FROM person WHERE id=PersonID;
$$;

CALL RemovePerson(2);
-- SELECT id FROM person;


-- SELECT game_id FROM game_ownership where person_id=2;
-- SELECT game_id FROM game_ownership where person_id=9;
CREATE OR REPLACE PROCEDURE TransferGame(Giver INTEGER, Receiver INTEGER, GameID INTEGER)
LANGUAGE sql
AS $$
    DELETE FROM game_ownership WHERE game_id=GameID and person_id=Giver;
    INSERT INTO game_ownership(game_id, person_id) VALUES(GameId, Receiver);
$$;
-- call TransferGame(9, 2, 10);
-- SELECT game_id FROM game_ownership where person_id=2;
-- SELECT game_id FROM game_ownership where person_id=9;
CREATE OR REPLACE PROCEDURE RemoveVendor(VendorID INTEGER)
    LANGUAGE sql
AS $$
DELETE FROM vendor_offerings WHERE vendor_id=VendorID;
DELETE FROM vendor WHERE id=VendorID;
$$;
