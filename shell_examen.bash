#!/bin/bash
#Autor: Celia Alonso Reguero
#Licencia: CC BY-SA 3.0
#Programa que permitirá a un profesor ver, modificar o eliminar
#datos de sus alumnos, calcular la media de cada alumno y calcular
#la media de la clase.

#Función: Dar de alta a un alumno
#Esta función lo que hará es añadir al alumno al fichero notas
alta_alumno () {
	echo -e "\e[93mIntroduce el nombre del alumno \e[97m"
	read nombre;
	echo -e "\e[93mIntroduce los apellidos del alumno \e[97m"
	read apellidos;
	echo -e "\e[93mIntroduce la clase a la que pertenece dicho alumno \e[97m"
	read clase
	echo -e "\e[93mIntroduce la nota de la primera evaluación del alumno \e[97m"
	read eval1
	echo -e "\e[93mIntroduce la nota de la segunda evaluación del alumno \e[97m"
	read eval2
	echo -e "\e[93mIntroduce la nota de la tercera evaluación del alumno \e[97m"
	read eval3
	echo -e "$nombre:$apellidos:$clase:$eval1:$eval2:$eval3">>/home/alumno/notas
}

#Función: Dar de baja a un alumno
#Esta función lo que hará es eliminar al alumno del fichero notas
baja_alumno () {
	echo -e "\e[93mIntroduce el nombre del alumno \e[97m"
	read nombre;
	echo -e "\e[93mIntroduce los apellidos del alumno \e[97m"
	read apellidos;
	echo -e "\e[93mIntroduce la clase a la que pertenece dicho alumno \e[97m"
	read clase
	local buscar=$nombre:$apellidos:$clase
	local linea=`grep $buscar* -n /home/alumno/notas | cut -d: -f1`
	sed "$linea d" /home/alumno/notas > /home/alumno/temporal
	mv /home/alumno/temporal /home/alumno/notas
}

#Función: Modificar la nota de un alumno
#Esta función lo que hará es modificar la nota de un alumno que se encuentre en el fichero notas
modificar_nota_alumno () {
	echo -e "\e[93mIntroduce el nombre del alumno \e[97m"
	read nombre;
	echo -e "\e[93mIntroduce los apellidos del alumno \e[97m"
	read apellidos;
	echo -e "\e[93mIntroduce la clase a la que pertenece dicho alumno \e[97m"
	read clase
	local buscar=$nombre:$apellidos:$clase
	local linea=`grep $buscar* /home/alumno/notas`
	local evaluacion
	while test "$evaluacion" != "1" && test "$evaluacion" != "2" && test "$evaluacion" != "3"; do
		echo -e "\e[93m¿De qué evaluación desea modificar la nota?"
		echo [1] Primera evaluación
		echo [2] Segunda evaluación
		echo -e "[3] Tercera evaluación \e[97m"
		read evaluacion
		case $evaluacion in
			1 ) eval1=`grep $buscar* /home/alumno/notas | cut -d: -f4`
			eval2=`grep $buscar* /home/alumno/notas | cut -d: -f5`
			eval3=`grep $buscar* /home/alumno/notas | cut -d: -f6`
			echo La nota actual de $nombre $apellidos es $eval1
			echo -e "\e[93m¿Cuál es la nueva nota del alumno? \e[97m"
			read eval1
			buscar=$buscar:$eval1:$eval2:$eval3
			sed "s/$linea/$buscar/" /home/alumno/notas > /home/alumno/temporal
			mv /home/alumno/temporal /home/alumno/notas
			echo -e "\e[93mSe ha modicado la nota de la primera evaluación del alumno $nombre $apellidos correctamente \e[97m";;
			2 ) eval1=`grep $buscar* /home/alumno/notas | cut -d: -f4`
			eval2=`grep $buscar* /home/alumno/notas | cut -d: -f5`
			eval3=`grep $buscar* /home/alumno/notas | cut -d: -f6`
			echo La nota actual de $nombre $apellidos es $eval2
			echo -e "\e[93m¿Cuál es la nueva nota del alumno? \e[97m"
			read eval2
			buscar=$buscar:$eval1:$eval2:$eval3
			sed "s/$linea/$buscar/" /home/alumno/notas > /home/alumno/temporal
			mv /home/alumno/temporal /home/alumno/notas
			echo -e "\e[93mSe ha modicado la nota de la segunda evaluación del alumno $nombre $apellidos correctamente \e[97m";;
			3 ) eval1=`grep $buscar* /home/alumno/notas | cut -d: -f4`
			eval2=`grep $buscar* /home/alumno/notas | cut -d: -f5`
			eval3=`grep $buscar* /home/alumno/notas | cut -d: -f6`
			echo La nota actual de $nombre $apellidos es $eval3
			echo -e "\e[93m¿Cuál es la nueva nota del alumno? \e[97m"
			read eval3
			buscar=$buscar:$eval1:$eval2:$eval3
			sed "s/$linea/$buscar/" /home/alumno/notas > /home/alumno/temporal
			mv /home/alumno/temporal /home/alumno/notas
			echo -e "\e[93mSe ha modicado la nota de la tercera evaluación del alumno $nombre $apellidos correctamente \e[97m";;
			*)evaluacion="0"
			echo -e "\e[31m\e[1mLa opción elegida no es correcta \e[97m \e[21m"
		esac
	done
}

