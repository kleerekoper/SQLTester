<?php 
session_start();
$page_title = 'SQL Tester';
include ('header.html');
?>

<h3>Welcome to the SQL Tester</h3>

<p>This site is an online, automated SQL Tester for practice and assessment. It was designed by Dr Anthony Kleerekoper and Dr Andrew Schofield, based on <a href="http://dl.acm.org/citation.cfm?id=2602682" target="_blank">AsseSQL</a>, a similar tool developed by Dr Julia Prior at the University of Technology, Sydney.</p>
	
<p>In order to use the site you have to have an account. Please login with your student number and the password emailed to you. Please contact Anthony or Andrew if you've forgotten your password. Please also remember to change your password from the default one.</p>

<p>Each test consists of 10 questions and you have 50 minutes to complete the test. You may try each question as many times as you need to get the right answer. You will be shown the question and the desired output as well as the output from your attempt. Your answer will be considered correct if it produces precisely the same output, including the same order of the rows.</p>

<?php
include ('footer.html');
?>
