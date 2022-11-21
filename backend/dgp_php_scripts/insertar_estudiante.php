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

if(isset($_POST["password_usuario"])) {
    $password_usuario = $_POST["password_usuario"];
} else return;

if(isset($_POST["foto"])) {
    $foto = $_POST["foto"];
    $nombre_sin_espacios = str_replace(' ', '', $nombre);
    $apellidos_sin_espacios = str_replace(' ', '', $apellidos);
    $foto_path = "../fotos_estudiantes/$nombre_sin_espacios$apellidos_sin_espacios.jpg";
    $filehandler = fopen($foto_path, 'wb');
    fwrite($filehandler, base64_decode($foto));
    fclose($filehandler);

} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO estudiantes (nombre, apellidos, email, acceso, accesibilidad, password_usuario, foto)
VALUES ('$nombre', '$apellidos', '$email', '$acceso', '$accesibilidad', '$password_usuario', '$foto_path')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>