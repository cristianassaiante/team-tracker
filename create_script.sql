drop table if exists partecipates;
drop table if exists playswith;
drop table if exists solves;
drop table if exists chal;
drop table if exists team;
drop table if exists usr;
drop table if exists ctf;

create table ctf (id serial primary key ,name varchar(40));
create table team(id serial primary key , name varchar(40));

create table usr(id serial primary key , username varchar(30), password varchar(64), salt varchar(5));

create table chal(
  id serial primary key,
  ctf_id integer, 
  name varchar(40),
  unique(ctf_id, name),
  foreign key(ctf_id) references ctf(id)
);

create table solves(
  user_id integer,
  chal_id integer,
  team_id integer,
  primary key(user_id, chal_id, team_id),
  foreign key(user_id) references usr(id),
  foreign key(chal_id) references chal(id),
  foreign key(team_id) references team(id)
);

create table playswith(
  user_id integer,
  team_id integer,
  as_admin boolean,
  primary key(user_id, team_id),
  foreign key(user_id) references usr(id),
  foreign key(team_id) references team(id)
);

create table partecipates(
  team_id integer,
  ctf_id integer,
  primary key(team_id, ctf_id),
  foreign key(team_id) references team(id),
  foreign key(ctf_id) references ctf(id)
);
