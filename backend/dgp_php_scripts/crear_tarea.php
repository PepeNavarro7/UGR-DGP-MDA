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

if(isset($_POST["materiales"])) {
  $materiales = $_POST["materiales"];
} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO tareas (nombre, descripcion, lugar, tipo, materiales, pasos)
VALUES ('$nombre', '$descripcion', '$lugar', '$materiales', '$tipo', '$pasos')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>