-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 10-11-2022 a las 11:29:55
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dgp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `id_estudiante` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `acceso` varchar(50) NOT NULL,
  `accesibilidad` varchar(50) NOT NULL,
  `password_usuario` varchar(50) NOT NULL,
  `foto` mediumblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`id_estudiante`, `nombre`, `apellidos`, `email`, `acceso`, `accesibilidad`, `password_usuario`, `foto`) VALUES
(32, 'Jose Miguel', 'Marquez Herreros', 'jmiguelmh@correo.ugr.es', 'Alfanumerico', 'audio y video', 'josemi1234', 0x61),
(43, 'Maria', 'Sanchez Martinez', 'mariasm@gmail.com', 'Alfanumerico', '', 'maria1234', 0x61);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `realiza`
--

CREATE TABLE `realiza` (
  `id_tarea` int(11) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `completada` tinyint(1) DEFAULT NULL,
  `calificacion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `realiza`
--

INSERT INTO `realiza` (`id_tarea`, `id_estudiante`, `fecha_inicio`, `fecha_fin`, `completada`, `calificacion`) VALUES
(15, 32, '2022-10-10 00:00:00', '2022-10-10 00:00:01', 1, 'Muy bien'),
(18, 32, '2022-10-10 00:00:00', '2022-10-10 00:00:00', 0, 'Pendiente'),
(18, 43, '2022-10-10 00:00:00', '2022-10-10 00:00:00', 1, 'Bien'),
(19, 43, '2022-10-10 00:00:01', '2022-10-10 00:00:10', 1, 'Muy bien');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id_tarea` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `lugar` varchar(50) NOT NULL,
  `tipo` char(1) NOT NULL,
  `pasos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`pasos`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id_tarea`, `nombre`, `descripcion`, `lugar`, `tipo`, `pasos`) VALUES
(15, 'Pasa menus clase A', 'El estudiante debe contar los tipos y cantidades de cada menu para mandarlo a cocina', 'Clase A', 'M', '[\"Ir a la clase A\",\"Preguntar por cada tipo de menu\",\"Hacer la cuenta de las cantidades\"]'),
(18, 'Tarea de ejemplo', 'Descripcion de ejemplo', 'Lugar de ejemplo', 'C', '[\"paso de ejemplo\"]'),
(19, 'Tarea 2', 'a', 'a', 'N', '[\"a\"]');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`id_estudiante`);

--
-- Indices de la tabla `realiza`
--
ALTER TABLE `realiza`
  ADD PRIMARY KEY (`id_tarea`,`id_estudiante`,`fecha_inicio`),
  ADD KEY `id_estudiante` (`id_estudiante`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id_tarea`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `id_estudiante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `realiza`
--
ALTER TABLE `realiza`
  ADD CONSTRAINT `realiza_ibfk_1` FOREIGN KEY (`id_tarea`) REFERENCES `tareas` (`id_tarea`),
  ADD CONSTRAINT `realiza_ibfk_2` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
