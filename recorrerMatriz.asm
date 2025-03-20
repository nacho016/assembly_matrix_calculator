# Programa que recorre una matriz
	.data
m1:	.word 	1, 0, 0		#initialise matrix row by row to 9 elements
	.word 	0, 1, 0
	.word 	0, 0, 1 
nc:	.word 	3		#number of columns
nr:	.word 	3		#number of rows
space:	.byte	' '
sl:	.byte	'\n'
	
			
	.text
	
	la 	$t0,m1 		#load address of first element m[0,0]
	lw 	$s1,nc		#load total number of columns
	addi 	$s1,$s1,-1	#upper bound = NC - 1
	lw 	$s2,nr		#load total number of rows
	addi 	$s2,$s2,-1	#upper bound = NR - 1
	
	move 	$t1,$zero	#counter t1 = 0 (used to access column elements)
	move 	$t2,$zero	#counter t2 = 0 (used to access row elements)
	
repeat:	lw 	$a0,0($t0) 	#load from memory to register a0 the value for element i, j of the matriz
	addi 	$t1,$t1,1	#increment j - column index
	addi 	$t0,$t0,4	#point to the next integer in the matrix (in some cases this should be replaced by the formula "(NC*i+j)*t_element")
	# Imprimimos el valor de la celda de la matriz
	addi	$v0, $zero, 1
	syscall
	# Print space
	la 	$t9, space
	lb	$a0, 0($t9)
	addi	$v0, $zero, 11
	syscall
endj:	ble 	$t1,$s1,repeat	#go to repeat if the maximum number of columns has not been reached
	move 	$t1,$zero	#reset column counter
	addi 	$t2,$t2,1	#increment i - row index
	# Salto de línea
	la 	$t9, sl
	lb	$a0, 0($t9)
	addi	$v0, $zero, 11
	syscall
endi:	ble 	$t2,$s2,repeat	#go to repeat if the maximum number of rows has not been reached
	
	li 	$v0,10		#finish the execution
	syscall