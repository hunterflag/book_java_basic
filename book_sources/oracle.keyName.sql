/*
    -- 關鍵字
    .. V$SQL_PLAN
    .column-level
    .. table_name
    schema: 用來存放 object 的集合體
    object: table, view, type, procedure, function, package or synonym

*/
--select count(*) total
select * 
from dual					-- pseudoTable.
--from user_tables	    	-- 目前.使用者.表格
--from all_tables	    	-- 所有.使用者.表格
--from dba_tables	    	-- 所有.      .表格 (使用者、系統)
--from all_views	    	-- 所有.使用者.視觀
--from user_tab_columns		-- 目前.使用者.欄位
--from all_tab_columns		-- 所有.使用者.欄位
--from dba_tab_columns		-- 所有.      .欄位 (使用者、系統)
--from user_tab_comments 	--目前.使用者.表格.的註解
--from user_col_comments 	--目前.使用者.欄位.的註解
--from V$SQL_PLAN           --  
--from V$database           --
;    

-- 顯示表格欄位
describe V$SQL_PLAN;
show tables;

select owner, object_name , object_type from dba_objects where object_name like ''%DUAL%'';

select * from all_views where view_name like '$SQL%' ;


select 1+2 from dual;       -- 虛擬資料表、啞表、內部表、隱藏空表
select * from dual;         -- 虛擬資料表、啞表、內部表、隱藏空表
select user from dual;      -- 查虛擬資料表、啞表、內部表、隱藏空表

select sysdate from dual;   
select sysdate, dump(sysdate) from dual;   
select to_date(sysdate, 'yyyymmdd','NLS_DATE_LANGUAGE = AMERICAN') from dual;   

-- 資料表 
select * 
--select count(*) 
--select tablespace_name, count(*) 
from user_tables    --
--from all_tables     --
where 1=1
    and table_name like 'V$SQL_PLAN'
--    and tablespace_name not like 'LISD'
--    and tablespace_name in (''
--                        , 'SYSTEM'          -- 虛擬表
--                        , 'SYSAUX'
--                        , 'RISD'
--                        , 'USER'
--                        , 'LISD'    -- LIS
--                    )
--group by tablespace_name
order by table_name
--order by tablespace_name, table_name
;  
 
select * 
from dba_data_files
;

select * from ldcode;
select CODETYPE ,
CODE ,
CODENAME ,
CODEALIAS ,
COMCODE ,
OTHERSIGN ,
STATE ,
ORDERNO ,
I18NCODENAME  from ldcode;                               -- 全部 (依照建檔順序)
select codetype, code from ldcode;                               -- 順序被改變了? 與 select * 不同
select code, codetype from ldcode;                               -- (自動依欄位排序了?)
--select rownum, * from ldcode;                     -- ?? 好像是 * 的使用限制
select a.* from ldcode a;                     -- ?? 好像是 * 的使用限制
select rownum, a.* from ldcode a;                   -- rownum 為虛擬欄位, 產生順序
--select rownum, codetype from ldcode;                -- ?? 為何排序自動變了
select * from ldcode order by codetype,code;                      -- 將順序固定下來
select a.* from ldcode a order by codetype,code;                      -- 將順序固定下來
select rownum, a.* from ldcode a order by codetype,code;                -- rownum 為虛擬欄位, 產生順序
--select rownum, * from (select * from ldcode order by codetype,code) ;     -- 子查詢結果要給別名
select rownum, t.* from (select * from ldcode order by codetype,code) t;
select rownum, t.* from (select * from ldcode order by codetype,code) t where rownum <= 5;  -- 條件只能用 < 或 <=
--select rownum, t.* from (select * from ldcode order by codetype,code) t where rownum >= 5;  -- 語法沒錯, 但無效, 會沒有結果
select * from (select rownum rid, t.* from (select * from ldcode order by codetype, code) t) where rId between 5 and 10;  -- 指定區間的紀錄
select  rownum rid, t.* from (select a.* from ldcode a order by codetype, code) t where rId between 5 and 10;  -- pseudocolumn 的執行順序早於group、order


/* select 述句中, 各子句的執行順序 */
select codetype, code from ldcode;
select codetype, code from ldcode where code = '1';
--select codetype, code dd from ldcode where dd = '1';        -- 別名的執行順序在 where 之後, ie. 此時沒有 dd


select t.*
from (select * from ldcode order by codetype,code) t
--where rownum between 2 and 10
--where ROWNUM <= 20
--where R_ID <= 20
;

drop table zmbhzljfiget;

desc dba_data_files;

select *   
--from all_tab_columns  -- 
from user_tab_columns  -- 
where table_name=upper('ldcode')  -- 
;

select count(*)
from ldcode
where 1=1 
GROUP BY codetype  
order by codetype

;

select * from v$tablespace;  -- 


select a.table_name
from user_tables a
where 1=1
--    and a.table_name not in (select b.table_name from user_tab_column b where b.column_name in ('operator'))
;

select table_name from user_tab_columns b where b.column_name in ('operator');

