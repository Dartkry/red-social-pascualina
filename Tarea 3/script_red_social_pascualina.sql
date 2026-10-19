-- =========================================================================
-- Script DDL: Red Social Estudiantil Pascualina
-- SGBD: MySQL
-- =========================================================================

DROP DATABASE IF EXISTS red_social_pascualina;
CREATE DATABASE IF NOT EXISTS red_social_pascualina;
USE red_social_pascualina;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    correo_institucional VARCHAR(100) UNIQUE NOT NULL,
    area_estudio VARCHAR(100) NOT NULL,
    habilidades VARCHAR(255),
    biografia TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conexiones (
    usuario_origen_id INT NOT NULL,
    usuario_destino_id INT NOT NULL,
    fecha_conexion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (usuario_origen_id, usuario_destino_id),
    CONSTRAINT fk_usuario_origen FOREIGN KEY (usuario_origen_id)
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_destino FOREIGN KEY (usuario_destino_id)
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE grupos_estudio (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_grupo VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creador_id INT,
    CONSTRAINT fk_creador_grupo FOREIGN KEY (creador_id)
        REFERENCES usuarios(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE miembros_grupo (
    grupo_id INT NOT NULL,
    usuario_id INT NOT NULL,
    rol VARCHAR(50) DEFAULT 'Miembro',
    fecha_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (grupo_id, usuario_id),
    CONSTRAINT fk_grupo_miembro FOREIGN KEY (grupo_id)
        REFERENCES grupos_estudio(id_grupo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_miembro FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE publicaciones (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    autor_id INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_autor_publicacion FOREIGN KEY (autor_id)
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE eventos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_evento DATETIME NOT NULL,
    organizador_id INT NOT NULL,
    grupo_id INT,
    CONSTRAINT fk_organizador_evento FOREIGN KEY (organizador_id)
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_grupo_evento FOREIGN KEY (grupo_id)
        REFERENCES grupos_estudio(id_grupo) ON DELETE CASCADE ON UPDATE CASCADE
);