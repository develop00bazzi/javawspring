show tables;

create table guest_s (
	idx int not null auto_increment primary key,	/* 고유 번호 */
	name varchar(20) not null, /* 방문자 성명 */
	email varchar(60),	/* 이메일 주소 */
	homePage varchar(60),	/* 홈페이지 주소 */
	visitDate datetime default now(),	/* 방문일자 */
	hostIp varchar(50) not null,	/* 방문자 IP */
	content text not null	/* 방문 소감 */
);

insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');
insert into guest_s values (default,'관리자','dragon0hun@naver.com','https://github.com/develop00bazzi',default,'192.168.50.65','관리자입니다.');

drop table guest_s;

select * from guest_s;



