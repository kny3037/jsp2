-- �����Խ��� : ���̺� 2��(���α�����, �������)

create table freeboard(
	idx int not null auto_increment,
	name varchar(30) not null,       -- �ۼ���
	password varchar(10) not null,   -- �ۺ�й�ȣ
	subject varchar(40) not null,    -- ������
	content varchar(2000) not null,  -- ����
	readCount int default 0,		 -- ��ȸ��
	wdate datetime default current_timestamp,  -- ������ ���糯¥/�ð�
	ip varchar(15) default '127.0.0.1',			-- �ۼ��� ip
	commentCount smallint default 0,			-- ��� ����
	primary key(idx)
);
alter table freeboard modify column wdate timestamp
default current_timestamp;   -- timezone�� ���� ����

insert into freeboard (name,password,subject,content,ip)
values ('honey','1111','����~~','���� �ݰ���','192.168.17.3');
insert into freeboard (name,password,subject,content,ip)
values ('�糪','1111','welcome my home!','���� �ݰ��� ���','192.168.22.3');
insert into freeboard (name,password,subject,content,ip)
values ('����','1111','�¹���~~','�߰� �Ǻ���','192.168.23.3');
insert into freeboard (name,password,subject,content,ip)
values ('neyeon','1111','Hi~~','�ȳ� �ݰ���','192.168.24.3');
insert into freeboard (name,password,subject,content,ip)
values ('����ȣ','1111','����~~','�����','192.168.25.4');
insert into freeboard (name,password,subject,content,ip)
values ('������','1111','�ȳ�~~','��Ϸ� ������','192.168.26.7');


select * from freeboard;

-- mysql ���� limit Ű���� : limit ��ȣ, ����
-- mysql,oracle select ����� ���� �� �࿡ ������� ��ȣ�� �ο��ϴ� �÷�(row number)
-- �� ��������ϴ�. limit�� ��ȣ�� row num�Դϴ�.(mysql�� 0���� ����) 
select * from freeboard f order by idx desc;
select * from freeboard f order by idx desc limit 0,15;   -- 1������ ���
select * from freeboard f order by idx desc limit 15,15;  -- 2������ ���
select * from freeboard f order by idx desc limit 30,15;  -- 3������ ���
-- ���� : n������ ����?   (n-1)*15
select * from freeboard f order by idx desc limit 135,15;  -- 10������ ���
commit;

-- �� ���� : subject, content ����. ,idx �÷��� �������� �մϴ�. 
UPDATE freeboard SET subject = '�³���~', content='���ڰ� ���Ϻ���'
WHERE idx=150;

-- ��ȸ�� ���� : ���� ������(url ��û �߻�) ī��Ʈ +1
update freeboard set readcount = readcount +1 where idx=150;

-- �� ���� : �� ��й�ȣ 1)���� ��  2)���� ��
delete from freeboard where idx=148 and password='0000';
delete from freeboard where idx=148;

select * from freeboard f order by idx desc limit 0,15;
-- �� ��й�ȣ üũ (�α��� ��ɿ��� �����ϼ���)
select * from freeboard f where idx=151 and password ='1111';   -- �߸��� ��й�ȣ : ������� null
select * from freeboard f where idx=151 and password ='0520';   -- �ùٸ� ��й�ȣ : ������� 1�� �� ��ȸ


-- ��� ���̺� : board_comment
create table board_comment(
	idx int not null auto_increment,
	mref int not null,		-- ���α�(�θ��)�� idx��
	name varchar(30) not null,       -- �ۼ���
	password varchar(10) not null,   -- �ۺ�й�ȣ
	content varchar(2000) not null,  -- ����
	wdate timestamp default current_timestamp,  -- ������ ���糯¥/�ð�
	ip varchar(15) default '127.0.0.1',			-- �ۼ��� ip
	primary key(idx),
	foreign key(mref) references freeboard(idx)
);

insert into board_comment (mref,name,password,content,ip)
values(150,'����','1234','���� �Ϸ絵 ������','192.168.11.11');
insert into board_comment (mref,name,password,content,ip)
values(150,'����','1234','���� �Ϸ絵 ������','192.168.11.11');
insert into board_comment (mref,name,password,content,ip)
values(150,'����','1234','���� �Ϸ絵 ������','192.168.11.11');

insert into board_comment (mref,name,password,content,ip)
values(142,'����','1234','���� �Ϸ絵 ������','192.168.11.11');
insert into board_comment (mref,name,password,content,ip)
values(142,'����','1234','���� �Ϸ絵 ������','192.168.11.11');


-- ��� ����(�� ��Ͽ��� �ʿ��մϴ�.)
select count(*)from board_comment where mref = 150; -- 150������ ��� ����
select count(*)from board_comment where mref = 142; -- 142������ ��� ����
select count(*)from board_comment where mref = 100; -- 100������ ��� ����

-- ��� ����Ʈ
select * from board_comment where mref = 150;
select * from board_comment where mref = 142;
select * from board_comment where mref = 100;

-- �۸�� �����ϴ� dao.getList()���� �տ��� ��۰����� update
update freeboard set commentCount=(
	select count(*)from board_comment where mref = 150) where idx =150;
update freeboard set commentCount=(
	select count(*)from board_comment where mref = 142) where idx =142;

-- �� �󼼺��⿡�� ��� �Է� �� ������ ��
update freeboard set commentCount=commentCount+1 where idx =0;













