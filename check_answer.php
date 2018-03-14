<?php
// $studentAnswer available from calling script
// $modelAnswer available from calling script

// check that the studentAnswer is not trying to do anything "dodgy"
$lowercaseanswer = strtolower($studentAnswer);
if (strpos($lowercaseanswer, 'drop ') !== false or strpos($lowercaseanswer, 'insert ') !== false or 
    strpos($lowercaseanswer, 'delete ') !== false or strpos($lowercaseanswer, 'adjust ') !== false 
    or strpos($lowercaseanswer, 'update ') !== false or strpos($lowercaseanswer, 'create ') !== false){
        $_POST['userSQL'] = 'Please do not attempt any SQL statement besides for SELECT. This attempt has been logged.';
        $correct = 0;
        return;
}
if (strpos($lowercaseanswer, 'from admin_students') !== false or strpos($lowercaseanswer, 'from admin_tests') !== false
    or strpos($lowercaseanswer, 'from admin_testinstances') !== false or strpos($lowercaseanswer, 'from admin_answers') !== false
    or strpos($lowercaseanswer, 'from admin_questioncategories') !== false or strpos($lowercaseanswer, 'from admin_questions') !== false){
        $_POST['userSQL'] = 'Please do not attempt to cheat. This attempt has been logged.';
        $correct = 0;
        return;
}


$modelResult = @mysqli_query($conn,$modelAnswer);
$studentResult = @mysqli_query($conn,$studentAnswer);

// this should never happen!!
if ($modelAnswer==false) {
    echo "Error in model answer";
    echo mysql_error();
}


// by default assume the answer is correct unless we find either a syntax error or difference from model answer
$correct = 1;

// Mark answer as wrong if it has a syntax error
if ($studentResult==false) {
    $correct = 0;
    return;
}

$numberModelCols = mysqli_num_fields ($modelResult);
$numberStudentCols = mysqli_num_fields ($studentResult);

// answer is wrong if the two sets of results have a different number of columns
if ($numberModelCols != $numberStudentCols){
    $correct = 0;
    return;
}

$numberModelRows = mysqli_num_rows($modelResult);
$numberStudentRows = mysqli_num_rows($studentResult);

// answer is wrong if the two sets of results have a different number of rows
if ($numberModelRows != $numberStudentRows){
    $correct = 0;
    return;
}

// answer is wrong if the columns are different, including different order
for ($i = 0; $i < $numberModelCols; $i++) {
    $modelFieldInfo = mysqli_fetch_field_direct($modelResult, $i);
    $studentFieldInfo = mysqli_fetch_field_direct($studentResult, $i);
    if ($modelFieldInfo->name != $studentFieldInfo->name){
        $correct = 0;
        return;
    }
}

// answer is wrong if the contents of the rows are different, including different order
for ($i = 0; $i < $numberModelRows; $i++) {
    $modelRow = mysqli_fetch_row($modelResult);
    $studentRow = mysqli_fetch_row($studentResult);
    if ($modelRow != $studentRow){
        $correct = 0;
        return;
    }
}
?>