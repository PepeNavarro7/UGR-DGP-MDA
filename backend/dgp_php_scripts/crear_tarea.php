<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

if(isset($_POST["nombre"])) {
    $nombre = $_POST["nombre"];
} else return;

if(isset($_POST["descripcion"])) {
    $descripcion = $_POST["descripcion"];
} else return;

if(isset($_POST["lugar"])) {
  $lugar = $_POST["lugar"];
} else return;

if(isset($_POST["tipo"])) {
    $tipo = $_POST["tipo"];
} else return;

if(isset($_POST["pasos"])) {
    $pasos = $_POST["pasos"];
} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO caca (nombre, descripcion, lugar, tipo, pasos)
VALUES ('HOla', 'XD', 'HombreListo', 't', '[\"tagA\",\"tagB\",\"tagC\"]')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>