.text
.globl main

main:
    addiu $t2, $zero, 198

    jal func_bitwise

    addu $a0, $v0, $zero
    addiu $v0, $zero, 1     # Ekrana integer yazdırma syscall'u
    syscall

    addiu $v0, $zero, 10    # Exit syscall'u
    
    syscall



func_bitwise:

slt $t1, $t2, $zero # t2 = num olsun
bne $t1, $zero, func_returnzero # IF (NUM < 0) RETURN 0;

add $t1, $zero, $zero # res = 0

addiu $t0, $zero, 1
sll $t4, $t0, 30 # bit = 1 << 30;

# while( bit > num)
while1_loop:
slt $t5, $t2, $t4
beq $t5, $zero, while2_loop # bit > num

srl $t4, $t4, 2 # bit >>= 2;  bit = bit >> 2;
j while1_loop

# bit = $t4
# res = $t1
# num = $t2

# while (bit != 0)
while2_loop: 
beq $t4, $zero, loop2_end

# if(num >= res + bit) == if(!(num < res + bit))
addu $t6, $t1, $t4 # res + bit
slt $t5, $t2, $t6
bne $t5, $zero, else1

subu $t2, $t2, $t6 # num -= (res + bit);
srl $t1, $t1, 1 # res >> 1
addu $t1, $t1, $t4 # res = (res >> 1) + bit;

srl $t4, $t4, 2 # bit >>= 2;
j while2_loop

else1:
srl $t1, $t1, 1 
srl $t4, $t4, 2 # bit >>= 2;
j while2_loop

loop2_end:
add $v0, $t1, $zero
jr $ra

func_returnzero:
add $v0, $zero, $zero
jr $ra
