show tables;

create table member_s (
	idx int not null auto_increment, 			/* 회원 고유번호 */
	mid varchar(20) not null, 					/* 회원 아이디 (중복 불허) */
	pwd varchar(100) not null, 					/* 비밀번호(SHA 암호화 처리), 암호화 처리하려면 길이를 길게 해야함 */
	nickName varchar(20) not null, 				/* 별명(중복 불허 / 수정 가능) */
	name varchar(20) not null, 					/* 회원 성명 */
	gender varchar(5) default '남자', 			/* 성별(기본값:남자) */
	birthday datetime default now(), 			/* 생년월일 */
	tel varchar(15),							/* 전화번호(010-1234-5678) */
	address varchar(100),						/* 회원 주소 (상품 배달시 기본 주소로 사용) */
	email varchar(50) not null, 				/* 이메일(아이디/비밀번호 분실시 사용) - 형식 체크 필수 */
	homePage varchar(50) not null,				/* 홈페이지(블로그) 주소 */
	job varchar(20), 							/* 회원 직업 */
	hobby varchar(20),							/* 회원 취미 (2개 이상은 '/'로 구분 처리) */
	photo varchar(100) default 'noimage.jpg', 	/* 회원 사진 (사진 없을시 노이미지 기본값 처리) */
	content text, 								/* 회원 자기 소개 */
	userInfor char(6) default '공개',			/* 회원정보 공개여부 (공개 / 비공개) */
	userDel char(2) default 'no',			 	/* 회원 탈퇴 신청 여부 (OK: 탈퇴 신청한 회원, NO: 현재 가입 중인 회원) */
	point int default 100, 						/* 회원 누적 포인트 (가입 시에 기본 100점 부여 방문시마다 1회 10포인트 증가, 최대 1일 50포인트까지 */
	level int default 4,						/* 회원 등급(0: 관리자, 1: 운영자, 2: 우수회원 3: 정회원, 4: 준회원 */
	visitCnt int default 0, 					/* 방문 횟수 */
	startDate datetime default now(), 			/* 최초 가입일 */
	lastDate datetime default now(),			/* 마지막 접속일 */
	todayCnt int default 0,						/* 일일 방문 횟수 */
	primary key(idx,mid)						/* 주키: idx(고유번호), mid(아이디) */
);

desc member_s;

--drop table member;

insert into member_s values (default,'admin','1234','관리자','관리자',default,default,'010-9885-5460','충북 청주시 서원구 서원서로 27','develop_bazzi@naver.com','https://github.com/develop00bazzi','개발자','사진/영상',default,'관리자입니다.',default,default,default,0,default,default,default,default);

select * from member_s;

select * from member where userDel='OK' order by idx desc;

alter table member_s change hobby hobby varchar(100);