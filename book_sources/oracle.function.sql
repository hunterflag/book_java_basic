/*  Oracle
*/

-- 字串.編輯
-- 字串.編輯.拼接
select upper('ABC123中文abc') || ' || ' || lower('ABC123中文abc') 組合, dummy from dual;

-- 字串.比較 (首參決定輸出結果)
select nvl(null, '使用空值替代品') from dual;      -- 首參非null時, 傳回首數；首參為null時, 傳回次參 (次參是首參為null的替代品)
select nvl2(null, '非空', '空') from dual;         -- 首參非null時, 傳回次數；首參為null時, 傳回三參
select nullif('主值', '對比值') from dual;         -- 兩者相同回 null；不同回首參 (首參不得為null, 首參才是主角) 

select nvl('&a', '使用空值替代品') from dual;      -- 首參非null時, 傳回首數；首參為null時, 傳回次參 (次參是首參為null的替代品)
select nvl2('&a', '非空', '空') from dual;         -- 首參非null時, 傳回次數；首參為null時, 傳回三參
select nullif('&主值', '&對比值') from dual;         -- 兩者相同回 null；不同回首參 (首參不得為null, 首參才是主角) 
select nullif(nvl('&主值', 'empty'), '&對比值') from dual;         -- 兩者相同回 null；不同回首參 (首參不得為null, 首參才是主角) 


-- regexp_replace('原始字串', 'rgexp' [, '替換字串'...]) 將 '原始字串' 中, 對符合 'rgexp' 的子字串, 用 '替換字串' 取代 
select regexp_replace('AA12S3456', '[^0-9]') from dual;     -- 抽掉非數字的字元 (只留數字字元)

-- lpad('原始字串', 輸出總長度, 填補字串)
select lpad('123', 7, 'a') from dual;       
--select lpad('123', 7, a) from dual;         -- 字元必須以 '' 包住
select lpad('123', 7, ' ') from dual;      -- 可用來對齊 
select lpad('123', 7, 0) from dual;         -- 但數值可不包
select lpad('123', 7, 89) from dual;        
select lpad('123', 7, 09) from dual;        -- 不是數字

select lpad('123', 7, '') from dual;       -- ?? 相當於null
select lpad('123', 7, null) from dual;     -- 不可用, 無意義, 第一個就是null, 後面就...
select 'bof'||lpad('123', 7, null)||'eof' from dual;     -- 不可用, 無意義, 第一個就是null, 後面就...
select lpad('123', 17, 'abcde') from dual; 
select lpad('123', 20, 'abc') from dual;     -- 需填補 20-3=17 字元, 1組3個字元, 最多補上 17/3=5組, 餘2依序填滿為止
select lpad('123', 18, '中文') from dual;     -- 需填補 18-3=15 字元, 1個中文=2個字元, 1組4個字元, 最多補上 15/4=3組, 餘3依序填滿為止
select lpad('123', 22, '中文a') from dual;    -- 需填補 22-3=19 字元, 1個中文=2個字元, 1組5個字元, 最多補上 19/5=3組, 餘4依序填滿為止

select 'bof'||rpad('123', 7, 'a')||'eof' from dual;       
select 'bof'||rpad('123', 7, ' ')||'eof' from dual;      -- 可用來對齊 
select 'bof'||rpad('123', 7, '')||'eof' from dual;       -- ?? 相當於null
select 'bof'||rpad('123', 7, null)||'eof' from dual;     -- 不可用, 無意義, 第一個就是null, 後面就...


-- 擷取
-- select substr('原始字串', 起點位置 ,擷取長度) from dual;       -- 從start_pos.頭取多長length? 位置從1開始算
select substr('123456789ABCDEF', 1 ,3) from dual;       -- 從start_pos.頭取多長length? 位置從1開始算
select substr('123456789ABCDEF', -15 ,3) from dual;     -- 從start_pos 為 -1,表倒數位置,
select substr('123456789ABCDEF', 9 ,3) from dual;       -- 從start_pos 為 -1,表倒數位置,
select substr('123456789ABCDEF', 9 , 1) from dual;      -- length >0
select substr('123456789ABCDEF', 9 , 0) from dual;       
select substr('123456789ABCDEF', 9 , -3) from dual;      
select substr('123456789ABCDEF', 0 ,3) from dual;       -- start_pos 0也是從頭
select substr('123456789ABCDEF', 16 ,3) from dual;      -- start_pos 超過字串長度, 就 null 
select substr('123456789ABCDEF', 14 ,3) from dual;      -- 不足時, 就取完為止

-- select regexp_replace('原始字串', 'regex字串', '取代字串a') from dual;  
select regexp_replace('123456789ABCDEF', '[^0-9]', 'a') from dual;          -- 將符合 regex 字串, 用 xxx 置換
select regexp_replace('123456789ABCDEF', '[^0-9]', 'ab') from dual;
select regexp_replace('123456789ABCDEF', '[^0-9]{5}', 'a') from dual;
select regexp_replace('123456789ABCDEF', '[^0-9]{5}'     ) from dual;         -- 沒有取代字串時, 就是 null, 相當於刪除


--  日期
-- 系統日期
select sysdate from dual; -- 預設格式 DD-MON-RR
select date'2015-01-01' d FROM dual;
-- 運算
select sysdate+1 from dual;
select NEXT_DAY(TRUNC(SYSDATE), 'MONDAY') from dual;
select round(SYSDATE, 'MONTH') from dual; -- 取該月份的第一天
select round(SYSDATE, 'YEAR') from dual; -- 取該年份的第一天


-- select to_date('日期字串' , '套用格式' ) from dual;
-- 將字串以指定格式讀入後, 轉換成日期型態、並輸出
select to_date('2021-02-21' , 'yyyy-mm-dd' ) from dual;
select to_date('2021-02-12' , 'yyyy-dd-mm' ) from dual;
select to_date('05-02-12' , 'yy-dd-mm' ) from dual;
select to_date('05-02-12' , 'dd-mm-yy' ) from dual;
select to_date('05-02-12' , 'mm-yy-dd' ) from dual;
select to_date('20210221' , 'yyyymmdd' ) from dual;
select to_date('2021-02-21' , 'yyyymmdd' ) from dual;   -- 格式不符
select to_date('2021:02:21' , 'yyyy/mm/dd' ) from dual; -- 有些雖不同, 但相容
select to_date('2021:02:21' , 'yyyy:mm:dd' ) from dual; -- 有些雖不同, 但相容
select to_date('202102:21' , 'yymm:dd' ) from dual; -- 有些雖不同, 但相容
select to_date('20210221' , 'yyyy-mm-dd' ) from dual;
select to_date(sysdate , 'dd-mon-yy' ) from dual;
select to_date(sysdate , 'dd-mon-yy' ) from dual;

--  數值

-- 轉換
-- 顯式、隱式轉換 
-- 日期型態顯式轉換圖解
select to_char(123) from dual;

