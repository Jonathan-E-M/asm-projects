;Example of using the loop directive to do a count controlled loop
;which is the equivalent of a for loop

;The loop directive will loop until ecx = 0.
;You should initialize ecx to the number of times to loop
;
;mov ecx,5
;loopTop:
;  ;code
;  ;code
;  loop loopTop

;Each time through the above loop ecx is automatically decremented
;and the loop repeats (jumps to loopTop) until ecx is 0.
;The above loop repeats 5 times.
;The jump cannot be more than -128 to +127 bytes.


.386      ;identifies minimum CPU for this program

.MODEL flat,stdcall    ;flat - protected mode program
                       ;stdcall - enables calling of MS_windows programs

;allocate memory for stack
;(default stack size for 32 bit implementation is 1MB without .STACK directive 
;  - default works for most situations)

.STACK 4096            ;allocate 4096 bytes (1000h) for stack


;*************************PROTOTYPES*****************************

ExitProcess PROTO,dwExitCode:DWORD  ;from Win32 api not Irvine

DumpRegs PROTO  ;Irvine code for printing registers to the screen

ReadChar PROTO  ;Irvine code for getting a single char from keyboard
				;Character is stored in the al register.
			    ;Can be used to pause program execution until key is hit.

WriteDec PROTO  ;Irvine code for writing a dec number to the console

;************************DATA SEGMENT***************************

.data


;************************CODE SEGMENT****************************

.code

main PROC

	;populate eax with data then perform addition and subtraction

    mov     ecx, 5          ;loop will repeat 5 times
    jecxz   noLoop          ;if ecx == 0 skip loop
	;note: if ecx is initialized to a value <= 0, the loop below will possibly execute 4 billion times.
loopTop:
    mov     eax, ecx        ;copy count to eax to print it
    call    WriteDec        ;print count
    loop    loopTop         ;repeat loop until ecx == 0
                            ;ecx is automatically decremented.
                            ;The decrement is done and then the check is done for 0.
noLoop:                               

    call	ReadChar		;pause execution
	INVOKE	ExitProcess,0	;exit to dos

main ENDP
END main