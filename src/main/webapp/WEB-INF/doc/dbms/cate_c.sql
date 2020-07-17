1) 테이블 삭제: 자식 -> 부모
① DROP TABLE categrp; : ORA-02449: unique/primary keys in table referenced by foreign keys
② 자식 테이블 삭제: DROP TABLE cate;
③ 부모 테이블 삭제: DROP TABLE categrp;
  
2) 테이블 생성: 부모 -> 자식
① FK cate 생성시 에러 발생: ORA-00942: table or view does not exist
② 부모 테이블 먼저 생성: categrp
③ 자식 테이블 생성: cate

/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE contents;
DROP TABLE cate;
CREATE TABLE cate(
		cateno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categrpno                     		NUMBER(10)		 NOT NULL,
		name                          		VARCHAR2(100)		 NOT NULL,
		seqno                         		NUMBER(10)		 DEFAULT 1		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		rdate                           		DATE		 NOT NULL,
		cnt                           	    	NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

COMMENT ON TABLE cate is '카테고리';
COMMENT ON COLUMN cate.cateno is '카테고리 번호';
COMMENT ON COLUMN cate.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN cate.name is '카테고리 이름';
COMMENT ON COLUMN cate.seqno is '출력 순서';
COMMENT ON COLUMN cate.visible is '출력 모드';
COMMENT ON COLUMN cate.rdate is '등록일';
COMMENT ON COLUMN cate.cnt is '등록된 글 수';

DROP SEQUENCE cate_seq;
CREATE SEQUENCE cate_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

3) 등록
-- ERROR가 발생하는 등록
INSERT INTO cate(cateno, categrpno, name, seqno, visible, rdate, cnt)
VALUES(cate_seq.nextval, 1000, 'SF', 1 , 'Y', sysdate, 0);

-- 정상적인 등록
INSERT INTO cate(cateno, categrpno, name, seqno, visible, rdate, cnt)
VALUES(cate_seq.nextval, 1, 'SF', 1 , 'Y', sysdate, 0);

-- ORA-02291: integrity constraint (AI6.SYS_C007209) violated - parent key not found

SELECT * FROM categrp;
-- 부모 테이블에 레코드가 없어서 등록이 실패됨.

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '영화', 1, 'Y', sysdate);
 
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '여행', 2, 'Y', sysdate);
 
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '캠핑', 3, 'Y', sysdate);

commit;

SELECT * FROM categrp;
 CATEGRPNO NAME                                                    SEQNO V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 영화                                                        1 Y 2020-04-27 12:03:22
         2 여행                                                        2 Y 2020-04-27 12:03:22
         3 캠핑                                                        3 Y 2020-04-27 12:03:22

4) 정상적인 등록
INSERT INTO cate(cateno, categrpno, name, seqno, visible, rdate, cnt)
VALUES(cate_seq.nextval, 1, 'SF', 1 , 'Y', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, seqno, visible, rdate, cnt)
VALUES(cate_seq.nextval, 1, '드라마', 1 , 'Y', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, seqno, visible, rdate, cnt)
VALUES(cate_seq.nextval, 1, '스릴러', 1 , 'Y', sysdate, 0);

COMMIT;

5) 목록
SELECT cateno, categrpno, name, seqno, visible, rdate, cnt
FROM cate
ORDER BY cateno ASC;

    CATENO  CATEGRPNO NAME              SEQNO V RDATE                      CNT
---------- ---------- ------------------------- ---------- - ------------------- ----------
         1          1              SF                    1 Y 2020-04-27 12:16:37          0
         2          1              드라마              1 Y 2020-04-27 12:16:37          0
         3          1              스릴러              1 Y 2020-04-27 12:16:37          0
         
SELECT cateno, categrpno, name, seqno, visible, rdate, cnt
FROM cate
ORDER BY seqno ASC;


6) 삭제
DELETE FROM cate
WHERE cateno = 7;
commit;

