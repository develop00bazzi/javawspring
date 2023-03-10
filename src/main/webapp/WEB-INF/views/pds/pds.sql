show tables;

create table pds_s (
	idx int not null auto_increment,		/* 자료실 고유번호 */
	mid varchar(20) not null,				/* 올린이 아이디 */
	nickName varchar(20) not null,			/* 올린이 닉네임 */
	fName varchar(200) not null,			/* 업로드 파일명 */
	fSName varchar(200) not null,			/* 실제 서버에 저장되는 파일명 */
	fSize int not null,						/* 파일의 용량 */
	title varchar(100) not null,			/* 업로드 파일의 제목 */
	part varchar(20) not null,				/* 파일 분류 */
	pwd	varchar(100) not null,				/* 비밀번호 (암호화 - SHA256 암호화 처리) */
	fDate datetime default now(),			/* 파일 업로드 날짜 */
	downNum int default 0,					/* 파일 다운로드 횟수 */
	openSw char(6) default '공개',			/* 파일 공개(비공개) 여부 */
	content text,							/* 업로드 파일의 상세 설명 */
	hostIp varchar(50) not null,			/* 올린이 IP 주소 */
	primary key (idx)						/* 기본키: 자료실의 고유번호 */
);

desc pds_s;

select * from pds_s order by idx desc;

select count(*) as cnt from pds_s where title like '%우%' and part='전체';


