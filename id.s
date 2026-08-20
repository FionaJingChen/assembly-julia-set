   .data
sum:  .asciz  "22"
      .globl sum
      .align 2
id1:  .word  0
      .globl id1
id2:  .word  0
      .globl id2
id3:  .word  0
      .globl id3
pCommand : .string "p"
.align 2
command:  .string  "p"
.align 2
formatInt:  .asciz  "%d"
.align 2
formatString:  .asciz "%s"
.align 2
formatChar:  .asciz "%c"
.align 2
nextLine: .asciz "\n"
.align 2
segment : .asciz "** Please Enter Member %d ID:**\n"
.align 2
title1: .asciz "*****Input ID*****\n"
.align 2
title2: .asciz "**Please Enter Command**\n"
.align 2
title3: .asciz "*****Print Team Member ID and ID summation*****\n"
.align 2
titleEnd: .asciz "*****END Print*****\n"
.align 2
idPrint:  .asciz  "%d\n"
.align 2
summation : .asciz  "ID summation = %d\n\n"
.align 2

personNum:  .word 1
            .text




      .text
      .globl id





loop:  ldr  r0, =title2
       bl  printf
       ldr r0, =formatString
       ldr r1, =command
       bl scanf
       ldr  r0, =pCommand
       ldr  r0, [r0]
       ldr  r1, =command
       ldr  r1, [r1]
       cmp  r0, r1
       beq after
       bne loop

id:    stmfd  sp!, {lr}
       ldr  r0, =title1
       bl  printf

       ldr  r0, =segment
       mov r7, lr
       adds lr, pc, r0
       mov  lr, r7

       ldr  r0, =segment
       ldr  r4, =personNum
       ldr  r4, [r4]
       mov  r1, r4
       bl  printf

       ldr  r0, =formatInt
       ldr  r1, =id1
       bl  scanf

       ldr  r0, =segment
       add  r1, r4, #1
       bl  printf

       ldr  r0, =formatInt
       ldr  r1, =id2
       bl  scanf

       ldr  r0, =segment
       mov  r1, r4
       add  r1, #2
       bl  printf

       ldr  r0, =formatInt
       ldr  r1, =id3
       bl  scanf

       bl  loop

after: ldr  r0, =title3
       bl  printf
       ldr  r0, =idPrint
       ldr  r5, =id1
       ldr  r5, [r5]
       mov  r1,r5
       bl  printf

       ldr  r0, =idPrint
       ldr  r6, =id2
       ldr  r6, [r6]
       mov  r1,r6
       bl  printf


       ldr  r0, =idPrint
       ldr  r7, =id3
       ldr  r7, [r7]
       mov  r1,r7
       bl  printf

       ldr  r0, =nextLine
       bl  printf



       ldr  r0, =summation
       ADD  r8, r5, r6
       ADD  r8, r8, r7
       ldr  r4, =sum
       str  r8, [r4]
       mov r1, r8
       bl printf
       ldr  r0, =titleEnd
       bl printf
       add  r4, r5, r6, rrx



       ldr   r0, = .data
       ldmfd  sp!, {lr}
       mov  pc, lr
