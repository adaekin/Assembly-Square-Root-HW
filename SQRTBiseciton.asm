.text
.globl main

main:
    addiu $t2, $zero, 25

    jal func_bisection

    addu $a0, $v0, $zero
    addiu $v0, $zero, 1     # Ekrana integer yazdırma syscall'u
    syscall

    addiu $v0, $zero, 10    # Exit syscall'u
    
    syscall

func_bisection:

slt $t1, $t2, $zero # t2 = num olsun
bne $t1, $zero, func_returnzero # IF (NUM < 0) RETURN 0;

beq $t2, $zero, func_returnitself
addiu $t8, $zero, 1
beq $t2, $t8, func_returnitself

add $t3, $zero, $zero # a = 0;
add $t4, $zero, $t2 # b = num;
add $t7, $zero, $zero # ans = 0;
j while_loop

while_loop:
slt $t1, $t4, $t3 # a > b
bne $t1, $zero, loop_end # while(!(a > b))

# c = a + (b-a) / 2;
add $t5, $zero, $zero # c = 0;

sub $t5, $t4, $t3 # b - a

srl $t5, $t5, 1 # (b-a)/2

add $t5, $t3, $t5 # c = a + (b-a) / 2;

# if(c <= num / c);
div $t2, $t5 # num/c
mflo $t6

slt $t1, $t6, $t5 # if (num/c < c)
bne $t1, $zero, if1_else
add $t7, $zero, $t5 # ans = c
addi $t3, $t5, 1 # a = c + 1
j while_loop

if1_else: # else{ b = c - 1;}
addiu $t4, $t5, -1
j while_loop

loop_end: # return ans
add $v0, $t7, $zero #return ans
jr $ra

func_returnzero: # return 0 nasıl yapılır ona bak
add $v0, $zero, $zero
jr $ra

func_returnitself: # return num(t2)
add $v0, $t2, $zero
jr $ra

