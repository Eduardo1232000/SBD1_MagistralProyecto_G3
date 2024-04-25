USE PROYMAGIS;

-- PAIS
INSERT INTO pais (nombrepais) 
	SELECT DISTINCT PAIS FROM tabla_temporal;

-- REGION
INSERT INTO region (idpais, nombreregion)
	SELECT p.idpais, tt.region
	FROM tabla_temporal tt
	JOIN pais p ON tt.pais = p.nombrepais
	GROUP BY p.idpais, tt.region;

-- DEPARTAMENTO
INSERT INTO departamento (idregion, nombredepartamento)
	SELECT DISTINCT r.idregion, tt.DEPTO
	FROM tabla_temporal tt
	JOIN region r ON tt.region = r.nombreregion
	JOIN pais p ON r.idpais = p.idpais AND tt.pais = p.nombrepais;

-- MUNICIPIO
INSERT INTO municipio (iddepartamento, nombremunicipio)
SELECT d.iddepartamento, tt.municipio
FROM tabla_temporal tt
JOIN departamento d ON tt.depto = d.nombredepartamento
GROUP BY d.iddepartamento, tt.municipio;

-- NOMBREELECCION
INSERT INTO nombreeleccion (nombre_eleccion)
SELECT DISTINCT nombre_eleccion
FROM tabla_temporal;

-- ELECCION
INSERT INTO eleccion (idmunicipio, yeareleccion, idnombreeleccion)
SELECT m.idmunicipio, tt.año_eleccion, ne.idnombreeleccion 
FROM tabla_temporal tt
INNER JOIN pais p ON tt.pais = p.nombrepais
INNER JOIN region r  ON tt.REGION  = r.nombreregion AND p.idpais = r.idpais 
INNER JOIN departamento d  ON tt.DEPTO = d.nombredepartamento AND r.idregion = d.idregion 
INNER JOIN municipio m  ON tt.MUNICIPIO  = m.nombremunicipio AND d.iddepartamento = m.iddepartamento 
INNER JOIN nombreeleccion ne ON tt.NOMBRE_ELECCION = ne.nombre_eleccion
GROUP BY m.idmunicipio, tt.año_eleccion, ne.idnombreeleccion ;



-- PARTIDOPOLITICO
INSERT INTO partidopolitico(idpartido, nombrepartido)
SELECT DISTINCT PARTIDO , NOMBRE_PARTIDO 
FROM tabla_temporal;

-- RESULTADOS (PARA SABER LOS DE PRESIDENTE SE SUMAN TODOS LOS VOTOS DEL PAIS, ALCALDE MUNICIPAL ETC)
INSERT INTO resultados(ideleccion, idpartido, sexo, raza, analfabetos, primaria, nivelmedio, universitarios)  
SELECT  e.ideleccion, tt.PARTIDO, tt.SEXO, tt.RAZA, tt.ANALFABETOS, tt.PRIMARIA, tt.NIVELMEDIO, tt.UNIVERSITARIOS  
FROM eleccion e 
INNER JOIN municipio m ON e.idmunicipio = m.idmunicipio 
INNER JOIN departamento d ON m.iddepartamento  = d.iddepartamento
INNER JOIN region r2 ON d.idregion = r2.idregion 
INNER JOIN pais p ON r2.idpais = p.idpais
INNER JOIN tabla_temporal tt ON m.nombremunicipio = tt.MUNICIPIO 
	AND d.nombredepartamento = tt.DEPTO 
	AND r2.nombreregion = tt.REGION
	AND p.nombrepais = tt.PAIS 
	AND e.yeareleccion = tt.AÑO_ELECCION 
;