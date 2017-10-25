drop database if exists mvdb;
create database if not exists mvdb;
use mvdb;
create table if not exists mvdb_person (
	id        bigint auto_increment primary key not null,
	email     varchar(200) not null,
	f_name    varchar(100),
	l_name    varchar(100),
	createdon date
);
	

create table if not exists mvdb_item (
	id        			bigint auto_increment primary key not null,
	name      			varchar(100),
	alias_name          varchar(100),
	category  			varchar(100),
	subcategory 		varchar(100),
	subsubcategory 		varchar(100),
	subsubsubcategory 	varchar(100),
	region_country      varchar(100),
	region_state        varchar(100),
	region_city         varchar(100),
	region_pin          varchar(10),
	manufacturor        varchar(100),
	owner_name          varchar(100),
	createdon           date,
	expiryon            date,
	has_expired         boolean,
	itemurl             varchar(400)
);

create table if not exists mvdb_review_rating_relationship (
	id       			bigint auto_increment primary key not null,

	fk_person_id        bigint not null,
	fk_item_id 			bigint not null,

	foreign key (fk_person_id) references mvdb_person(id) on delete restrict,
	foreign key (fk_item_id) references mvdb_item(id) on delete cascade,

	my_relationship_with_item    enum('Owned', 'Created', 'Shared', 'Viewed', 'Used'),
	ipaid               bigint,
    currency            enum('us$','inr','cad$','aus$','yuan','yen'),
	rating              int, -- [+10 to -10]
	comments 			varchar(3000),
	pros				varchar(1000),
	cons				varchar(1000),
	createdon			date,
	relationshipdate	date,
	hide_details		boolean
);
