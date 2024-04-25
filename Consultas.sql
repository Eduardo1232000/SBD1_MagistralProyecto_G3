USE PROYMAGIS;
-- 1
-- Desplegar para cada elección el país y el partido político que obtuvo mayor 
-- porcentaje de votos en su país. Debe desplegar el nombre de la elección, el 
-- año de la elección, el país, el nombre del partido político y el porcentaje que 
-- obtuvo de votos en su país. 

SELECT 
	subcon.snombre_eleccion,
	subcon.syeareleccion,
	subcon.snombrepais,
    subcon.idpartido,
    (subcon.max_votos_sexoraza/maximovotos.maxvotospais * 100) as porcentaje
FROM
	(
		SELECT 
			subconsulta.nombre_eleccion as snombre_eleccion,
			subconsulta.yeareleccion as syeareleccion,
		    subconsulta.nombrepais as snombrepais,
		    MAX(subconsulta.idpartido) AS idpartido,
		    MAX(subconsulta.votos_sexoraza) AS max_votos_sexoraza
		FROM 
		    (
		        SELECT 
		        	n.nombre_eleccion,
		            p.nombrepais,
		            e.yeareleccion,
		            pp.idpartido,
		            SUM(r.analfabetos + r.primaria + r.nivelmedio + r.universitarios) AS votos_sexoraza
		        FROM 
		            resultados r
		        INNER JOIN 
		            eleccion e ON r.ideleccion = e.ideleccion 
		        INNER JOIN 
		            municipio m ON e.idmunicipio = m.idmunicipio 
		        INNER JOIN 
		            departamento d ON m.iddepartamento  = d.iddepartamento
		        INNER JOIN 
		            region r2 ON d.idregion = r2.idregion 
		        INNER JOIN 
		            pais p ON r2.idpais = p.idpais
		        INNER JOIN 
		            partidopolitico pp ON r.idpartido = pp.idpartido
		        INNER JOIN nombreeleccion n ON e.idnombreeleccion = n.idnombreeleccion
		        GROUP BY 
		        	n.nombre_eleccion,
		            p.nombrepais, 
		            e.yeareleccion,
		            pp.idpartido
		    ) AS subconsulta
		GROUP BY 
			subconsulta.nombre_eleccion,
		    subconsulta.nombrepais, 
		    subconsulta.yeareleccion
	) AS subcon
	,(
		SELECT 
			p.nombrepais,
		    e.yeareleccion,
		    SUM(r.analfabetos + r.primaria + r.nivelmedio + r.universitarios) AS maxvotospais
		FROM 
			resultados r
		INNER JOIN eleccion e ON r.ideleccion = e.ideleccion 
		INNER JOIN municipio m ON e.idmunicipio = m.idmunicipio 
		INNER JOIN departamento d ON m.iddepartamento  = d.iddepartamento
		INNER JOIN region r2 ON d.idregion = r2.idregion 
		INNER JOIN pais p ON r2.idpais = p.idpais
		INNER JOIN partidopolitico pp ON r.idpartido = pp.idpartido
		GROUP BY 
		    p.nombrepais, 
		    e.yeareleccion
    ) AS maximovotos
WHERE maximovotos.nombrepais =  subcon.snombrepais
GROUP BY 
		subcon.snombre_eleccion,
	    subcon.snombrepais, 
	    subcon.syeareleccion,
	    maximovotos.maxvotospais;





-- 2
-- Desplegar total de votos y porcentaje de votos de mujeres por departamento 
-- y país. El ciento por ciento es el total de votos de mujeres por país. (Tip: 
-- Todos los porcentajes por departamento de un país deben sumar el 100%) 
   
SELECT 
	votos_mujeres_departamento.nombre_eleccion,
	votos_mujeres_departamento.yeareleccion,
	votos_mujeres_departamento.nombrepais,
    votos_mujeres_departamento.nombredepartamento,
    (votos_mujeres_departamento.votosdeptomujeres / maximovotos_mujer.total_votos_mujer * 100) as porcentaje