SELECT cateno, categrpno, name, seqno, visible, rdate, cnt
FROM cate
ORDER BY cateno ASC;

7) categrpno FK 값을 이용한 삭제
DELETE FROM cate
WHERE categrpno = 1;

8) 조회
SELECT cateno, categrpno, name, seqno, visible, rdate, cnt
FROM cate
WHERE cateno=1;

9) 수정
UPDATE cate
SET categrpno=1, name='식당', seqno = 10, visible='N', cnt=0
WHERE cateno = 5;

UPDATE cate
SET cnt=0

commit;

10) 출력 순서 상향, 10 ▷ 1
UPDATE cate
SET seqno = seqno - 1
WHERE cateno=1;
 
11) 출력순서 하향, 1 ▷ 10
UPDATE cate
SET seqno = seqno + 1
WHERE cateno=1;

commit;

12) 출력 모드의 변경
UPDATE cate
SET visible='Y'
WHERE cateno=1;

UPDATE cate
SET visible='N'
WHERE cateno=1;

commit;

13) 통합 VO
SELECT r.categrpno as r_categrpno, r.name as r_name,
           c.cateno, c.categrpno, c.name, c.seqno, c.visible, c.rdate, c.cnt
FROM categrp r, cate c
WHERE r.categrpno = c.categrpno
ORDER BY r.categrpno ASC, c.seqno ASC;

R_CATEGRPNO R_NAME  CATENO  CATEGRPNO  NAME      SEQNO VISIBLE RDATE            CNT
----------- --------------- ---------- ----------- --------------------- ---------- - ------------------- ----------
          1 영화                  1           1 SF                              1 Y 2020-05-12 04:04:28          0
          1 영화                  2           1 드라마                         2 Y 2020-05-12 04:04:28          0
          1 영화                  3           1 스릴러                         3 Y 2020-05-12 04:04:28          0
          2 음악                  6           2 메간 트레이너                1 Y 2020-05-13 12:50:28          0
          2 음악                  4           2 챨리 푸스                      2 Y 2020-05-13 12:48:32          0

14) 통합 VO, categrpno 별 cate 목록
SELECT r.categrpno as r_categrpno, r.name as r_name,
           c.cateno, c.categrpno, c.name, c.seqno, c.visible, c.rdate, c.cnt
FROM categrp r, cate c
WHERE (r.categrpno = c.categrpno) AND r.categrpno=1
ORDER BY r.categrpno ASC, c.seqno ASC;

R_CATEGRPNO R_NAME  CATENO  CATEGRPNO  NAME      SEQNO VISIBLE RDATE            CNT
----------- --------------- ---------- ----------- --------------------- ---------- - ------------------- ----------
          1 영화                  1           1 SF                              1 Y 2020-05-12 04:04:28          0
          1 영화                  2           1 드라마                         2 Y 2020-05-12 04:04:28          0
          1 영화                  3           1 스릴러                         3 Y 2020-05-12 04:04:28          0


참고 1) categrp + cate inner join,  1 : 다, association
SELECT r.categrpno as r_categrpno, r.name as r_name,
           c.cateno as c_cateno, c.categrpno as c_categrpno, c.name as c_name,
           c.seqno as c_seqno, c.visible as c_visible, c.rdate as c_rdate, c.cnt as c_cnt
FROM categrp r
INNER JOIN cate c
ON r.categrpno = c.categrpno
ORDER BY r.categrpno ASC, c.seqno ASC;

SELECT r.categrpno as r_categrpno, r.name as r_name,
           c.cateno as c_cateno, c.categrpno as c_categrpno, c.name as c_name,
           c.seqno as c_seqno, c.visible as c_visible, c.rdate as c_rdate, c.cnt as c_cnt
FROM categrp r, cate c
WHERE r.categrpno = c.categrpno
ORDER BY r.categrpno ASC, c.seqno ASC;

