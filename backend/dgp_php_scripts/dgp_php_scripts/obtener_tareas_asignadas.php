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

$sql_query = "SELECT id_tarea, id_estudiante, fecha_inicio, fecha_fin, completada, calificacion FROM realiza";

$result = mysqli_query($conn, $sql_query);
if ($result) {
  $i = 0;
  while ($row = mysqli_fetch_assoc($result)) {
    $response[$i]['id_tarea'] = $row['id_tarea'];
    $response[$i]['id_estudiante'] = $row['id_estudiante'];
    $response[$i]['fecha_inicio'] = $row['fecha_inicio'];
    $response[$i]['fecha_fin'] = $row['fecha_fin'];
    $response[$i]['completada'] = $row['completada'];
    $response[$i]['calificacion'] = $row['calificacion'];
    $i++;
  }

  echo json_encode($response, JSON_PRETTY_PRINT);
}




$conn->close();
?>