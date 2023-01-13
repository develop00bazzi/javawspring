show tables;

create table schedule_s (
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	sDate datetime not null,	/* 일정 등록한 날짜 */
	part varchar(20) not null, /* 1. 모임, 2. 업무, 3. 학습, 4. 여행, 0. 기타  */
	content text not null
);

desc schedule_s;

insert into schedule_s values (default, 'admin', '2023-01-13', '모임', '가족 모임, 장소: 집, 시간: 19시');
insert into schedule_s values (default, 'admin', '2023-01-17', '학습', '프로젝트 준비, 장소: 카페, 시간: 15시');
insert into schedule_s values (default, 'admin', '2023-01-20', '기타', '요가, 장소: 집, 시간: 20시');
insert into schedule_s values (default, 'admin', '2023-01-23', '학습', '프로젝트 DB 설계 완성');
insert into schedule_s values (default, 'admin', '2023-01-26', '기타', '집에서 잠자기');
insert into schedule_s values (default, 'admin', '2023-01-30', '모임', '강원도 원주 오크밸리 스키장 방문');
insert into schedule_s values (default, 'admin', '2023-02-03', '모임', '증평 골프장 라운딩');
insert into schedule_s values (default, 'admin', '2023-04-05', '모임', '친구 생일');
insert into schedule_s values (default, 'test1111', '2023-01-13', '모임', '친구 모임, 장소: 충북대, 시간: 19시');
insert into schedule_s values (default, 'test1111', '2023-01-23', '업무', '업무 회의, 장소: 사무실, 시간: 10시');

select * from schedule_s where mid='admin' and sDate='2023-1' order by sDate;	/* X */
select * from schedule_s where mid='admin' and sDate='2023-01' order by sDate;	/* X */
select * from schedule_s where mid='admin' and sDate='2023-01-13' order by sDate;	/* O */

select * from schedule_s where mid='admin' and substring(sDate,1,7)='2023-01' order by sDate;

select * from schedule_s where mid='admin' and date_format(sDate,'%Y-%m')='2023-01' order by sDate;

select * from schedule_s where mid='admin' and date_format(sDate,'%Y-%m')='2023-01' group by substring(sDate,1,7) order by sDate;

select sDate,count(*) from schedule_s where mid='admin' and date_format(sDate,'%Y-%m')='2023-01' group by substring(sDate,1,7) order by sDate;

select sDate,part from schedule_s where mid='admin' and date_format(sDate,'%Y-%m')='2023-01' order by sDate, part;








