INSERT INTO shop_board VALUES
(101, '작성자', '1234', '제목', '글내용', '파일', 0, 0, 0, 0, SYSDATE );

INSERT INTO shop_board VALUES
(shop_board_seq.nextval, '작성자2', '1234', '제목', '글내용', '파일', 0, 0, 0, 0, SYSDATE );

DELETE FROM shop_board;

UPDATE shop_board
   SET board_num = 2,
	   board_writer = "관리자";

SELECT *
  FROM shop_board;
  
SELECT *
  FROM shop_board
 WHERE board_num = 1;
 
-- 오늘 작성된 게시물 가져오기 
SELECT * FROM shop_board WHERE to_char(board_date, 'yy-mm') = to_char(sysdate, 'yy-mm'); 

SELECT * FROM shop_board WHERE to_char(board_date, 'yy') = '19' AND board_kinds='1';
 
COMMIT;



