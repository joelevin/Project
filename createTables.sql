drop table users;
drop table pages;
drop table links;

create table pages(
	pname varchar2(20) primary key,
	num_entrances integer,
	num_exits integer
);

create table users(
	uname varchar2(20) primary key,
	num_visits integer,
	pname varchar2(20) references pages,
	isActive integer
);

create table links(
	fpname varchar2(20),
	tpname varchar2(20),
	num_access integer,
	CONSTRAINT pk_links primary key(fpname, tpname)
);