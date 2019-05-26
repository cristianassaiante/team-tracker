drop table if exists partecipates;
drop table if exists team_users;
drop table if exists solves;
drop table if exists chals;
drop table if exists teams;
drop table if exists users;
drop table if exists ctfs;

create table ctfs (id serial primary key, name varchar(40));
create table teams (id serial primary key, name varchar(40));
create table users (id serial primary key , username varchar(30), password varchar(64), salt varchar(5));

create table chals (
  id serial primary key,
  ctf_id integer, 
  name varchar(40),
  unique(ctf_id, name),
  foreign key(ctf_id) references ctfs(id)
);

create table solves (
  user_id integer,
  chal_id integer,
  team_id integer,
  unique(user_id, chal_id, team_id),
  foreign key(user_id) references users(id),
  foreign key(chal_id) references chals(id),
  foreign key(team_id) references teams(id)
);

create table team_users (
  id serial primary key,
  user_id integer,
  team_id integer,
  as_admin boolean,
  unique(user_id, team_id),
  foreign key(user_id) references users(id),
  foreign key(team_id) references teams(id)
);

create table partecipates (
  team_id integer,
  ctf_id integer,
  unique(team_id, ctf_id),
  foreign key(team_id) references teams(id),
  foreign key(ctf_id) references ctfs(id)
);