FROM
	(
		SELECT 
			n.nombre_eleccion,
			p.nombrepais,
			d.nombredepartamento, 
		    e.yeareleccion,
		    SUM(r.analfabetos + r.primaria + r.nivelmedio + r.universitarios) AS votosdeptomujeres
		FROM 
			resultados r
		INNER JOIN eleccion e ON r.ideleccion = e.ideleccion 
		INNER JOIN municipio m ON e.idmunicipio = m.idmunicipio 
		INNER JOIN departamento d ON m.iddepartamento  = d.iddepartamento
		INNER JOIN region r2 ON d.idregion = r2.idregion 
		INNER JOIN pais p ON r2.idpais = p.idpais
		INNER JOIN partidopolitico pp ON r.idpartido = pp.idpartido
		INNER JOIN nombreeleccion n ON e.idnombreeleccion = n.idnombreeleccion
		WHERE r.sexo = 'mujeres'
		GROUP BY 
			n.nombre_eleccion,
		    p.nombrepais,
		    d.nombredepartamento, 
		    e.yeareleccion
	) AS votos_mujeres_departamento
	,(
		SELECT 
			p.nombrepais,
		    e.yeareleccion,
		    SUM(r.analfabetos + r.primaria + r.nivelmedio + r.universitarios) AS total_votos_mujer
		FROM 
			resultados r
		INNER JOIN eleccion e ON r.ideleccion = e.ideleccion 
		INNER JOIN municipio m ON e.idmunicipio = m.idmunicipio 
		INNER JOIN departamento d ON m.iddepartamento  = d.iddepartamento
		INNER JOIN region r2 ON d.idregion = r2.idregion 
		INNER JOIN pais p ON r2.idpais = p.idpais
		INNER JOIN partidopolitico pp ON r.idpartido = pp.idpartido
		WHERE r.sexo = 'mujeres'
		GROUP BY 
		    p.nombrepais, 
		    e.yeareleccion
    ) AS maximovotos_mujer
WHERE votos_mujeres_departamento.nombrepais =  maximovotos_mujer.nombrepais
GROUP BY 
		votos_mujeres_departamento.nombre_eleccion,
		votos_mujeres_departamento.yeareleccion,
		votos_mujeres_departamento.nombrepais,
    	votos_mujeres_departamento.nombredepartamento,
    	porcentaje
;	 






-- 3 
-- Desplegar el nombre del país, nombre del partido político y número de 
-- alcaldías de los partidos políticos que ganaron más alcaldías por país. 





-- 4
-- Desplegar todas las regiones por país en las que predomina la raza indígena. 
-- Es decir, hay más votos que las otras razas. 
SELECT 
    nombre_eleccion,
    yeareleccion,
    nombrepais,
    nombreregion,
    raza,
    votos
FROM (
    SELECT 
        nombre_eleccion,
        yeareleccion,
        nombrepais,
        nombreregion,
        raza,
        votos,
        ROW_NUMBER() OVER (PARTITION BY nombre_eleccion, yeareleccion, nombrepais, nombreregion ORDER BY votos DESC) AS rn
    FROM (
        SELECT 
            n.nombre_eleccion,
            p.nombrepais,
            r2.nombreregion, 
            e.yeareleccion,
            r.raza, 
            SUM(r.analfabetos + r.primaria + r.nivelmedio + r.universitarios) AS votos
        FROM 
            resultados r
        INNER JOIN eleccion e ON r.ideleccion = e.ideleccion 
        INNER JOIN municipio m ON e.idmunicipio = m.idmunicipio 
        INNER JOIN departamento d ON m.iddepartamento = d.iddepartamento
        INNER JOIN region r2 ON d.idregion = r2.idregion 
        INNER JOIN pais p ON r2.idpais = p.idpais
        INNER JOIN partidopolitico pp ON r.idpartido = pp.idpartido
        INNER JOIN nombreeleccion n ON e.idnombreeleccion = n.idnombreeleccion
        GROUP BY 
            n.nombre_eleccion,
            p.nombrepais,
            r2.nombreregion, 
            e.yeareleccion,
            r.raza
    ) AS votos_raza
) AS ranked
WHERE rn = 1 AND raza = 'INDIGENAS';





-- 5 
-- Desplegar el porcentaje de mujeres universitarias y hombres universitarios 
-- que votaron por departamento, donde las mujeres universitarias que votaron 
-- fueron más que los hombres universitarios que votaron. 
SELECT 
	mayordepto.nombre_eleccion,
	mayordepto.nombrepais,
	mayordepto.nombredepartamento,
	mayordepto.mayor_votos,
	mayordepto.votos,
	totalesdepto.votos,
	(mayordepto.votos / totalesdepto.votos *100)as porcentaje
