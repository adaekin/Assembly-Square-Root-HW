.text
.globl main

main:
    addiu $t2, $zero, 25

    jal func_newton

    addu $a0, $v0, $zero
    addiu $v0, $zero, 1     # Ekrana integer yazdırma syscall'u
    syscall

    addiu $v0, $zero, 10    # Exit syscall'u
    
    syscall


func_newton:

slt $t1, $t2, $zero # t2 = num olsun
bne $t1, $zero, func_returnzero # IF (NUM < 0) RETURN 0;

# if (num == 0 || num == 1) return num;
beq $t2, $zero, func_returnitself
addiu $t8, $zero, 1
beq $t2, $t8, func_returnitself

add $t3, $zero, $t2 # x0 = num;
div $t2, $t3 # num/x0
mflo $t4 

add $t4, $t4, $t3 # x0 + num/x0
srl $t4, $t4, 1 # x1 = (x0 + (num / x0)) / 2;

# x1 = $t4
# x0 = $t3
#while()
while_loop:
slt $t5, $t4, $t3 # x1 < x0
beq $t5, $zero, loop_end

add $t3, $zero, $t4 # x0 = x1;

div $t2, $t3 # num/x0
mflo $t6
add $t4, $t3, $t6
srl $t4, $t4, 1
j while_loop

loop_end:
add $v0, $t3, $zero #return x0
jr $ra

func_returnzero:
add $v0, $zero, $zero
jr $ra

func_returnitself: # return num(t2)
add $v0, $t2, $zero
jr $ra
