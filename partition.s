# partition(int f, int l) : partitions elements in vector v[] 
#   between positions f and l, using as pivot the element v[l], such 
#   that 
#     i < p ==> v[i] <= v[p]
#     i > p ==> v[p] <  v[i]
#   The function returns the position p of the pivot.
# $a0 = f
# $a1 = l
# $s0 = v
# $v0 = p
partition:
	addi	$sp, $sp, -16	#make room for 4 words in stack -> push stack
	sw	$s4, 12($sp)
	sw	$s3, 8($sp)
	sw	$s2, 4($sp)
	sw	$s1, 0($sp) #store s values in stack
	
	add	$s1, $a1, $zero #s1=a1=l
	sll	$t3, $a1, 2	#t3 has address of l
	add	$t0, $s0, $t3 #t0 has address of v[l]
	lw	$s3, 0($t0)	#s3=pivot=v[l]
	add	$s4, $a0, $zero	#i=f

	add	$s2, $a0, $zero #j=f -> for's first condition
loop:	
    bge	$s2, $s1, exit1 #if s2>=s1 (j>=l) goto exit1
	sll	$t4, $s2, 2 #t4 has address of j
	add	$t7, $s0, $t4 #t7 has address of v[j]
	lw	$t6, 0($t7)	#t6=v[j]
	slt	$t5, $t6, $s3 	#if v[j]<pivot -> t5=1, else t5=0
	bne	$t5, $zero, exit2 #if t5!=0 (if t5=1) goto L1
	addi	$s2, $s2, 1 #j++ -> for's incrementation step
	j loop #goto loop
exit2:	
    add	$a0, $s4, $zero #a0=v0=i
	add	$a1, $s2, $zero #a1=s2=j
	addi	$sp, $sp, -4 #push stack (make room for 1 word)
	sw	$ra, 0($sp) #store ra in stack
	jal swap #call swap
	lw 	$ra, 0($sp) #retrieve ra from stack
	addi	$sp, $sp, 4 #pop (free) stack
	addi	$s4, $s4, 1 #i++
	addi	$s2, $s2, 1 #j++
	j loop #goto loop
exit1:	
    addi	$sp, $sp, -4 #push stack
	sw	$ra, 0($sp) #store ra in stack
	add	$a0, $s4, $zero #a0=v4=i
	add	$a1, $s1, $zero #a1=s1=l
	jal swap #call swap

	lw	$ra, 0($sp) #retrieve ra from stack
	addi	$sp, $sp, 4 #pop stack

	add	$v0, $s4, $zero #return i

	lw	$s1, 0($sp)
	lw	$s2, 4($sp)
	lw	$s3, 8($sp)
	lw	$s4, 12($sp) #retrieve values from stack
	addi	$sp, $sp, 16 #pop stack

        jr      $ra             # return to caller
