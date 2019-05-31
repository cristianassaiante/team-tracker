drop table if exists users cascade;
drop table if exists teams cascade;
drop table if exists ctfs cascade;
drop table if exists solves;
drop table if exists chals;
drop domain if exists categ_domain;
drop domain if exists school_level;

CREATE DOMAIN categ_domain AS TEXT
CHECK(
   VALUE ~ 'Crypto'
OR VALUE ~ 'Pwn'
OR VALUE ~ 'Reverse'
OR VALUE ~ 'Web'
OR VALUE ~ 'Misc'
);

CREATE DOMAIN school_level AS TEXT
CHECK(
   VALUE ~ 'High School Diploma'
OR VALUE ~ 'Undergraduated'
OR VALUE ~ 'BSc'
OR VALUE ~ 'Master'
OR VALUE ~ 'PhD'
);

create table ctfs (id serial primary key, name varchar(40), onsite boolean, location varchar, unique(name));
create table teams (id serial primary key, name varchar(40), token varchar(64), need_chal_confirmation boolean default true, unique(name));
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
    age integer,
    website varchar,
    school varchar,
    nationality varchar,
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
  id serial primary key,
  user_id integer,
  chal_id integer,
  team_id integer,
  is_pending boolean default true,
  unique(user_id, chal_id, team_id),
  foreign key(user_id) references users(id),
  foreign key(chal_id) references chals(id),
  foreign key(team_id) references teams(id)
);
