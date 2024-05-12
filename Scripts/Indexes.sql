-- we do a lot of searching over those tables and update them once in a blue moon
CREATE INDEX prices
ON vendor_offerings (game_id);

CREATE INDEX offerings
    ON vendor_offerings (vendor_id);

CREATE INDEX game_owners
    ON game_ownership (game_id);

CREATE INDEX game_owned
    ON game_ownership (person_id);

-- DROP INDEX prices;
-- DROP INDEX offerings;
-- DROP INDEX game_owned;
-- DROP INDEX game_owners;
