swap: 
	sll $t1, $a0, 2 #find address of i and assign it to $t1
	add $t1, $s0, $t1 #put address of v[i] in $t1
	sll $t2, $a1, 2 #find address of j and assign it to $t1
	add $t2, $s0, $t2 #put address of v[j] in $t2
	
	lw $t0, 0($t1) # $t0=temp, $t0=$t1
	lw $t3, 0($t2) # $t3=$t2
	sw $t3, 0($t1) # v[i]=v[j] 
	sw $t0, 0($t2) # v[j]=$t0, v[j]=v[i]

	jr $ra