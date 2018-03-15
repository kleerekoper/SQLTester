# SQLTester
### An Automated SQL Assessment Tool

SQL Tester is an automated tool for practice and assessment. It was designed by Dr Anthony Kleerekoper and Dr Andrew Schofield, based on AsseSQL, a similar tool developed by Dr Julia Prior at the University of Technology, Sydney.

Each test consists of 10 questions from 9 categories. A student may try each question as many times as they need to get the right answer. They will be shown the question and the desired output as well as the output from their last attempt. An answer will be considered correct if it produces precisely the same output, including the same order of the rows.

More details can be found in our paper - see below.

If you have any questions or problems, please email Anthony at a.kleerekoper@mmu.ac.uk

## Installation

To install SQL Tester:
1. Copy the files (excluding the sqlFiles folder) to an appropriate location on your webserver. 
2. Edit the mysqli_connect.php file to connect to your MySQL database.
3. Run the Tables.sql file on your MySQL server to create the relevant tables.
4. Run the other sql files to set up the four practice tests.
5. Add new students.

Please note that the CSS was only tested fully on IE on a desktop monitor. Although the tool does work with other browsers and screen sizes, it may not look perfect.

## Citing the Tool

You are free to adapt and modify SQL Tester. If you do so, please acknowledge both ourselves and AsseSQL. If you use SQL Tester for research purposes, please cite the following paper:

*Kleerekoper, Anthony and Schofield, Andrew. "SQL Tester: An Online SQL Assessment Tool and its Impact." Proceedings of the 2018 Conference on Innovation & Technology in Computer Science Education. ACM, 2018.*
