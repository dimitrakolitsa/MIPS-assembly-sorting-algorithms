qsort:                      # qsort entry point
        slt  $t1,$a0,$a1    #if a0<a1 -> t1=1, else t1=0
        beq  $t1,$zero,END  #if t1=0 goto END

    IF:
        addi $sp, $sp, -12  #push stack -> make room for 3 words
        sw   $ra, 8($sp)    #store ra in stack
        sw   $a1, 4($sp)
        sw   $a0, 0($sp)    #store values of a0 and a1 (f,l) in stack
        jal  partition      #call partition
        lw   $ra, 8($sp)    #retrieve ra from stack
        lw   $a1, 4($sp)
        lw   $a0, 0($sp)    #retrieve values of a0 and a1 (f,l) from stack
        addi $sp, $sp, 12   #pop stack

        move $t2, $v0       #t2=v0=i
        addi $sp, $sp, -16  #push stack -> make room for 4 words
        sw   $t2, 12($sp)   #store value of t2 in stack
        sw   $ra, 8($sp)    #store ra in stack
        sw   $a1, 4($sp)
        sw   $a0, 0($sp)    #store values of a0 and a1 (f,l) in stack
        addi $t2,$t2,-1     #t2=t2-1=p-1
        move $a1,$t2        #a1=t2=>l=p-1
        jal  qsort          #call qsort
        lw   $t2,12($sp)    
        lw   $ra, 8($sp)
        lw   $a1, 4($sp)
        lw   $a0, 0($sp)   #retrieve values and ra from stack
        addi $sp, $sp, 16  #pop stack
        addi $sp, $sp, -16 #push stack
        sw   $t2,12($sp)
        sw   $ra, 8($sp)
        sw   $a1, 4($sp)
        sw   $a0, 0($sp)
        addi $t2,$t2,1     #t2=t2+1
        move $a0,$t2       #a0=t2+1=>f=p+1
        jal qsort          #call qsort
        lw   $t2,12($sp)
        lw   $ra, 8($sp)
        lw   $a1, 4($sp)
        lw   $a0, 0($sp)   #retrieve values and ra from stack
        addi $sp, $sp, 16  #pop stack


    END:                       

        jr      $ra             # return to caller