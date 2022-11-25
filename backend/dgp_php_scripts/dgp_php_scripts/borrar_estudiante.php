<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

if(isset($_POST["id_estudiante"])) {
    $id_estudiante = $_POST["id_estudiante"];
} else return;

if(isset($_POST["nombre"])) {
    $nombre = $_POST["nombre"];
} else return;

if(isset($_POST["apellidos"])) {
    $apellidos = $_POST["apellidos"];
} else return;


// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "DELETE FROM estudiantes WHERE id_estudiante='$id_estudiante'";

$nombre_sin_espacios = str_replace(' ', '', $nombre);
$apellidos_sin_espacios = str_replace(' ', '', $apellidos);
$foto_path = "../fotos_estudiantes/$nombre_sin_espacios$apellidos_sin_espacios.jpg";
if(!unlink($foto_path))
    echo "fallo al borrar foto";
else
    return;

if ($conn->query($sql) === TRUE) {
  echo "New delete done successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
