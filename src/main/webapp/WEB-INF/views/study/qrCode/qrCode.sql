show tables;

create table qrCode (
	/* idx int not null auto_increment primary key, */
	idx char(8) not null primary key, 
	qrCode varchar(200) not null,
	bigo varchar(200)
);

desc qrCode;

drop table qrCode;