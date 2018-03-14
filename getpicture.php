<!DOCTYPE html>
<html>
<head>
</style>
</head>
<body>

<?php
$choice = $_GET['choice'];

require_once ('mysqli_connect.php');

$query = "SELECT T_schemaPic FROM admin_Tests WHERE T_name = \"$choice\";";
$result = mysqli_query($conn, $query);
if (false === $result) {
    echo mysql_error();
}
echo "<br />";
while($row = mysqli_fetch_array($result)) {
   echo '<img src="' . $row['T_schemaPic'] . '" >';
}
mysqli_close($conn);
?>
</body>
</html>