R_CATEGRPNO R_NAME  C_CATENO C_CATEGRPNO C_NAME     C_SEQNO C C_RDATE            C_CNT
----------- --------------- ---------- ----------- --------------------- ---------- - ------------------- ----------
          1 영화                  1           1 SF                              1 Y 2020-05-12 04:04:28          0
          1 영화                  2           1 드라마                         2 Y 2020-05-12 04:04:28          0
          1 영화                  3           1 스릴러                         3 Y 2020-05-12 04:04:28          0
          2 음악                  6           2 메간 트레이너                1 Y 2020-05-13 12:50:28          0
          2 음악                  4           2 챨리 푸스                      2 Y 2020-05-13 12:48:32          0

참고 2) categrp + cate inner join,  1 : 다, collection
SELECT r.categrpno as r_categrpno, r.name as r_name, r.rdate as r_date,
           c.cateno as c_cateno, c.categrpno as c_categrpno, c.name as c_name,
           c.seqno as c_seqno, c.visible as c_visible, c.rdate as c_rdate, c.cnt as c_cnt
FROM categrp r
INNER JOIN cate c
ON r.categrpno = c.categrpno 
WHERE r.categrpno=1
ORDER BY r.categrpno ASC, c.seqno ASC;

SELECT r.categrpno as r_categrpno, r.name as r_name, r.rdate as r_date,
           c.cateno as c_cateno, c.categrpno as c_categrpno, c.name as c_name,
           c.seqno as c_seqno, c.visible as c_visible, c.rdate as c_rdate, c.cnt as c_cnt
FROM categrp r, cate c
WHERE r.categrpno = c.categrpno AND r.categrpno=1
ORDER BY r.categrpno ASC, c.seqno ASC;

R_CATEGRPNO R_NAME ? R_DATE ? ? ? ? ? ? ? ?C_CATENO C_CATEGRPNO C_NAME ? ? ? ?C_SEQNO C C_RDATE ? ? ? ? ? ? ? ? ?C_CNT
----------- ---------------- ------------------- ---------- ----------- -------------------------------------- ---------- - ------------------- ----------
? ? ? ? ? 1 ? ? ? ?영화 ? ? ? ?2020-05-12 04:02:35 ? ? ? ? ?1 ? ? ? ? ? 1 SF ? ? ? ? ? ?1 Y 2020-05-12 04:04:28 ? ? ? ? ?0
? ? ? ? ? 1 ? ? ? ?영화 ? ? ? ?2020-05-12 04:02:35 ? ? ? ? ?2 ? ? ? ? ? 1 드라마 ? ? ? 2 Y 2020-05-12 04:04:28 ? ? ? ? ?0
? ? ? ? ? 1 ? ? ? ?영화 ? ? ? ?2020-05-12 04:02:35 ? ? ? ? ?3 ? ? ? ? ? 1 스릴러 ? ? ? 3 Y 2020-05-12 04:04:28 ? ? ? ? ?0
? ? ? ? ? 1 ? ? ? ?영화 ? ? ? ?2020-05-12 04:02:35 ? ? ? ? ?7 ? ? ? ? ? 1 유머 ? ? ? ? ?4 Y 2020-05-13 04:11:54 ? ? ? ? ?0
? ? ? ? ? 1 ? ? ? ?영화 ? ? ? ?2020-05-12 04:02:35 ? ? ? ? ?8 ? ? ? ? ? 1 생존 ? ? ? ? ?5 Y 2020-05-13 04:12:20 ? ? ? ? ?0


SELECT cateno, categrpno, name, seqno, visible, rdate, cnt
FROM cate
WHERE categrpno=1
ORDER BY seqno ASC;

-- contents 추가에따른 등록된 글수의 증가
UPDATE cate 
SET cnt = cnt + 1 
WHERE cateno=1;

-- contents 추가에따른 등록된 글수의 감소
UPDATE cate 
SET cnt = cnt - 1 
WHERE cateno=1;
 
 








