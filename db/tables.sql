create table hosts(
	id integer primary key autoincrement,
	name varchar(255) not null,
	caption varchar(255) not null unique);
	
create table authdata (
	id integer primary key autoincrement,
	username	varchar(255) not null,
	password	varchar(255) not null,
	domain	varchar(255),
	caption varchar(255) not null unique);

create table history(
	id integer primary key autoincrement,
	name varchar(255) not null,
	authdata_id int not null references authdata(id) default '-1',
	authusr varchar(255),
	authpwd varchar(255),
	caption varchar(255) not null,
	ts datetime default (datetime('now','localtime')));

create table hostgroups(
	id integer primary key autoincrement,
	name nvachar(255) unique);
	
create table rdpdata(
	id integer primary key autoincrement,
	hostdata_id int not null references hosts(id),
	authdata_id int not null references authdata(id) default '-1',
	caption varchar(255) not null unique,
	hostgroup_id int not null references hostgroups(id) default '-1');
	
insert into authdata(id,username,password,caption)
select -1,'-','-','other auth data';

insert into hostgroups(id,name)
select -1,'none';
