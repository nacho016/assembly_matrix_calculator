# Programa que calcula la traza de una matriz
	.data
matriz:	.word 	1, 2, 3		# Inicializamos la matriz
	 	4, 5, 6, 
		7, 8, 9 
traza: .space	4		# Reservamos espacio para la traza
dim:	.word 	3		# Indicamos la dimensión de la matriz cuadrada
space:	.byte	' '		# Caracter espacio
sl:	.byte	'\n'		# Caracter salto de línea
			
	.text
	la	$t0, dim
	lw 	$s1, 0($t0)		# Dimensión -> s1
	addi 	$s1, $s1, -1		# Tope dimensión -> s1
	la 	$t0, matriz 		# Dirección de memoria matriz -> t0
	la	$t1, traza		# Dirección de memoria traza -> t1
	move 	$t2, $zero		# i = 0
	move 	$t3, $zero		# j = 0
	move	$t4, $zero		# traza = 0

repeat:	lw 	$a0, 0($t0) 		# Cargamos el valor del elemento ij de la matriz
if: 	bne	$t2, $t3, ifnot		# Si i y j no son iguales no actualizamos la traza
	add	$t4, $t4, $a0		# Actualizamos el valor de la traza
ifnot: 	addi 	$t3, $t3, 1		# j = j + 1
	addi 	$t0, $t0, 4		# Apuntamos al siguiente elemento de la matriz
endj:	ble 	$t3, $s1, repeat	# Si j distinto de tope, repitir
	move 	$t3, $zero		# j = 0
	addi 	$t2, $t2, 1		# i = i + 1
endi:	ble 	$t2, $s1, repeat	# Si i distinto de tope volvemos al bucle de j

	sw	$t4, 0($t1)		# Guardamos la traza en memoria
	# Imprimimos la traza
	move	$a0, $t4
	addi	$v0, $zero, 1
	syscall
	
# Implementación alternativa
	la	$t0, dim
	lw 	$s1, 0($t0)		# Dimensión -> s1
	addi	$t4, $s1, 1		# Guardamos 1 + dim
	addi 	$s1, $s1, -1		# Tope dimensión -> s1
	la 	$t0, matriz 		# Dirección de memoria matriz -> t0
	la	$t1, traza		# Dirección de memoria traza -> t1
	move 	$t2, $zero		# contador = 0
	move	$t3, $zero		# traza = 0
	addi	$t5, $zero, 4
	mult	$t4, $t5		# Calculamos 4(1 + dim)
	mflo	$t4			# Guardamos el paso que hay entre elementos de la traza
	j	for	
inc:	addi	$t2, $t2, 1
for:	lw	$t5, 0($t0)		# Cargamos elemento de la matriz
	add	$t3, $t3, $t5		# Actualizamos la traza
	add	$t0, $t0, $t4		# Actualizamos la dirección de memoria al siguiente elemento de la diagonal
	blt	$t2, $s1, inc
	
	# Imprimimos la traza
	move	$a0, $t3
	addi	$v0, $zero, 1
	syscall
	
	li 	$v0, 10			# Finalizar ejecución
	syscall