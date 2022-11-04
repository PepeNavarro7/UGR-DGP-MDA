<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

// Create connection
$conn = new mysqli($servername, $username_db, $_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT nombre, apellidos, email, acceso, accesibilidad, password_usuario, foto FROM estudiantes";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>