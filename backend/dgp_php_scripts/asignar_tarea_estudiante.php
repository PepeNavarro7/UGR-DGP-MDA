<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

if(isset($_POST["id_tarea"])) {
    $id_tarea = $_POST["id_tarea"];
} else return;

if(isset($_POST["id_estudiante"])) {
    $id_estudiante = $_POST["id_estudiante"];
} else return;

if(isset($_POST["fecha_inicio"])) {
  $fecha_inicio = $_POST["fecha_inicio"];
} else return;

if(isset($_POST["fecha_fin"])) {
    $fecha_fin = $_POST["fecha_fin"];
} else return;

if(isset($_POST["completada"])) {
    $completada = $_POST["completada"];
} else return;

if(isset($_POST["calificacion"])) {
    $calificacion = $_POST["calificacion"];
} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO realiza (id_tarea, id_estudiante, fecha_inicio, fecha_fin, completada, calificacion)
VALUES ('$id_tarea', '$id_estudiante', '$fecha_inicio', '$fecha_fin', '$completada', '$calificacion')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>