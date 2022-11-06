<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

if(isset($_POST["nombre"])) {
    $nombre = $_POST["nombre"];
} else return;

if(isset($_POST["apellidos"])) {
    $apellidos = $_POST["apellidos"];
} else return;

if(isset($_POST["email"])) {
    $email = $_POST["email"];
} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "DELETE FROM estudiantes WHERE nombre='$nombre' AND apellidos='$apellidos' AND email='$email'";

if ($conn->query($sql) === TRUE) {
  echo "New delete done successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>