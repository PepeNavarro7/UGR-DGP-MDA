<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql_query = "SELECT id_tarea, nombre, descripcion, lugar, tipo, pasos FROM tareas";

$result = mysqli_query($conn, $sql_query);
if ($result) {
  $i = 0;
  while ($row = mysqli_fetch_assoc($result)) {
    $response[$i]['id_tarea'] = $row['id_tarea'];
    $response[$i]['nombre'] = $row['nombre'];
    $response[$i]['descripcion'] = $row['descripcion'];
    $response[$i]['lugar'] = $row['lugar'];
    $response[$i]['tipo'] = $row['tipo'];
    $response[$i]['pasos'] = $row['pasos'];
    $i++;
  }

  echo json_encode($response, JSON_PRETTY_PRINT);
}




$conn->close();
?>