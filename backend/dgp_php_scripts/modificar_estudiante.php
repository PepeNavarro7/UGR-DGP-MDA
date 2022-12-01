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

if(isset($_POST["email"])) {
    $email = $_POST["email"];
} else return;

if(isset($_POST["acceso"])) {
    $acceso = $_POST["acceso"];
} else return;

if(isset($_POST["acceso"])) {
    $acceso = $_POST["acceso"];
} else return;

if(isset($_POST["password_usuario"])) {
    $password_usuario = $_POST["password_usuario"];
} else return;

if(isset($_POST["foto"])) {
    $foto = $_POST["foto"];
    $nombre_sin_espacios = str_replace(' ', '', $nombre);
    $apellidos_sin_espacios = str_replace(' ', '', $apellidos);
    $foto_path = "../fotos_estudiantes/$nombre_sin_espacios$apellidos_sin_espacios.jpg";
    if($foto != "sin_cambios") {
        $filehandler = fopen($foto_path, 'wb');
        fwrite($filehandler, base64_decode($foto));
        fclose($filehandler);
    }

} else return;

if(isset($_POST["pictograma_clave_1"])) {
    $pictograma_clave_1 = $_POST["pictograma_clave_1"];
} else return;

if(isset($_POST["pictograma_clave_2"])) {
    $pictograma_clave_2 = $_POST["pictograma_clave_2"];
} else return;

if(isset($_POST["pictograma_clave_3"])) {
    $pictograma_clave_3 = $_POST["pictograma_clave_3"];
} else return;

if(isset($_POST["pictograma_clave_4"])) {
    $pictograma_clave_4 = $_POST["pictograma_clave_4"];
} else return;

if(isset($_POST["pictograma_no_clave_1"])) {
    $pictograma_no_clave_1 = $_POST["pictograma_no_clave_1"];
} else return;

if(isset($_POST["pictograma_no_clave_2"])) {
    $pictograma_no_clave_2 = $_POST["pictograma_no_clave_2"];
} else return;

if($acceso == "Pictogramas") {
    $directorio_pictogramas = "../pictogramas_password/$nombre_sin_espacios$apellidos_sin_espacios";
    mkdir($directorio_pictogramas, 0777);
    mkdir("$directorio_pictogramas/clave", 0777);

    $filehandler = fopen("$directorio_pictogramas/clave/pictograma_clave_1.jpg", 'w');
    fwrite($filehandler, base64_decode($pictograma_clave_1));
    fclose($filehandler);

    $filehandler = fopen("$directorio_pictogramas/clave/pictograma_clave_2.jpg", 'w');
    fwrite($filehandler, base64_decode($pictograma_clave_2));
    fclose($filehandler);

    $filehandler = fopen("$directorio_pictogramas/clave/pictograma_clave_3.jpg", 'w');
    fwrite($filehandler, base64_decode($pictograma_clave_3));
    fclose($filehandler);

    $filehandler = fopen("$directorio_pictogramas/clave/pictograma_clave_4.jpg", 'w');
    fwrite($filehandler, base64_decode($pictograma_clave_4));
    fclose($filehandler);

    $filehandler = fopen("$directorio_pictogramas/pictograma_no_clave_1.jpg", 'w');
    fwrite($filehandler, base64_decode($pictograma_no_clave_1));
    fclose($filehandler);

    $filehandler = fopen("$directorio_pictogramas/pictograma_no_clave_2.jpg", 'w');
    fwrite($filehandler, base64_decode($pictograma_no_clave_2));
    fclose($filehandler);
}


// Create connection
$conn = new mysqli($servername, $username_db, $password_db, $name_db);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE estudiantes SET nombre='$nombre', apellidos='$apellidos', email='$email', acceso='$acceso', accesibilidad='$accesibilidad', password_usuario='$password_usuario', foto='$foto_path' WHERE estudiantes.id_estudiante='$id_estudiante'";

if ($conn->query($sql) === TRUE) {
  echo "New modification done successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
