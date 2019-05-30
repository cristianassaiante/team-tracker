drop table if exists partecipates;
drop table if exists solves;
drop table if exists chals;
drop table if exists users;
drop table if exists teams;
drop table if exists ctfs;
drop domain if exists categ_domain;

CREATE DOMAIN categ_domain AS TEXT
CHECK(
   VALUE ~ 'Crypto'
OR VALUE ~ 'Pwn'
OR VALUE ~ 'Reverse'
OR VALUE ~ 'Web'
OR VALUE ~ 'Misc'
);

create table ctfs (id serial primary key, name varchar(40), onsite boolean, location varchar, unique(name));
create table teams (id serial primary key, name varchar(40), token varchar(64), unique(name));
create table users (
    id serial primary key, 
    username varchar not null default '', 
    email varchar not null default '', 
    is_admin boolean not null default false, 
    encrypted_password varchar not null default '', 
    reset_password_token varchar, 
    reset_password_sent_at timestamp, 
    remember_created_at timestamp, 
    confirmation_token varchar, 
    confirmed_at timestamp, 
    confirmation_sent_at timestamp, 
    unconfirmed_email varchar, 
    provider varchar, 
    uid varchar, 
    team_id integer, 
    foreign key(team_id) references teams(id)
);

create table chals (
  id serial primary key,
  ctf_id integer, 
  name varchar(40),
  points integer,
  categ categ_domain, 
  unique(ctf_id, name),
  foreign key(ctf_id) references ctfs(id)
);

create table solves (
  user_id integer,
  chal_id integer,
  team_id integer,
  is_pending boolean default true,
  unique(user_id, chal_id, team_id),
  foreign key(user_id) references users(id),
  foreign key(chal_id) references chals(id),
  foreign key(team_id) references teams(id)
);

create table partecipates (
  team_id integer,
  ctf_id integer,
  unique(team_id, ctf_id),
  foreign key(team_id) references teams(id),
  foreign key(ctf_id) references ctfs(id)
);
