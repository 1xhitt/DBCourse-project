CREATE TABLE game (
	id SERIAL PRIMARY KEY,
	game_name VARCHAR(64) NOT NULL,
	min_players INTEGER NOT NULL,
	max_players INTEGER NOT NULL,
	expected_playtime INTEGER NOT NULL
);

CREATE TABLE person (
	id SERIAL PRIMARY KEY,
	name VARCHAR(64) NOT NULL,
	second_name VARCHAR(64) NOT NULL
);

CREATE TABLE vendor (
	id SERIAL PRIMARY KEY,
	vendor_name VARCHAR(64) NOT NULL
);

CREATE TABLE game_ownership (
	game_id INTEGER not null,
	person_id INTEGER not null,
	PRIMARY KEY (game_id, person_id),
	FOREIGN KEY (game_id) REFERENCES game(id),
	FOREIGN KEY (person_id) REFERENCES person(id)

);

CREATE TABLE vendor_offerings (
	game_id INTEGER,
	vendor_id INTEGER,
	price INTEGER NOT NULL,
    PRIMARY KEY (game_id, vendor_id),
	FOREIGN KEY (game_id) REFERENCES game(id),
	FOREIGN KEY (vendor_id) REFERENCES vendor(id)
);
CREATE TABLE time_spaces (
    id SERIAL PRIMARY KEY,
    person_id INTEGER,
    period_start TIME,
    period_end TIME,
	FOREIGN KEY (person_id) REFERENCES person(id)
);

