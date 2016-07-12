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

create table history(
	id int primary key default 'autoincrement',
	name varchar(255) not null,
	authdata_id int not null references authdata(id) default '-1',
	authusr varchar(255),
	authpwd varchar(255),
	caption varchar(255) not null,
	ts datetime default (datetime('now','localtime')));
	
insert into authdata(id,username,password,caption)
select -1,'-','-','other auth data';
