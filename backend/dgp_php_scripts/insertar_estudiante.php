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

if(isset($_POST["acceso"])) {
    $acceso = $_POST["acceso"];
} else return;

if(isset($_POST["accesibilidad"])) {
    $accesibilidad = $_POST["accesibilidad"];
} else return;

if(isset($_POST["password"])) {
    $password = $_POST["password"];
} else return;

if(isset($_POST["foto"])) {
    $foto = $_POST["foto"];
} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO estudiantes (nombre, apellidos, email, acceso, accesibilidad, password, foto)
VALUES ('$nombre', '$apellidos', '$email', '$acceso', '$accesibilidad', $password, '$foto')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>