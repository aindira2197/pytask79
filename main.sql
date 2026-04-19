CREATE TABLE file_versions (
  id INT PRIMARY KEY,
  file_name VARCHAR(255),
  version INT,
  content TEXT
);

CREATE TABLE diff_results (
  id INT PRIMARY KEY,
  file_name VARCHAR(255),
  version1 INT,
  version2 INT,
  diff TEXT
);

CREATE PROCEDURE get_diff(
  IN file_name VARCHAR(255),
  IN version1 INT,
  IN version2 INT
)
BEGIN
  DECLARE content1 TEXT;
  DECLARE content2 TEXT;
  
  SELECT content INTO content1
  FROM file_versions
  WHERE file_name = file_name AND version = version1;
  
  SELECT content INTO content2
  FROM file_versions
  WHERE file_name = file_name AND version = version2;
  
  CALL calculate_diff(content1, content2, file_name, version1, version2);
END;

CREATE PROCEDURE calculate_diff(
  IN content1 TEXT,
  IN content2 TEXT,
  IN file_name VARCHAR(255),
  IN version1 INT,
  IN version2 INT
)
BEGIN
  DECLARE diff TEXT;
  DECLARE row1 TEXT;
  DECLARE row2 TEXT;
  DECLARE row_num INT;
  
  SET row_num = 1;
  SET diff = '';
  
  WHILE row_num <= LENGTH(content1) DO
    SET row1 = SUBSTRING(content1, row_num, 1);
    SET row2 = SUBSTRING(content2, row_num, 1);
    
    IF row1 != row2 THEN
      SET diff = CONCAT(diff, 'Line ', row_num, ': ', row1, ' -> ', row2, '\n');
    END IF;
    
    SET row_num = row_num + 1;
  END WHILE;
  
  INSERT INTO diff_results (file_name, version1, version2, diff)
  VALUES (file_name, version1, version2, diff);
END;

INSERT INTO file_versions (id, file_name, version, content)
VALUES
(1, 'file1.txt', 1, 'Line 1 content'),
(2, 'file1.txt', 2, 'Line 1 content changed'),
(3, 'file2.txt', 1, 'Line 1 content'),
(4, 'file2.txt', 2, 'Line 1 content changed');

CALL get_diff('file1.txt', 1, 2);
CALL get_diff('file2.txt', 1, 2);

SELECT * FROM diff_results;