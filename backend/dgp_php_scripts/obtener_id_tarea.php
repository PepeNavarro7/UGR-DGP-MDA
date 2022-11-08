<?php
$servername = "localhost";
$username_db = "root";
$password_db = "";
$name_db = "dgp";

if(isset($_POST["nombre"])) {
    $nombre = $_POST["nombre"];
} else return;

// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql_query = "SELECT id_tarea FROM tareas WHERE tareas.nombre='$nombre'";

$result = mysqli_query($conn, $sql_query);
if ($result) {
  $i = 0;
  while ($row = mysqli_fetch_assoc($result)) {
    $response[$i]['id_tarea'] = $row['id_tarea'];
    $i++;
  }

  echo json_encode($response, JSON_PRETTY_PRINT);
}

$conn->close();
?>