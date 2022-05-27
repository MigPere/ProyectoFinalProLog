%declaracion las librerias la cual utilizaresmos

:-use_module(library(pce)).
:-use_module(library(pce_style_item)).

% metodo principal para iniciar la interfaz grafica, declaracion de
% botones, labels, y la pocicion en pantalla.
inicio:-
	new(Menu, dialog('PROYECTO FINAL "EN EQUIPO" ', size(1000,800))),
	new(L,label(nombre,'SISTEMA EXPERTO DIAGNOSTICO DE TU PC')),
	new(A,label(nombre,'Hecho por Enrique,Hilmer,Maria,Miguel')),
	new(@texto,label(nombre,'** Responde un breve cuestionario para resolver tu falla **')),
	new(@respl,label(nombre,'')),
	new(Salir,button('SALIR',and(message(Menu, destroy),message(Menu,free)))),
	new(@boton,button('Empezar',message(@prolog,botones))),

%ajuste de letras para centrar y no estar desajustado.
	send(Menu,append(L)),new(@btncarrera,button('Diagnostico?')),
	send(Menu,display,L,point(40,30)),
	send(Menu,display,A,point(80,360)),
	send(Menu,display,@boton,point(100,150)),
	send(Menu,display,@texto,point(20,100)),
	send(Menu,display,Salir,point(20,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open_centered).

%solucion a las fallas de acuerdo a las reglas de
% diagnostico para la solucion de una pc

fallas('mensaje de error:
Tiene problemas de RAM requiere un aumento
de RAM o limpieza para no presentar fallas.'):-ram,!.

fallas('se detiene de manera inseperada:
Tiene problemas de procesador es necesario
la optimizacion de programas de inicio.
limpieza de sotfware(virus,pop ups, etc.)

paros de sistema:
optimizacion de sistema operacion y
disco duro. limpieza de sofware.

presenta pantallas azul, amarillo, o verde:
revision de conectores de monitor.'):-procesador,!.

fallas('problemas en el disco duro se requiere cambio.
Limpieza de software, virus,etc.
reparacion o cambio de disco duro recuperacion
de los sectores dañados.'):-discoDuro,!.

fallas('problemas en el cargador o en la batería.
requiere revicion de puertos de entrada del cargador
ver la vida de la bateria'):-cargadorBateria,!.

fallas('requiere una limpieza de archivos, formateo,
	mantemimiento, borrar cache'):-espacio,!.

fallas('Mucho ruido que provienen de la computadora
es generalmente una señal de un mal funcionamiento
del hardware o de un ventilador ruidoso.
Los discos duros suelen hacer ruido justo antes
de fallar, por lo que es conveniente hacer una copia
de seguridad de la información por si acaso,
y cambiar los ventiladores son muy fáciles
de reemplazar.'):-ruido,!.

fallas('Para mejorar el rendimiento del navegador de
Internet, es necesario borrar las cookies y los archivos
temporales de Internet con frecuencia.

En la barra de búsqueda de Windows (si tienes este sistema operático),
escribe (temp) y pulse Intro para abrir la carpeta de archivos temporales.
También el internet se puede tornar lento o puede que no responda,
por una combinación de problemas de software y hardware.
'):-internetlento,!.

fallas('La mejor solución es utilizar algún tipo de aspirador o
difusor que expulse todo el polvo que sobre. No dudes en limpiar
los ventiladores de tu dispositivo cada poco tiempo para evitar
problemas de sobrecalentamiento con tu ordenador portátil.
Para evitar que el ordenador se queme, apágalo y déjelo descansar
si se calienta. Además, puedes comprobar el ventilador para que estés
seguro de que funciona correctamente.'):-sobrecalentamiento,!.

fallas(':( sin resultados! lo sentimos aun trabajaremos
mas a profundidad los detalles de los problemas de tu pc.

NOTA: ¡Tus respuestas no fueron muy concretas! ').





% poenemos las  preguntas para resolver las fallas con su respectivo
% identificador de falla
ram:- ram_ram,
	pregunta('Mi computadora manda mensajes de error?'),
	pregunta('Esta muy lento?').

procesador:- procesador_procesador,
	pregunta('Sede tiene de manera inesperada?'),
	pregunta('paros de sistemas inesperados?'),
	pregunta('presenta pantalla azul, amarillo o verde?').

% ponemos las preguntas las cual cada uno deberan ser correctas para dar
% paso ala solucion si una pregunta es no puede no corresponder a la
% solucion y debera responder otras preguntas para saber la solucion.
discoDuro:- disco_duro,
	pregunta('esta lento la maquina?'),
	pregunta('se reinicia constantemente?'),
	pregunta('presenta error al guardar?'),
	pregunta('abre los programas?').

cargadorBateria:- cargador_bateria,
	pregunta('carga mi computadora?'),
	pregunta('sirve el cargador?'),
	pregunta('se descarga muy rápido?').

espacio:- espacio_espacio,
	pregunta('Esta muy lento?'),
	pregunta('no puedes instalar aplicacion?'),
	pregunta('puedes guardar videos, musicas e imagen?').

ruido:-ruido_ruido,
	pregunta('Escuchas ruidos extraños en tu pc?').

internetlento:-internet_lento,
		pregunta('lento o saturado?').

sobrecalentamiento:-sobre_calentamiento,
	pregunta('se sobre calienta tu pc?').


%identificador de falla que dirige a las preguntas correspondientes

ram_ram:-pregunta('TIENE PROBLEMA DE ERROR?'),!.

procesador_procesador:-pregunta('SE DETIENE DE MANERA INESPERADA?'),!.

disco_duro:-pregunta('TIENE PROBLEMAS DE ERROR AL GUARDAR ALGUN ARCHIVO?'),!.

cargador_bateria:-pregunta('TIENES PROBLEMAS DE CARGA?'),!.

espacio_espacio:-pregunta('TIENES PROBLEMAS DE ESPACIO?'),!.

ruido_ruido:-pregunta('ESCUCHAS RUIDOS?'),!.

internet_lento:-pregunta('INTERNET INESTABLE?'),!.

sobre_calentamiento:-pregunta('SOBRE CALENTAMIENTO?'),!.

% proceso del diagnostico basado en preguntas de si y no, cuando el
% usuario dice si, se pasa a la siguiente pregunta del mismo ramo, si
% dice que no se pasa a la pregunta del siguiente ramo
% (ram,procesador,etc.)

:-dynamic si/1,no/1.
preguntar(Problema):- new(Di,dialog('Diagnostico de tu pc')),
     new(L2,label(texto,'Responde las siguientes preguntas')),
     new(La,label(prob,Problema)),
     new(B1,button(si,and(message(Di,return,si)))),
     new(B2,button(no,and(message(Di,return,no)))),
% sale una nueva ventaja encima de la ventana principal de el sistema
% expoerto
         send(Di,append(L2)),
	 send(Di,append(La)),
	 send(Di,append(B1)),
	 send(Di,append(B2)),

	 send(Di,default_button,si),
	 send(Di,open_centered),get(Di,confirm,Answer),
	 write(Answer),send(Di,destroy),
	 ((Answer==si)->assert(si(Problema));
	 assert(no(Problema)),fail).

% cada vez que se conteste una pregunta la pantalla se limpia para
% volver a preguntar

pregunta(S):-(si(S)->true; (no(S)->false; preguntar(S))).
limpiar :- retract(si(_)),fail.
limpiar :- retract(no(_)),fail.
limpiar.

% proceso de eleccion de acuerdo al diagnostico basado en las preguntas
% anteriores

botones :- lim,
	send(@boton,free),
	send(@btncarrera,free),
	fallas(Falla),
	send(@texto,selection('la solucion es ')),
	send(@respl,selection(Falla)),
	new(@boton,button('inicia procedimiento mecanico',message(@prolog,botones))),
        send(Menu,display,@boton,point(40,50)),
        send(Menu,display,@btncarrera,point(20,50)),
limpiar.
lim :- send(@respl, selection('')).










