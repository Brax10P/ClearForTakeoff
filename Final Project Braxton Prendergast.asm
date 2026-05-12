;*************************************************************************
;Braxton Prendergast, Final Project, 4/28/2026 
;Description:
; This program is my final project. It is an ASCII animation of a rocket ship.
; Notes:
;   Before running, click on view, actual size, and then zoom out once
; 
; Register Usage:
; R0 I/O functions
;************************************************************************
        .ORIG x3000

        JSR CountDown
        JSR ignition
        JSR liftoff
        JSR fly
        JSR away
        JSR liftoff
        JSR fly
        JSR away

        HALT
        
    
MESSAGE .STRINGZ "T-Minus: "
DelayCount .FILL #30000
NEWLINE  .STRINGZ "\n"
CLEAR .STRINGZ "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
DTOA .FILL #48
SaveR0     .BLKW 1
SaveR1     .BLKW 1
SaveR2     .BLKW 1
SaveR3     .BLKW 1
SaveR7     .BLKW 1

;*************************************************************************
; This Subroutine in used for the countdown at the beginning
; Register Usage:

; R1 is used to convert decimal to ASCII
; R2 countdown number

;************************************************************************
CountDown:
        ;store registers
        ST R7, SaveR7
        ST R0, SaveR0
        ST R1, SaveR1
        ST R2, SaveR2

        ;zero out R2 and set it to 5 (our countdown number)
        AND R2, R2, #0
        ADD R2, R2, #5      ; R2 = countdown number

CountLoop:
        
        ;load and print "T-Minus:"
        LEA R0, MESSAGE
        PUTS

        ;convert decimal to ascii and display it
        LD R1, DTOA   ; R1 = #-48
        ADD R0, R2, R1  
        OUT

        LD R0, NEWLINE
        OUT

        ;delay
        JSR delay

        ;countdown -- and loop while R2 is > 0
        ADD R2, R2, #-1     
        BRzp CountLoop      

        ;load registers
        LD R2, SaveR2
        LD R1, SaveR1
        LD R0, SaveR0
        LD R7, SaveR7
        RET
        
;*************************************************************************
; This Subroutine in used for delay
; Register Usage:
; R3 used for the delay counter
;************************************************************************
delay:
            ;save registers 
            ST R3, SaveR3
            
            ;zero out R3, load delaycount (huge number) and keep subtracting one to give us a delay
            AND R3, R3, #0
            LD R3, DelayCount
loop        ADD R3, R3, #-1
            BRp loop
            
            ;load registers
            LD R3, SaveR3
            RET
            
;*************************************************************************
; This Subroutine in used to make it look like it ignites
; Register Usage:
; R2 used to count how much i want the loop to run
;************************************************************************
ignition:
            ;store registers
            ST R7, SaveR7 
            ST R0, SaveR0
            ST R2, SaveR2

            ;zero out R2 and set it to 5 (how many times the ignition loop runs)
            AND R2, R2, #0
            ADD R2, R2, #5
            
            
igloop      ;load first rocket and delay
            LEA R0, CLEAR
            PUTS
            LEA R0, ROCKET
            PUTS
            JSR delay
            
            ;load 2nd rocket and delay
            LEA R0, CLEAR
            PUTS
            LEA R0, ROCKET2
            PUTS
            JSR delay
            
            ;check if we need to keep looping
            ADD R2, R2, #-1
            BRp igloop
            
            ;restore registers
            LD R2, SaveR2
            LD R0, SaveR0
            LD R7, SaveR7
            RET

ROCKET .STRINGZ "     ^\n    / \\\n   /___\\\n   |   |\n   |   |\n   |___|\n    / \\\n   /___\\\n"
ROCKET2 .STRINGZ "     ^\n    / \\\n   /___\\\n   |   |\n   |   |\n   |___|\n    / \\\n   /___\\\n     |\n    ***\n"

;*************************************************************************
; This Subroutine in used to make it look like it moves up
; Each rocket prints less and less newlines to make it appear like it is going up
;************************************************************************
liftoff:
            ;store registers
            ST R7, SaveR7
            ST R0, SaveR0

            ;clear screen, dispay lift rocket, delay
            LEA R0, CLEAR
            PUTS
            LEA R0, LIFT1
            PUTS
            JSR delay
    
            ;clear screen, display lift2, delay
            LEA R0, CLEAR
            PUTS
            LEA R0, LIFT2
            PUTS
            JSR delay
    
            ;clear screen, display lift3, delay
            LEA R0, CLEAR
            PUTS
            LEA R0, LIFT3
            PUTS
            JSR delay

            ;restore registers
            LD R0, SaveR0
            LD R7, SaveR7
            RET

LIFT1 .STRINGZ "\n\n\n\n\n     ^\n    / \\\n   /___\\\n   |   |\n   |   |\n   |___|\n    / \\\n   /___\\\n     |\n    ***\n"
LIFT2 .STRINGZ "\n\n\n     ^\n    / \\\n   /___\\\n   |   |\n   |   |\n   |___|\n    / \\\n   /___\\\n     |\n    ***\n     |\n     |\n"
LIFT3 .STRINGZ "\n     ^\n    / \\\n   /___\\\n   |   |\n   |   |\n   |___|\n    / \\\n   /___\\\n     |\n    ***\n     |\n     |\n     |\n     |\n"

;*************************************************************************
; This Subroutine in used to make it look like it flies away
; This prints | more and more each time, to look like the rocket trail is going up
;************************************************************************
fly:
        ;store registers
        ST R7, FlySaveR7

        ;clear screen, display lift 4, delay
        LEA R0, CLEAR2
        PUTS
        LEA R0, LIFT4
        PUTS
        JSR delay

        ;clear screen, display lift 5, delay
        LEA R0, CLEAR2
        PUTS
        LEA R0, LIFT5
        PUTS
        JSR delay

        ;Restore registers
        LD R7, FlySaveR7
        
        RET

FlySaveR7 .BLKW 1
CLEAR2 .STRINGZ "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
LIFT4 .STRINGZ "     ^\n    / \\\n   /___\\\n   |   |\n   |   |\n   |___|\n    / \\\n   /___\\\n     |\n    ***\n     |\n     |\n     |\n     |\n     |\n     |\n"
LIFT5 .STRINGZ "     ^\n    / \\\n   /___\\\n   |   |\n   |   |\n   |___|\n    / \\\n   /___\\\n     |\n    ***\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n"

;*************************************************************************
; This Subroutine in used to make it look like it flies away
; This routine is the same as fly, I just needed to make another routine for memory 
;************************************************************************

away:
        ;store registers
        ST R7, AWAYR7
        
        ;Clear screen, display lift 6, delay
        LEA R0, CLEAR3
        PUTS
        LEA R0, LIFT6
        PUTS
        JSR delay
        
        ;Clear screen, display lift 7, delay
        LEA R0, CLEAR3
        PUTS
        LEA R0, LIFT7
        PUTS
        JSR delay
        LD R7, AWAYR7
        
        RET
AWAYR7 .BLKW 1       
CLEAR3 .STRINGZ "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"        
LIFT6 .STRINGZ "     ^\n    / \\\n   /___\\\n   |   |\n   |   |\n   |___|\n    / \\\n   /___\\\n     |\n    ***\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n"
LIFT7 .STRINGZ "|\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n     |\n"
        
        .END