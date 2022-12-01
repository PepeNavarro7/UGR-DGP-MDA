<?php
function deleteDirectory($dir) {
  if (!file_exists($dir)) {
      return true;
  }

  if (!is_dir($dir)) {
      return unlink($dir);
  }

  foreach (scandir($dir) as $item) {
      if ($item == '.' || $item == '..') {
          continue;
      }

      if (!deleteDirectory($dir . DIRECTORY_SEPARATOR . $item)) {
          return false;
      }

  }

  return rmdir($dir);
}

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

$nombre_sin_espacios = str_replace(' ', '', $nombre);
$apellidos_sin_espacios = str_replace(' ', '', $apellidos);
$foto_path = "../fotos_estudiantes/$nombre_sin_espacios$apellidos_sin_espacios.jpg";
unlink($foto_path);

if (is_dir("../pictogramas_password/$nombre_sin_espacios$apellidos_sin_espacios"))
  deleteDirectory("../pictogramas_password/$nombre_sin_espacios$apellidos_sin_espacios");

$sql = "DELETE FROM estudiantes WHERE id_estudiante='$id_estudiante'";

if ($conn->query($sql) === TRUE) {
  echo "Estudiante borrado";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>