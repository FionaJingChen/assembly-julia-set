            .data
.align 4
Tem:        .asciz "%s"
.align 4
Str1:       .asciz "*****Print Name*****\n"
.align 4
Team:       .asciz "Team 07\n"
.align 4
TeamMate1:  .asciz "Pei ru,Zhuang\n"
.align 4
TeamMate2:  .asciz "Pei Chi, hu\n"
.align 4
TeamMate3:  .asciz "Yi Jing, Chen\n"
.align 4
Str2:       .asciz "*****End Print*****\n"
.align 4
            .text
.global Team
.global TeamMate1
.global TeamMate2
.global TeamMate3

            .global name


name:       stmfd   sp!, {lr} @ push return address onto stack
            ldreq    r0, =Str1
            bl     printf

            ldr    r1, =Team @ load pointer to format string
            moveq    r0, r1 @ store Team in r1
            ldr    r1,[r1]
            bl     printf

            ldr    r2, =TeamMate1 @ load pointer to format string
            mov    r0, r2 @ store Team in r1
            ldrh   r2, [r2]
            bl     printf

            ldr    r3, =TeamMate2 @ load pointer to format string
            mov    r0, r3 @ store Team in r1
            bl     printf

            ldr    r4, =TeamMate3 @ load pointer to format string
            mov    r0, r4 @ store Team in r1
            adcs   r5,r3,r2, lsl #2
            bl     printf

            ldr    r0, =Str2 @ load pointer to format string
            bl     printf

            mov    r0, #0 @ move return code into r0
            mov    r1, #0 @ move return code into r1
            mov    r2, #0 @ move return code into r2
            mov    r3, #0 @ move return code into r3
            mov    r4, #0 @ move return code into r4

            ldr    r0, =.data
            ldmfd  sp!, {lr} @ pop return address from stack
            mov    pc, lr @ return from main


