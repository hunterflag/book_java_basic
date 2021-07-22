/* substitution variable 替換變數
 * https://docs.oracle.com/cd/E11882_01/server.112/e16604/ch_twelve017.htm#SQPUG037
 * 因為中文常簡化為變數, 經常造成誤解;
 * 其實完整名稱說得很清楚, 替換變數就是替換用的變數,
 * 是很單純的字串容器, 不涉及資料型態
 * 預先定義要用的字串, 取用僅是單純的置換而已
 * 這點與一般語言的變數很不同, 反而相當於 java 的 properties
 */
 
/* 變數.定義 (Variable)
 * = 右邊都是值
 */
define definedVariable = 124 ;
define users = ('John', 'Mary', 'Ken') ; 

/* 變數.取用 */
select &definedVariable from dual;

-- 變數.刪除
undefine definedVariable;

/* 變數.取用.未定義.undefined, 
 * 定義->設值->取用(替換)->刪除
 */
select &undefinedVariable as udv from dual;
select &undefinedVariable, &definedVariable as dd from dual;
-- 拋棄式定義、單次有效
select &a A, &a as B from dual;

/* 快速定義
 * 用 && 取代 &
 * 定義->設值->取用(替換)
 * 終身有效
 */
 select &&a A, &a as B from dual;

/* 變數.取用.進階
 * varName 只是單純的替換內容
 * 實際上, 變數位置替換內容後的結果, 才是要真正執行的 sql 語句
 * 通常替換後的述句可能有錯 (容易造成誤判錯誤位置)； 
 * 所以, 字串要 '' 括住, 日期要 to_date(...
 */
define users = ('John', 'Mary', 'Ken'); 
select 1 as RESULT from dual where &input in &users;

-- 變數.啟用(預設)/禁用 (
set define on;
set define off;

set define &;   -- 平常不需要修改, 若 script 內需用到 預設的 & 時, 需要改變；但用完記得改回預設值

-- 變數.目前有哪些?

/* 變數.預定義(Predefined Variables)*/
select  
      '&_DATE'                  現在日期
    , '&_CONNECT_IDENTIFIER'    SID
    , '&_EDITOR'                編輯器
    , '&_USER'                  登入者
    , '&_PRIVILEGE'             權限
from dual;
