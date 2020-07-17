DROP TABLE vis;
CREATE TABLE vis (
        visno                             NUMBER(10)         NOT NULL         PRIMARY KEY,
        code                          VARCHAR(10)       NOT NULL,  
        title                           VARCHAR(100)         NOT NULL,  
        data                              VARCHAR(500)         NOT NULL,
        rdate                              DATE         NOT NULL
);

COMMENT ON TABLE vis is '시각화 데이터';
COMMENT ON COLUMN vis.visno is '시각화 데이터 번호';
COMMENT ON COLUMN vis.code is '코드';
COMMENT ON COLUMN vis.title is '제목';
COMMENT ON COLUMN vis.data is '데이터';
COMMENT ON COLUMN vis.rdate is '등록일';

INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR', '매출액', '"abc"', sysdate);

SELECT * FROM vis;

-- X 떠블안에  떠블
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR', '매출액', "''abc''", sysdate);
             
-- X 떠블안에  싱글
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR', '매출액', "'abc'", sysdate);

-- O 작은 따음표 3개
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR', '매출액', '''abc''', sysdate);
SELECT * FROM vis;

-- X
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR', '매출액', '\'abc\'', sysdate);
SELECT * FROM vis;

-- O
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR', '매출액', q'$'abc'$', sysdate);
SELECT * FROM vis;

-- O
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR', '매출액', q'$"abc"$', sysdate);
SELECT * FROM vis;

SELECT visno, code, title, data, rdate
FROM vis
WHERE code='BAR'
ORDER BY visno ASC;

--  subquery를 이용한 최근 등록 데이터 출력
SELECT visno, code, title, data, rdate, r
FROM (
    SELECT visno, code, title, data, rdate, rownum as r
    FROM (
        SELECT visno, code, title, data, rdate
        FROM vis
        WHERE code='BAR'
        ORDER BY visno DESC
    )
)
WHERE r = 1;

DELETE FROM vis;
COMMIT;

-- 옵션이 추가된 라인 그래프
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'LINE', '옵션이 추가된 라인 그래프', q'$[[10,20,30,40,50,300,200],[25,32,45,53,65,270,150]]$', sysdate);
SELECT * FROM vis;

-- Tcik이 있는 라인 그래프
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'LINE', 'Tcik이 있는 라인 그래프', q'$[[['1월', 300], ['2월', 52], ['3월', 38], ['4월', 30], ['5월', 0]]]$', sysdate);
SELECT * FROM vis;

-- 막대 그래프 기본
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR1', '막대 그래프 기본', q'$[['포드', 4],['볼보', 6],['포르쉐', 2],['아우디', 5],['부가티', 6]]$', sysdate);
SELECT * FROM vis;
    
-- 막대 그래프 2 변수, 변수 구분은 '/'
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR2', '막대 그래프 2 변수', q'$[9, 8, 6, 8, 7, 6, 4]/[2, 3, 4, 10, 8, 5, 1]$', sysdate);
SELECT * FROM vis;

-- 막대 그래프와 꺽은선 그래프의 결합
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR3', '막대 그래프와 꺽은선 그래프의 결합', q'$[9, 8, 6, 8, 7, 6, 4]/[2, 3, 4, 10, 8, 5, 1]$', sysdate);
SELECT * FROM vis;

-- 막대 그래프 값 출력
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'BAR4', '막대 그래프 값 출력', q'$[14, 32, 41, 44, 40, 37, 29]$', sysdate);
SELECT * FROM vis;

-- 원형 그래프
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'PIE', '원형 그래프', q'$[[['1/4 분기', 50], ['2/4 분기', 22], ['3/4 분기', 38], ['4/4 분기', 30]]]$', sysdate);
SELECT * FROM vis;

-- Meter gauge
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'METER', 'Meter gauge', q'$322$', sysdate);
SELECT * FROM vis;

COMMIT;

-- 자동 새로고침 확인 데이터
INSERT INTO vis (visno, code, title, data, rdate) 
VALUES ((SELECT NVL(MAX(visno), 0) + 1 as visno FROM vis),
             'METER', 'Meter gauge', q'$300$', sysdate);

COMMIT;