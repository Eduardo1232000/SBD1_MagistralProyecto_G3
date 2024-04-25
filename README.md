#### Universidad de San Carlos de Guatemala
#### Facultad de Ingenieria
#### Sistemas de bases de datos 1 Sección N
#### Catedratico:  Ing. Alvaro G. Longo M.  
 
<br><br><br><br><br><br><br>
<div style="text-align: center;">
  <span style="font-size: 34px;"><strong>Proyecto Grupo 3<br>Documentación de análisis</strong></span>
</div>
<br><br><br><br><br><br><br>


| Nombre Completo                     | Carnet    
| :---:                               |  :----:   
| Luis Antonio Cutzal Chalí           | 201700841
| Eduardo Alexander Reyez Gonzales    | 202010904
| Pedro Martín Francisco              | 201700656
| Camilo Ernesto Sincal Sipac         | 202000605

<br><br>

---
<br><br>

### Objetivos:
#### Objetivo General:
<p style="text-align: justify;">
Implementar un sistema de gestión de datos eficiente que permita diseñar, desarrollar y mantener un modelo relacional, realizar cargas masivas de datos en una plataforma específica y generar consultas avanzadas en lenguaje SQL para satisfacer las necesidades de reportes requeridas
</p>

#### Objetivos Específicos

- Diseñar y desarrollar un modelo relacional a partir del planteamiento de un
problema y el análisis de un archivo de datos.
- Realizar una carga masiva de datos de la información proporcionada a una
nueva plataforma mediante la creación de una tabla temporal distribuyendo la
información de la carga al modelo relacional propuesto.
- Generar consultas avanzadas en lenguaje SQL que cumplan con los reportes
solicitados.

---
<br><br>

### Descripcion del Proyecto<br><br>

<p style="text-align: justify;">
Después de su demostración exitosa de conocimientos para la configuración de la red local de la empresa “Solución al Cliente S.A.” usted fue recomendado para trabajar en la construcción de una nueva red local, esta vez para la municipalidad de Guatemala.
</p>
<p style="text-align: justify;">
Ellos necesitan que se cree una red donde diferentes departamentos puedan coexistir, compartiendo el mismo medio físico, esto con el fin de ahorrar costos en instalación, además es importante para ellos que exista redundancia, esto debido a que partes críticas de la infraestructura de la municipalidad estarán en la red que se creará.
</p>
<p style="text-align: justify;">
A modo de demostración de concepto se contará con una topología de red reducida que simulará las interacciones entre los distintos componentes.
</p>

<p style="text-align: justify;">
La red propuesta contiene 4 departamentos, Contabilidad, Secretaria, Recursos Humanos(RRHH) e Informática (IT).
</p>

<p style="text-align: justify;">
Se solicitó que no exista tránsito de datos entre departamentos, los cuales están identificados por VLANS de la siguiente forma.
</p>


| Departamento | VLAN | ID de red |
|:---------:|:---------:|:---------:|
|   Contabilidad  |   14  |   192.168.14.0/24  |
|   Secretaria    |   24  |   192.168.24.0/24  |
|   RRHH          |   34  |   192.168.34.0/24  |
|   IT            |   44  |   192.168.44.0/24  |

__Nota: /24 es la notación de máscara subred. 
Tome en cuenta que esto es equivalente a 255.255.255.0.__


_____

### Secciones<br><br>

**Área de trabajo:** 
<p style="text-align: justify;">
En esta área se encuentran todos los dispositivos físicos de cada departamento. Modos de configuración: cliente: SW11, SW12, SW13
</p>

![Topologia de la red del area de trabajo](imagenesManual/1.png)


**Centro administrativo:** 
<p style="text-align: justify;">
Centro Administrativo: En este se ubica el espacio destinado la administración principal para cada departamento.
Modos de configuración: Cliente: SW7, SW8, SW10, Transparente: SW9
</p>

![Topologia de la red del centro administrativo](imagenesManual/2.png)

**Backbone:** 
<p style="text-align: justify;">
Son los encargados de dar redun-
dancia y conectividad entre todos los departamentos y sus servidores. En esta red se deberá localizar tanto el servidor VTP como la raíz del STP. Modos de configuración: Server: SW1 Cliente: SW2, SW3, SW4, SW5, SW6 Configurar STP con los siguientes datos: SW1 será el root bridge para la VLAN 14,24,34,44
</p>

![Topologia de la red del backbone](imagenesManual/3.png)
<br><br>

---


<br><br>

### Detalle de los comandos utilizados <br><br>

**SW1:**
![Topologia de la red del backbone](imagenesManual/4.png)
<p style="text-align: justify;">
Se debe de configurar el SW1 como el servidor
</p>

![Topologia de la red del backbone](imagenesManual/5.png)

**Switchs:**
![Topologia de la red del backbone](imagenesManual/6.png)
<p style="text-align: justify;">
Los Switchs restantes seran manejados como clientes excepto el SW9 que sera manejado como Transparent
</p>

![Topologia de la red del backbone](imagenesManual/7.png)

**Topologia switchs:**
<p style="text-align: justify;">
Cada switch de la topologia debe de cambiar su configuración de acceso
</p>

![Topologia de la red del backbone](imagenesManual/8.png)

<p style="text-align: justify;">
Comandos para la configuración de accesos
</p>

![Topologia de la red del backbone](imagenesManual/9.png)

**Modo truncal:**
<p style="text-align: justify;">
Comandos para el modo truncal/individual de los servidores
</p>

![Topologia de la red del backbone](imagenesManual/10.png)

**Truncate y spinning-tree:**
<p style="text-align: justify;">
Configuración truncate y spinning-tree backbone pentagono
</p>

![Topologia de la red del backbone](imagenesManual/11.png)


**Truncate y spinning-tree:**
<p style="text-align: justify;">
Configuración truncate y spinning-tree centro administrativo
</p>

![Topologia de la red del backbone](imagenesManual/12.png)

**Truncate y spinning-tree Workstation:**
<p style="text-align: justify;">
Configuración truncate y spinning-tree Workstation switch capa 3
</p>

![Topologia de la red del backbone](imagenesManual/13.png)

**PVST+RAPID/PVST:**
<p style="text-align: justify;">
Comandos para la configuracion PVST+RAPID/PVST
</p>

![Topologia de la red del backbone](imagenesManual/14.png)

___


### Ping entre Host <br><br>

**Primer ping:**
<p style="text-align: justify;">
Ping entre la computadora IT_2 del centro administrativo a la computadora IT_1 del area de trabajo.
</p>

![Topologia de la red del backbone](imagenesManual/15.png)

**Segundo ping:**
<p style="text-align: justify;">
Ping entre la computadora CONTABILIDAD_2 a la computadora S_CONTABILIDAD de backbone.
</p>

![Topologia de la red del backbone](imagenesManual/16.png)

___

### Repositorios: <br><br>
[Link del Repositorio de GitHub de Luis Cutzal](https://github.com/LuisCutzal/redes1_201700841/tree/main/proyecto1)

[Link del Repositorio de GitHub de Jaime Armira](https://github.com/alexcham23/redes1_201602983.git)

___