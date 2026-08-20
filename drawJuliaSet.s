        .data
cX:    .word  0
cY:    .word  0
temp:  .word  0
width: .word  0
height:    .word  0
maxIter:   .word  255
zx:    .word  0
zy:    .word  0
tmp:    .word  0
i:    .word  0
x:    .word  0
y:    .word  0
frame:    .word  0
color:    .short  0
          .text
          .globl  drawJuilaSet

drawJuilaSet:  stmfd  sp!, {r4-r11,lr}
         ldr  r4, =cX
         str  r0, [r4]
         ldr  r4, =cY
         str  r1, [r4]
         ldr  r4, =width
         str  r2, [r4]
         ldr  r4, =height
         mov  r5, sp

         add  r0, sp, #36
         orr  sp, lr, r1
         mov  sp, r5

         str  r3, [r4]
         ldr  r0, [r0]
         ldr  r4, =frame
         str  r0, [r4]

         mov  r6, #0   @ count loop x
         b  loop

loop:  ldr  r5, = width
       ldr  r5, [r5]
       cmp  r6, r5
       bge  end


       mov  r7, #0   @ count loop y
       b  loop2

loop2:  ldr  r9, = height
        ldr  r9, [r9]
        cmp  r7, r9
        addge r6, r6, #1 @Conditional execution
        bge  loop

        ldr  r9,  =width
        ldr  r9,  [r9]
        mov  r9,  r9,  asr #1 @Operand2

        cmp  r10, r10
        ldreq  r10,  =height @Conditional execution
        ldr  r10,  [r10]
        mov  r10,  r10,  asr #1 @Operand2

        sub  r0, r6, r9

        ldr  r1, .constant1
        mul  r0, r0, r1

        ldr  r2, .constant2
        cmp  r1, r2
        movne  r1, r9 @Conditional execution
        bl __aeabi_idiv
        mov  r9, r0
        ldr  r1, =zx
        str  r9, [r1]

        sub  r9, r7, r10
        ldr  r1, .constant2
        mul  r9, r9, r1

        mov  r1, r10
        mov  r0, r9
        bl __aeabi_idiv
        mov  r9, r0


        ldr  r1, =zy
        str  r9, [r1]

        mov r8, #255
        b   loop3

loop3:  ldr  r0, =zx
        ldr  r0, [r0]
        ldr  r1, =zy
        ldr  r1, [r1]
        mul  r3, r0, r0
        mul  r4, r1, r1
        add  r1, r4, r3


        ldr  r0,.constant3
        cmp  r1, r0
        bge  store

        ldr  r1,.constant4
        cmp  r8, r1
        ble  store

        sub  ip, r3, r4

        mov  r1, #1000
        mov  r0, ip
        bl __aeabi_idiv
        mov  ip, r0

        ldr  r0,  =cX
        ldr  r0, [r0]
        add  ip, ip, r0
        ldr  r0, =tmp
        str  ip, [r0]

        ldr  r0, =zx
        ldr  r0, [r0]
        ldr  r1, =zy
        ldr  r1, [r1]
        mul  r3, r1, r0
        mov  r3, r3, lsl #1 @Operand2
        ldr  r0, .constant2

        mov  r1, r0
        mov  r0, r3
        bl __aeabi_idiv
        mov  r3, r0

        ldr  r0, =cY
        ldr  r0, [r0]
        add  r3, r3, r0
        ldr  r0, =zy
        str  r3, [r0]

        ldr  r0, =zx
        ldr  ip, =tmp
        ldr  ip, [ip]
        str  ip, [r0]

        sub r8, r8, #1

        b loop3

store:  mov r1, r8

        AND r2, r1, #0xFF
        LSL r2, r2, #8

        AND r3, r1, #0xFF

        ORR r2, r2,r3

        ldr r0, =color
        strh r2, [r0]

        ldr r0, .constant5

        bic r2, r0, r2

        ldr r4, = color
        strh r2,[r4]

        ldr r9, =width
        ldr r9, [r9]

        MLA r9, r7, r9, r6
        LSL r9, r9, #1

        ldr r10, =frame
        ldr r10, [r10]

        strh r2,[r10, r9]

        add r7, r7, #1 @Operand2
        b loop2



end:    ldmfd sp!,{r4-r11,lr}
        mov  pc, lr

.constant1: .word 1500
.constant2: .word 1000
.constant3: .word 4000000
.constant4: .word 0
.constant5: .word 0xffff
