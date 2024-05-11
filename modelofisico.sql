-- Drop Tables if they exist
DROP TABLE IF EXISTS "user", "comments", "files", "decision_making", "collaboration", "pre_game_dm", "peer_evaluation_dm", "end_game_dm", "pre_game_collaboration", "peer_evaluation_collaboration", "end_game_collaboration" CASCADE;

-- User Table
CREATE TABLE "user" (
  id SERIAL PRIMARY KEY,
  name TEXT,
  email TEXT,
  password TEXT,
  nationality TEXT,
  time_zone TEXT,
  age INTEGER,
  gender TEXT,
  status TEXT,
  curiosity TEXT,
  happiness_meter INTEGER
);

-- Comments Table
CREATE TABLE "comments" (
  id SERIAL PRIMARY KEY,
  text TEXT,
  datetime TIMESTAMP,
  id_user INTEGER REFERENCES "user" (id),
  id_feedback_receiver INTEGER REFERENCES "user" (id)
);

-- Files Table
CREATE TABLE "files" (
  id SERIAL PRIMARY KEY,
  file TEXT,
  type TEXT,
  size_file INTEGER,
  datetime TIMESTAMP,
  description TEXT,
  id_user INTEGER REFERENCES "user" (id)
);

-- Decision Making Table
CREATE TABLE "decision_making" (
  id SERIAL PRIMARY KEY,
  id_user INTEGER REFERENCES "user" (id),
  id_feedback_receiver INTEGER REFERENCES "user" (id),
  id_decision_making INTEGER REFERENCES "pre_game_dm" (id),
  id_pe_dm INTEGER REFERENCES "peer_evaluation_dm" (id),
  id_final_dm INTEGER REFERENCES "end_game_dm" (id)
);

-- Collaboration Table
CREATE TABLE "collaboration" (
  id SERIAL PRIMARY KEY,
  id_user INTEGER REFERENCES "user" (id),
  id_feedback_receiver INTEGER REFERENCES "user" (id),
  id_collaboration INTEGER REFERENCES "pre_game_collaboration" (id),
  id_pe_collaboration INTEGER REFERENCES "peer_evaluation_collaboration" (id),
  id_final_collaboration INTEGER REFERENCES "end_game_collaboration" (id)
);

-- Pre Game DM Table
CREATE TABLE "pre_game_dm" (
  id SERIAL PRIMARY KEY,
  question TEXT,
  options TEXT,
  answer TEXT
);

-- Peer Evaluation DM Table
CREATE TABLE "peer_evaluation_dm" (
  id SERIAL PRIMARY KEY,
  question TEXT,
  options TEXT,
  answer TEXT
);

-- End Game DM Table
CREATE TABLE "end_game_dm" (
  id SERIAL PRIMARY KEY,
  question TEXT,
  options TEXT,
  answer TEXT
);

-- Pre Game Collaboration Table
CREATE TABLE "pre_game_collaboration" (
  id SERIAL PRIMARY KEY,
  question TEXT,
  options TEXT,
  answer TEXT
);

-- Peer Evaluation Collaboration Table
CREATE TABLE "peer_evaluation_collaboration" (
  id SERIAL PRIMARY KEY,
  question TEXT,
  options TEXT,
  answer TEXT
);

-- End Game Collaboration Table
CREATE TABLE "end_game_collaboration" (
  id SERIAL PRIMARY KEY,
  question TEXT,
  options TEXT,
  answer TEXT
);
