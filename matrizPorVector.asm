# Programa que imprime por pantalla el producto de una matriz cuadrada por un vector columna
	.data
matriz:	.word 	1, 0, 0		# Inicializamos la matriz
	 	0, 1, 0, 
		0, 0, 1 
vector:	.word	3, 2, 3		# Inicializamos el vector 
result: .space	12		# Reservamos espacio para el vector resultado
dim:	.word 	3		# Indicamos la dimensión de la matriz cuadrada
space:	.byte	' '		# Caracter espacio
sl:	.byte	'\n'		# Caracter salto de línea
	
			
	.text
	la	$t0, dim
	lw 	$s1, 0($t0)		# Dimensión -> s1
	addi 	$s1, $s1, -1		# Tope dimensión -> s1
	la 	$t0, matriz 		# Dirección de memoria matriz -> t0
	la	$t1, vector		# Dirección de memoria vector -> t1
	la	$t2, result		# Dirección de memoria resultado -> t2
	move 	$t3, $zero		# i = 0
	move 	$t4, $zero		# j = 0
	move	$t5, $zero		# resultado = 0
	
repeat:	lw 	$a0, 0($t0) 		# Cargamos el valor del elemento ij de la matriz
	lw	$a1, 0($t1)		# Cargamos el valor del elemento j del vector
	
	mult	$a0, $a1		# Multiplicamos el ij de la matriz por el j del vector
	mflo	$t6
	add	$t5, $t5, $t6		# Añadimos ese producto al resultado
	
	addi 	$t4, $t4, 1		# j = j + 1
	addi 	$t0, $t0, 4		# Apuntamos al siguiente elemento de la matriz
	addi	$t1, $t1, 4		# Apuntamos al siguiente elemento del vector
endj:	ble 	$t4, $s1, repeat	# Si j distinto de tope, repitir
	move 	$t4, $zero		# j = 0
	addi 	$t3, $t3, 1		# i = i + 1
	
	# Imprimimos el valor del producto
	move	$a0, $t5		# Preparamos el resultado para imprimir
	addi	$v0, $zero, 1
	syscall
	la 	$t9, space		# Print space
	lb	$a0, 0($t9)
	addi	$v0, $zero, 11
	syscall
	
	sw	$t5, 0($t2)		# Guardamos el resultado en memoria
	addi	$t2, $t2, 4		# Actualizamos la dirección de memoria del result
	
	move	$t5, $zero		# resultado = 0
	la	$t1, vector		# Reseteamos la dirección del elemento del vector
	
endi:	ble 	$t3, $s1, repeat	# Si i distinto de tope volvemos al bucle de j
	
	li 	$v0,10			# Finalizar ejecución
	syscall