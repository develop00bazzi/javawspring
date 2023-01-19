show tables;

create table webMessage (
	idx int not null auto_increment primary key, 	/* 고유번호 */
	title varchar(100) not null,					/* 메세지 제목 */
	content text not null,							/* 메세지 내용 */
	sendId varchar(20) not null,					/* 보내는 사람 아이디 */
	sendSw char(1) not null,						/* 보낸 메세지 (s) / 휴지통(g) - 생략 / 휴지통에서 삭제(x) 표시 */
	sendDate datetime default now(),				/* 메세지 보낸 날짜 */
	receiveId varchar(20) not null,					/* 받는 사람 아이디 */
	receiveSw char(1),								/* 받은 메세지 (n) / 읽은 메세지 (r) / 휴지통 (g), 휴지통에서 삭제 (x) */
	receiveDate datetime default now()				/* 메세지 받은 날짜 */
);

desc webMessage;

insert into webMessage values (default, '안녕하세요~ 반갑습니다!','안녕하세요~ 관리자입니다! 웹 메세지 연습입니다~','admin','s',default,'dragon0hun','n',default);

update webMessage set receiveSw ='r', receiveDate=now() where idx=1;

insert into webmessage values (default, '오~ 웹 메세지 연습이라니','신기하네요~ 감사합니다!','dragon0hun','s',default,'admin', 'n', default);

update webMessage set receiveSw ='r', receiveDate=now() where idx=2;

update webMessage set receiveSw ='g' where idx=2;

update webMessage set sendSw ='x' where idx=1;

update webMessage set receiveSw ='g' where idx=1;

update webMessage set receiveSw ='x' where idx=1;

delete from webMessage where idx=1;




















