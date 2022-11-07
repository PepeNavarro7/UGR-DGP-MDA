<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

if(isset($_POST["nombre_antiguo"])) {
    $nombre_antiguo = $_POST["nombre_antiguo"];
} else return;

if(isset($_POST["apellidos_antiguo"])) {
    $apellidos_antiguo = $_POST["apellidos_antiguo"];
} else return;

if(isset($_POST["email_antiguo"])) {
    $email_antiguo = $_POST["email_antiguo"];
} else return;

if(isset($_POST["nombre_nuevo"])) {
    $nombre_nuevo = $_POST["nombre_nuevo"];
} else return;

if(isset($_POST["apellidos_nuevo"])) {
    $apellidos_nuevo = $_POST["apellidos_nuevo"];
} else return;

if(isset($_POST["email_nuevo"])) {
    $email_nuevo = $_POST["email_nuevo"];
} else return;

if(isset($_POST["acceso_nuevo"])) {
    $acceso_nuevo = $_POST["acceso_nuevo"];
} else return;

if(isset($_POST["accesibilidad_nuevo"])) {
    $accesibilidad_nuevo = $_POST["accesibilidad_nuevo"];
} else return;

if(isset($_POST["password_usuario_nuevo"])) {
    $password_usuario_nuevo = $_POST["password_usuario_nuevo"];
} else return;

if(isset($_POST["foto_nuevo"])) {
    $foto_nuevo = $_POST["foto_nuevo"];
} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE estudiantes SET nombre='$nombre_nuevo', apellidos='$apellidos_nuevo', email='$email_nuevo', acceso='$acceso_nuevo', accesibilidad='$accesibilidad_nuevo', password_usuario='$password_usuario_nuevo', foto='$foto_nuevo' WHERE estudiantes.nombre='$nombre_antiguo' AND estudiantes.apellidos='$apellidos_antiguo' AND estudiantes.email='$email_antiguo'";

if ($conn->query($sql) === TRUE) {
  echo "New modification done successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>