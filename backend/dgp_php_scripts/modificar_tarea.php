<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

if(isset($_POST["nombre_antiguo"])) {
    $nombre_antiguo = $_POST["nombre_antiguo"];
} else return;

if(isset($_POST["nombre_nuevo"])) {
    $nombre_nuevo = $_POST["nombre_nuevo"];
} else return;

if(isset($_POST["descripcion_nuevo"])) {
    $descripcion_nuevo = $_POST["descripcion_nuevo"];
} else return;

if(isset($_POST["lugar_nuevo"])) {
  $lugar_nuevo = $_POST["lugar_nuevo"];
} else return;

if(isset($_POST["tipo_nuevo"])) {
    $tipo_nuevo = $_POST["tipo_nuevo"];
} else return;

if(isset($_POST["pasos_nuevo"])) {
    $pasos_nuevo = $_POST["pasos_nuevo"];
} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE tareas SET nombre='$nombre_nuevo', descripcion='$descripcion_nuevo', lugar='$lugar_nuevo', tipo='$tipo_nuevo', pasos='$pasos_nuevo' WHERE tareas.nombre='$nombre_antiguo'";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>