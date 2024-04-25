CREATE DATABASE PROYMAGIS;

USE PROYMAGIS;

CREATE TABLE tabla_temporal (
    NOMBRE_ELECCION VARCHAR(30),
    AÑO_ELECCION INT,
    PAIS VARCHAR(30),
    REGION VARCHAR(30),
    DEPTO VARCHAR(30),
    MUNICIPIO VARCHAR(60),
    PARTIDO VARCHAR(30),
    NOMBRE_PARTIDO VARCHAR(30),
    SEXO VARCHAR(20),
    RAZA VARCHAR(20),
    ANALFABETOS INT,
    ALFABETOS INT,
    PRIMARIA INT,
    NIVELMEDIO INT,
    UNIVERSITARIOS INT
);

CREATE TABLE pais (
    idpais     INT NOT NULL AUTO_INCREMENT,
    nombrepais VARCHAR(60) NOT NULL,
    PRIMARY KEY (idpais)
);

CREATE TABLE region (
    idregion     INT NOT NULL AUTO_INCREMENT,
    idpais       INT NOT NULL,
    nombreregion VARCHAR(60) NOT NULL,
    PRIMARY KEY (idregion),
    CONSTRAINT region_pais_fk FOREIGN KEY (idpais) REFERENCES pais (idpais)
);

CREATE TABLE departamento (
    iddepartamento     INT NOT NULL AUTO_INCREMENT,
    idregion           INT NOT NULL,
    nombredepartamento VARCHAR(60) NOT NULL,
    PRIMARY KEY (iddepartamento),
    CONSTRAINT departamento_region_fk FOREIGN KEY (idregion) REFERENCES region (idregion)
);

CREATE TABLE municipio (
    idmunicipio     INT NOT NULL AUTO_INCREMENT,
    iddepartamento  INT NOT NULL,
    nombremunicipio VARCHAR(60) NOT NULL,
    PRIMARY KEY (idmunicipio),
    CONSTRAINT municipio_departamento_fk FOREIGN KEY (iddepartamento) REFERENCES departamento (iddepartamento)
);

CREATE TABLE nombreeleccion (
    idnombreeleccion INT NOT NULL AUTO_INCREMENT,
    nombre_eleccion  VARCHAR(60) NOT NULL,
    PRIMARY KEY (idnombreeleccion)
);

CREATE TABLE eleccion (
    ideleccion       INT NOT NULL AUTO_INCREMENT,
    idmunicipio      INT NOT NULL,
    yeareleccion     INT NOT NULL,
    idnombreeleccion INT NOT NULL,
    PRIMARY KEY (ideleccion),
    CONSTRAINT eleccion_municipio_fk FOREIGN KEY (idmunicipio) REFERENCES municipio (idmunicipio),
    CONSTRAINT eleccion_nombreeleccion_fk FOREIGN KEY (idnombreeleccion) REFERENCES nombreeleccion (idnombreeleccion)
);

CREATE TABLE partidopolitico (
    idpartido     VARCHAR(30) NOT NULL,
    nombrepartido VARCHAR(60) NOT NULL,
    PRIMARY KEY (idpartido)
);



CREATE TABLE resultados (
    ideleccion     INT NOT NULL,
    idpartido      VARCHAR(30) NOT NULL,
    sexo           VARCHAR(20) NOT NULL,
    raza           VARCHAR(20) NOT NULL,
    analfabetos    INT NOT NULL,
    primaria       INT NOT NULL,
    nivelmedio     INT NOT NULL,
    universitarios INT NOT NULL,
    PRIMARY KEY (ideleccion,idpartido,sexo,raza),
    CONSTRAINT resultados_eleccion_fk FOREIGN KEY (ideleccion) REFERENCES eleccion (ideleccion),
    CONSTRAINT resultados_partidopolitico_fk FOREIGN KEY (idpartido) REFERENCES partidopolitico (idpartido)
);