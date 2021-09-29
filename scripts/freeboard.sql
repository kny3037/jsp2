-- 자유게시판 : 테이블 2개(메인글저장, 댓글저장)

create table freeboard(
	idx int not null auto_increment,
	name varchar(30) not null,       -- 작성자
	password varchar(10) not null,   -- 글비밀번호
	subject varchar(40) not null,    -- 글제목
	content varchar(2000) not null,  -- 내용
	readCount int default 0,		 -- 조회수
	wdate datetime default current_timestamp,  -- 서버의 현재날짜/시간
	ip varchar(15) default '127.0.0.1',			-- 작성자 ip
	commentCount smallint default 0,			-- 댓글 개수
	primary key(idx)
);
alter table freeboard modify column wdate timestamp
default current_timestamp;   -- timezone에 따라 설정

insert into freeboard (name,password,subject,content,ip)
values ('honey','1111','웰컴~~','하이 반가워','192.168.17.3');
insert into freeboard (name,password,subject,content,ip)
values ('사나','1111','welcome my home!','하이 반가워 어서와','192.168.22.3');
insert into freeboard (name,password,subject,content,ip)
values ('나나','1111','굿바이~~','잘가 또보자','192.168.23.3');
insert into freeboard (name,password,subject,content,ip)
values ('neyeon','1111','Hi~~','안녕 반가워','192.168.24.3');
insert into freeboard (name,password,subject,content,ip)
values ('박찬호','1111','웰컴~~','운동하자','192.168.25.4');
insert into freeboard (name,password,subject,content,ip)
values ('세리박','1111','안녕~~','운동하러 가야지','192.168.26.7');


select * from freeboard;

-- mysql 에는 limit 키워드 : limit 번호, 갯수
-- mysql,oracle select 결과에 대해 각 행에 순서대로 번호를 부여하는 컬럼(row number)
-- 이 만들어집니다. limit의 번호는 row num입니다.(mysql은 0부터 시작) 
select * from freeboard f order by idx desc;
select * from freeboard f order by idx desc limit 0,15;   -- 1페이지 목록
select * from freeboard f order by idx desc limit 15,15;  -- 2페이지 목록
select * from freeboard f order by idx desc limit 30,15;  -- 3페이지 목록
-- 계산식 : n페이지 글은?   (n-1)*15
select * from freeboard f order by idx desc limit 135,15;  -- 10페이지 목록
commit;

-- 글 수정 : subject, content 수정. ,idx 컬럼을 조건으로 합니다. 
UPDATE freeboard SET subject = '굿나잇~', content='잘자고 내일보자'
WHERE idx=150;

-- 조회수 변경 : 읽을 때마다(url 요청 발생) 카운트 +1
update freeboard set readcount = readcount +1 where idx=150;

-- 글 삭제 : 글 비밀번호 1)있을 때  2)없을 때
delete from freeboard where idx=148 and password='0000';
delete from freeboard where idx=148;

select * from freeboard f order by idx desc limit 0,15;
-- 글 비밀번호 체크 (로그인 기능에도 참고하세요)
select * from freeboard f where idx=151 and password ='1111';   -- 잘못된 비밀번호 : 쿼리결과 null
select * from freeboard f where idx=151 and password ='0520';   -- 올바른 비밀번호 : 쿼리결과 1개 행 조회


-- 댓글 테이블 : board_comment
create table board_comment(
	idx int not null auto_increment,
	mref int not null,		-- 메인글(부모글)의 idx값
	name varchar(30) not null,       -- 작성자
	password varchar(10) not null,   -- 글비밀번호
	content varchar(2000) not null,  -- 내용
	wdate timestamp default current_timestamp,  -- 서버의 현재날짜/시간
	ip varchar(15) default '127.0.0.1',			-- 작성자 ip
	primary key(idx),
	foreign key(mref) references freeboard(idx)
);

insert into board_comment (mref,name,password,content,ip)
values(150,'다현','1234','오늘 하루도 무사히','192.168.11.11');
insert into board_comment (mref,name,password,content,ip)
values(150,'다현','1234','오늘 하루도 무사히','192.168.11.11');
insert into board_comment (mref,name,password,content,ip)
values(150,'다현','1234','오늘 하루도 무사히','192.168.11.11');

insert into board_comment (mref,name,password,content,ip)
values(142,'다현','1234','오늘 하루도 무사히','192.168.11.11');
insert into board_comment (mref,name,password,content,ip)
values(142,'다현','1234','오늘 하루도 무사히','192.168.11.11');


-- 댓글 개수(글 목록에서 필요합니다.)
select count(*)from board_comment where mref = 150; -- 150번글의 댓글 개수
select count(*)from board_comment where mref = 142; -- 142번글의 댓글 개수
select count(*)from board_comment where mref = 100; -- 100번글의 댓글 개수

-- 댓글 리스트
select * from board_comment where mref = 150;
select * from board_comment where mref = 142;
select * from board_comment where mref = 100;

-- 글목록 실행하는 dao.getList()보다 앞에서 댓글개수를 update
update freeboard set commentCount=(
	select count(*)from board_comment where mref = 150) where idx =150;
update freeboard set commentCount=(
	select count(*)from board_comment where mref = 142) where idx =142;

-- 글 상세보기에서 댓글 입력 후 저장할 때
update freeboard set commentCount=commentCount+1 where idx =0;