#Función: Consultar notas de un alumno
#Esta función lo que hará es consultar la nota de un alumno que se encuentre en el fichero notas
consultar_notas_alumno () {
	echo -e "\e[93mIntroduce el nombre del alumno \e[97m"
	read nombre;
	echo -e "\e[93mIntroduce los apellidos del alumno \e[97m"
	read apellidos;
	echo -e "\e[93mIntroduce la clase a la que pertenece dicho alumno \e[97m"
	read clase
	local evaluacion
	local buscar=$nombre:$apellidos:$clase
	while test "$evaluacion" != "1" && test "$evaluacion" != "2" && test "$evaluacion" != "3"; do
		echo -e "\e[93m¿De qué evaluación desea ver la nota del alumno $nombre $apellidos? \e[97m"
		echo [1] Primera evaluación
		echo [2] Segunda evaluación
		echo [3] Tercera evaluación
		read evaluacion
		case $evaluacion in
			1 ) eval1=`grep $buscar* /home/alumno/notas | cut -d: -f4`
			echo "La nota de la primera evaluación de $nombre $apellidos es $eval1";;
			2 ) eval2=`grep $buscar* /home/alumno/notas | cut -d: -f5`
			echo "La nota de la segunda evaluación de $nombre $apellidos es $eval2";;
			3 ) eval3=`grep $buscar* /home/alumno/notas | cut -d: -f6`
			echo "La nota de la tercera evaluación de $nombre $apellidos es $eval3";;
			*)evaluacion="0"
			echo "\e[31m\e[1mLa opción elegida no es correcta \e[97m\e[21m";;
		esac
	done
}

#Función: Calcular la nota media de un alumno
#Esta función lo que hará es calcular la nota media de un alumno que se encuentre en el fichero notas
nota_media_alumno () {
	echo -e "\e[93mIntroduce el nombre del alumno \e[97m"
	read nombre;
	echo -e "\e[93mIntroduce los apellidos del alumno \e[97m"
	read apellidos
	echo -e "\e[93mIntroduce la clase a la que pertenece dicho alumno \e[97m"
	read clase
	local alumno=`grep $nombre:$apellidos:$clase* /home/alumno/notas`
	eval1=`echo -e $alumno | cut -d: -f4`
	eval2=`echo -e $alumno | cut -d: -f5`
	eval3=`echo -e $alumno | cut -d: -f6`
	total=$(($eval1+$eval2+$eval3))
	total=$(($total/3))
	echo "La nota media del alumno $nombre $apellidos es $total"
}

#Función: Calcular la media de las notas de toda la clase
#Esta función lo que hará es calcular la media de las notas de los alumnos de una misma clase 
promedio_media_clase () {
	local lineas=`wc -l /home/alumno/notas | cut -d" " -f1`
	local total=0
	local contador=0
	for (( i=1; ${i}<=$lineas; i=$((i+1)) )) 
	do
		eval1=`nl notas | tr -s  -t "\t" ":" | tr -s -t " " ":" | grep :$i: | cut -d: -f6`
		eval2=`nl notas | tr -s  -t "\t" ":" | tr -s -t " " ":" | grep :$i: | cut -d: -f7`
		eval3=`nl notas | tr -s  -t "\t" ":" | tr -s -t " " ":" | grep :$i: | cut -d: -f8`
		total=$(($total+$eval1+$eval2+$eval3))
		contador=$(($contador+3))
	done
	total=$(($total/$contador))
	echo El promedio de la clase es $total
}

### MENU PRINCIPAL ###
indice=0
nombre="";
apellido="";
clase=0;
eval1=0;
eval2=0;
eval3=0;
while test "$indice" != "S" && test "$indice" != "s";do
	echo -e "\e[93m 
---------------- 
MENU DE OPCIONES 
---------------- 
[A]ltas 
[B]ajas 
[M]odificación notas 
[C]onsultas notas 
[N]ota media alumno 
[P]romedio (media) de la clase 
[S]alir 
Elija opción (A, B, M, C, N, P, S)\e[97m"
	read indice
		case $indice in 
			A|a ) alta_alumno;;
			B|b ) baja_alumno;;
			M|m ) modificar_nota_alumno;;
			C|c ) consultar_notas_alumno;;
			N|n ) nota_media_alumno;;
			P|p ) promedio_media_clase;;
			S|s );;
			*)indice="0"
			echo -e "\e[31m\e[1mLa opción elegida no es correcta. Seleccione una opción del menú. Gracias \e[97m\e[21m";;
		esac
done
