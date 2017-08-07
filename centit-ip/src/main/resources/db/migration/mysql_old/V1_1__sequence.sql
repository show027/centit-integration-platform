

DROP TABLE IF EXISTS F_MYSQL_SEQUENCE;

CREATE TABLE  F_MYSQL_SEQUENCE (
  NAME VARCHAR(50) NOT NULL,
  CURRVALUE INT(11) NOT NULL,
  INCREMENT INT(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (NAME)
) ;

INSERT INTO F_MYSQL_SEQUENCE (NAME, CURRVALUE , INCREMENT) VALUES
  ('S_MSGCODE', 0, 1);

INSERT INTO F_MYSQL_SEQUENCE (NAME, CURRVALUE , INCREMENT) VALUES
  ('S_RECIPIENT', 0, 1);

INSERT INTO F_MYSQL_SEQUENCE (NAME, CURRVALUE , INCREMENT) VALUES
  ('S_UNITCODE', 0, 1);

INSERT INTO F_MYSQL_SEQUENCE (NAME, CURRVALUE , INCREMENT) VALUES
  ('S_USERCODE', 0, 1);

INSERT INTO F_MYSQL_SEQUENCE (NAME, CURRVALUE , INCREMENT) VALUES
  ('S_USER_UNIT_ID', 0, 1);

INSERT INTO F_MYSQL_SEQUENCE (NAME, CURRVALUE , INCREMENT) VALUES
  ('S_ADDRESSID', 0, 1);

INSERT INTO F_MYSQL_SEQUENCE (NAME, CURRVALUE , INCREMENT) VALUES
  ('S_OPTDEFCODE', 0, 1);


DROP FUNCTION IF EXISTS sequence_currval;

DROP FUNCTION IF EXISTS sequence_nextval;

DROP FUNCTION IF EXISTS sequence_setval;

DELIMITER //

CREATE  FUNCTION sequence_currval(seq_name VARCHAR(50)) RETURNS int(11)
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE cur_value INTEGER;
  -- SET cur_value = 0;
  SELECT CURRVALUE INTO cur_value FROM F_MYSQL_SEQUENCE WHERE NAME = seq_name;
  RETURN cur_value;
END //

CREATE  FUNCTION sequence_nextval(seq_name VARCHAR(50)) RETURNS int(11)
    DETERMINISTIC
BEGIN
  DECLARE cur_value INTEGER;
  UPDATE  F_MYSQL_SEQUENCE SET CURRVALUE = CURRVALUE + INCREMENT WHERE NAME = seq_name;
  SELECT CURRVALUE INTO cur_value FROM F_MYSQL_SEQUENCE WHERE NAME = seq_name;
  RETURN cur_value;
END //

CREATE  FUNCTION sequence_setval(seq_name VARCHAR(50),seq_value int(11)) RETURNS int(11)
    DETERMINISTIC
BEGIN
  UPDATE F_MYSQL_SEQUENCE SET CURRVALUE = seq_value WHERE NAME = seq_name;
  RETURN seq_value;
END //

DELIMITER ;