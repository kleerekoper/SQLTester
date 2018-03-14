DROP TABLE IF EXISTS admin_Students;
DROP TABLE IF EXISTS admin_Tests;
DROP TABLE IF EXISTS admin_TestPasswords;
DROP TABLE IF EXISTS admin_TestInstances;
DROP TABLE IF EXISTS admin_Answers;
DROP TABLE IF EXISTS admin_QuestionCategories;
DROP TABLE IF EXISTS admin_Questions;

CREATE TABLE admin_Students(
	S_number INT(8) UNSIGNED PRIMARY KEY,
    S_password CHAR(40),
    S_firstName VARCHAR(20),
    S_surname VARCHAR(20)
);

CREATE TABLE admin_Tests(
	T_id INT(10) UNSIGNED PRIMARY KEY,
    T_name VARCHAR(20),
    T_schemaPic VARCHAR(30)
);

CREATE TABLE admin_TestPasswords(
	T_id INT(10) UNSIGNED UNIQUE REFERENCES admin_Test(T_id),
    Password CHAR(40)
);

CREATE TABLE admin_TestInstances(
	T_id INT(10) UNSIGNED REFERENCES admin_Tests(T_id),
    S_number INT(8) UNSIGNED REFERENCES admin_Students(S_id),
    TestTime TIMESTAMP,
    Question1 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    Question2 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    Question3 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    Question4 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    Question5 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    Question6 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    Question7 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    Question8 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    Question9 INT(10) UNSIGNED REFERENCES Questions(Q_id),
 	Question10 INT(10) UNSIGNED REFERENCES Questions(Q_id),
    CONSTRAINT PRIMARY KEY (T_id, S_number, TestTime)
);

CREATE TABLE admin_Answers(
	T_id INT(10) UNSIGNED REFERENCES admin_testinstances(T_id),
    S_number INT(8) UNSIGNED REFERENCES admin_testinstances(S_id),
    TestTime TIMESTAMP REFERENCES admin_testinstances(TestTime),
    Question_id INT(10) UNSIGNED REFERENCES admin_Questions(Q_id),
    AnswerTime TIMESTAMP,
    Answer TEXT,
    Correct bool,
    CONSTRAINT PRIMARY KEY (T_id, S_number, TestTime, Question_id, AnswerTime)
);

CREATE TABLE admin_QuestionCategories(
	Category VARCHAR(20) PRIMARY KEY
);

CREATE TABLE admin_Questions(
	Q_id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	T_id INT(10) UNSIGNED REFERENCES admin_Tests(T_id),
    Category VARCHAR(20) REFERENCES admin_QuestionCategories(Category),
    Question TEXT,
    Answer TEXT
);

CREATE INDEX answert_time_idx ON admin_Answers (AnswerTime);
CREATE INDEX answer_s_number_idx ON admin_Answers (S_number);

INSERT INTO admin_QuestionCategories 
VALUES
	("OneTableSelect"),
    ("OneTableSelectWhere"),
    ("OneTableSelectOrder"),
    ("RowFunction"),
    ("GroupFunction"),
    ("InnerJoin"), -- 2 of these in each test
    ("GroupBy"),
    ("GroupByHaving"),
    ("SimpleSubquery");