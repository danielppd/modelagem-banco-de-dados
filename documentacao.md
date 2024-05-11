# Ponderada - Modelagem de banco de dados

A modelagem de banco de dados é importante por vários fatores, como organização dos dados, flexibilicação, normalização, integridade dos dados, entre outros pontos muito importantes.  Isso acontece porque a estruturação correta de diferentes tabelas ajuda na organização, além disso, essa estruturação permite fáceis modificações e adaptações das estruturas dos dados. Também, é promovida uma normalização dos dados, importante para evitar redundâncias e repetições. Por fim, a integridade dos dados garante precisão e consistência nos dados armazenados. <br> 

Em nosso projeto para a parceira Zuyd, foi pedido que realizássemos uma aplicação web que seria uma plataforma onde os participantes da simulação internacional de negócios teriam a oportunidade de realizar as avaliações de collaboration e decision-making, nas fases antes, durante e após o fim do jogo. Além disso, a proposta também é de uma integração cultural, por isso que há espaço para muitos dados dos usuários serem coletados, para que possam ser exibidos, alguns deles, para que a comunicação dos participantes ser facilitada. Por fim, haverá espaços de upload e download de arquivos a opções de adição de comentários. 


<img src = 'modeloRelacionalPond.jpeg'> 

**Entidades**: As entidades presentes na modelagem relacional acima são as seguintes:

- *user*: Conjunto de dados relacionados ao usuário, contendo suas informações de login e pessoais
- *files*: Conjunto de dados relacionados aos arquivos e ao usuário que realizou upload ou download de tal arquivo
- *comments*: Dados relacionadoso aos comentários
- *decision_making*: Contém os dados relacionados aos questionários de decision-making; as autoavaliações e avaliações em pares
- *collaboration*: Contém os dados relacionados aos questionários de collaboration; as autoavaliações e avaliações em pares
- *pre_game_dm*: Relacionado à autoavaliação individual de decision-making realizada antes do jogo começar
- *pre_game_collaboration*: Relacionado à autoavaliação individual de collaboration realizada antes do jogo começar
- *peer_evaluation_dm*: Avaliação em pares de decision-making
- *peer_evaluation_collaboration*: Avaliação em pares de collaboration
- *end_game_dm*: Avaliação final de decision-making
- *end_game_collaboration*: Avaliação final de collaboration

*Relacionamentos e cardinalidade*:
De modo geral, o usuário será a parte central do banco de dados da aplicação web, se relacionando com diversas outras tabelas por meio da chave estrangeira "id_user". No entanto, a seguir, será possível visualizar melhor os relacionamentos entre as entidades:

- Relação *user* e *comments*: Cada comentário é composto por algum usuário que envia e um que recebe. A cardinalidade dessa relação é de 1:N, visto que um usuário pode enviar ou receber muitos comentários, mas cada comentário é especificamente de um usuário para outro

- Relação *user* e *files*: A relação se dá porque um usuário pode fazer upload ou download de diversos arquivos, e essa relação associa cada arquivo ao usuário. Assim, a cardinalidade da relação é de 1:N

- Relação *user*, *decision_making* e *collaboration*: O relacionamento da tabela se dá porque o usuário pode realizar avaliações de decision making e collaboration na plataforma, então a chave estrangeira "id_user" conecta qual usuário está realizando a avaliação com o outro usuário a qual a avaliação está sendo direcionada (o "outro" usuário pode ser o próprio autor da avaliação, no caso de uma autoavaliação). A cardinalidade desse relacionamento é de 1:N, uma vez que um usuário pode realizar autoavaliações e avaliações em pares para os diversos outros membros de sua equipe numerosas vezes.

- Relação *decision-making* e componentes de *decision-making*: Cada questionário de decision-making está ligado a uma autoavaliação pré-jogo, avaliação entre pares (peer_evaluation_dm) e avaliação final. A cardinalidade dessas relações é de 1:N, porque cada tabela de avaliações possuem diversas perguntas, opções de respostas e respostas dos usuários

- Relação *collaboration* e componentes de *collaboration*: Do mesmo modo da relação de decision-making e seus componentes


## Código SQL

```
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

```
