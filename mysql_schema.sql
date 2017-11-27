drop database if exists mvdb;
create database if not exists mvdb;
use mvdb;
create table if not exists person (
	id         		bigint auto_increment primary key not null,
	email      		varchar(200),
	f_name     		varchar(100),
	l_name     		varchar(100),
	password        varchar(100),
	digit_lock 		varchar(100),
	is_blocked		boolean,
    one_time_token 	varchar(200),
	created_on 		date
);
	

create table if not exists item (
	id        			    bigint auto_increment primary key not null,
	name      			    varchar(100),
	alias_name              varchar(100),
	category  			    varchar(100),
	sub_category 		    varchar(100),
	sub_sub_category 		varchar(100),
	sub_sub_sub_category 	varchar(100),
	region_country          varchar(100),
	region_state            varchar(100),
	region_city             varchar(100),
	region_pin              varchar(10),
	manufacturer            varchar(100),
	owner_name              varchar(100),
	created_on              date,
	expiry_on               date,
	has_expired             boolean,
	itemurl                 varchar(400)
);

create table if not exists review_rating_relationship (
	id       			    bigint auto_increment primary key not null,

	fk_person_id            bigint not null,
	fk_item_id 			    bigint not null,

	foreign key (fk_person_id) references person(id) on delete restrict,
	foreign key (fk_item_id) references item(id) on delete cascade,

	my_relationship_with_item    enum('Owned', 'Created', 'Shared', 'Viewed', 'Used'),
	my_relationship_duration_in_days int,
	ipaid                   bigint,
    currency                enum('us$','inr','cad$','aus$','yuan','yen'),
	rating                  int, -- [+10 to -10]
	comments 			    varchar(3000),
	pros				    varchar(1000),
	cons				    varchar(1000),
	createdon			    date,
	relationshipdate	    date,
	has_response			boolean, -- this review has a review !
	is_response			    boolean, -- this review is a review of other review!
	hide_details		    boolean
);

-- we will add manufacturer, but never delete them
-- so, we only use this to list them
create table if not exists manufacturers_list (
		id bigint auto_increment primary key not null,
		name varchar(100)
);

-- we will add but never remove the categories
-- Check design, we are doing inner-join (TODO: comeback to see if this makes sense)
create table if not exists category (
	id bigint auto_increment primary key not null,
	name varchar(100),
	fk_parent_category_id bigint -- can be 0
	-- foreign key(fk_parent_category_id) references category(id) , a fk of 0 wont be allowed in this case but we need it.
);