FROM 
	(
		SELECT 
			votosmujeresuni.nombre_eleccion,
			votosmujeresuni.nombrepais,
			votosmujeresuni.nombredepartamento,
			votosmujeresuni.yeareleccion,
			CASE 
		        WHEN votosmujeresuni.votos > votoshombresuni.votos THEN 'Mujeres'
		        ELSE 'Hombres'
		    END AS mayor_votos,
		    CASE 
		        WHEN votosmujeresuni.votos > votoshombresuni.votos THEN votosmujeresuni.votos
		        ELSE votoshombresuni.votos
		    END AS votos
		FROM 
			(
				SELECT 
		            n.nombre_eleccion,
		            p.nombrepais,
		            d.nombredepartamento , 
		            e.yeareleccion,
		            r.sexo, 
		            SUM(r.universitarios) AS votos
		        FROM 
		            resultados r
		        INNER JOIN eleccion e ON r.ideleccion = e.ideleccion 
		        INNER JOIN municipio m ON e.idmunicipio = m.idmunicipio 
		        INNER JOIN departamento d ON m.iddepartamento = d.iddepartamento
		        INNER JOIN region r2 ON d.idregion = r2.idregion 
		        INNER JOIN pais p ON r2.idpais = p.idpais
		        INNER JOIN nombreeleccion n ON e.idnombreeleccion = n.idnombreeleccion
		        WHERE r.sexo = 'mujeres' 
		        GROUP BY 
		            n.nombre_eleccion,
		            p.nombrepais,
		            d.nombredepartamento , 
		            e.yeareleccion,
		            r.sexo
			) AS votosmujeresuni,
			(
				SELECT 
		            n.nombre_eleccion,
		            p.nombrepais,
		            d.nombredepartamento , 
		            e.yeareleccion,
		            r.sexo, 
		            SUM( r.universitarios) AS votos
		        FROM 
		            resultados r
		        INNER JOIN eleccion e ON r.ideleccion = e.ideleccion 
		        INNER JOIN municipio m ON e.idmunicipio = m.idmunicipio 
		        INNER JOIN departamento d ON m.iddepartamento = d.iddepartamento
		        INNER JOIN region r2 ON d.idregion = r2.idregion 
		        INNER JOIN pais p ON r2.idpais = p.idpais
		        INNER JOIN nombreeleccion n ON e.idnombreeleccion = n.idnombreeleccion
		        WHERE r.sexo = 'hombres' 
		        GROUP BY 
		            n.nombre_eleccion,
		            p.nombrepais,
		            d.nombredepartamento , 
		            e.yeareleccion,
		            r.sexo
			) AS votoshombresuni
		WHERE votosmujeresuni.nombre_eleccion = votoshombresuni.nombre_eleccion  
			AND votosmujeresuni.nombrepais = votoshombresuni.nombrepais
			AND votosmujeresuni.nombredepartamento = votoshombresuni.nombredepartamento
			AND votosmujeresuni.yeareleccion = votoshombresuni.yeareleccion
	) as mayordepto,
	(
		SELECT 
            n.nombre_eleccion,
            p.nombrepais,
            d.nombredepartamento , 
            e.yeareleccion, 
            SUM(r.analfabetos + r.primaria + r.nivelmedio + r.universitarios) AS votos
        FROM 
            resultados r
        INNER JOIN eleccion e ON r.ideleccion = e.ideleccion 
        INNER JOIN municipio m ON e.idmunicipio = m.idmunicipio 
        INNER JOIN departamento d ON m.iddepartamento = d.iddepartamento
        INNER JOIN region r2 ON d.idregion = r2.idregion 
        INNER JOIN pais p ON r2.idpais = p.idpais
        INNER JOIN partidopolitico pp ON r.idpartido = pp.idpartido
        INNER JOIN nombreeleccion n ON e.idnombreeleccion = n.idnombreeleccion
        GROUP BY 
            n.nombre_eleccion,
            p.nombrepais,
            d.nombredepartamento, 
            e.yeareleccion
	) as totalesdepto
WHERE totalesdepto.nombre_eleccion = mayordepto.nombre_eleccion
	AND totalesdepto.nombrepais = mayordepto.nombrepais
	AND totalesdepto.nombredepartamento = mayordepto.nombredepartamento
	AND totalesdepto.yeareleccion = mayordepto.yeareleccion
;