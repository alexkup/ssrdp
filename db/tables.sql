create table hosts(
	id int primary key default 'autoincrement',
	name varchar(255) not null,
	caption varchar(255) not null);
	
create table authdata (
	id int primary key default 'autoincrement',
	username	varchar(255) not null,
	password	varchar(255) not null,
	domain	varchar(255),
	caption varchar(255) not null);
