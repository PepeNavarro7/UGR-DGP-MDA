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

$sql_query = "SELECT nombre, apellidos, email, acceso, accesibilidad, password_usuario, foto FROM estudiantes";

$result = mysqli_query($conn, $sql_query);
if ($result) {
  $i = 0;
  while ($row = mysqli_fetch_assoc($result)) {
    $response[$i]['nombre'] = $row['nombre'];
    $response[$i]['apellidos'] = $row['apellidos'];
    $response[$i]['email'] = $row['email'];
    $response[$i]['acceso'] = $row['acceso'];
    $response[$i]['accesibilidad'] = $row['accesibilidad'];
    $response[$i]['password_usuario'] = $row['password_usuario'];
    $response[$i]['foto'] = $row['foto'];
    $i++;
  }

  echo json_encode($response, JSON_PRETTY_PRINT);
}




$conn->close();
?>