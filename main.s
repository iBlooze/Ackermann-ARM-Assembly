	
	.arch armv7-a
	.fpu vfpv3-d16
	.syntax unified
    
	.section	.rodata
	.align	2

msg: 
	.asciz 	"ackermann (%d, %d) is: %d\n"

	.text
	.global main
	.type	main, %function

//r3 loop control variable 
//r4 is the value of m 
//r5 is the value of n	
main:
	push	{r4, fp, lr}
	add		fp, sp, #4
	sub		sp, sp, #8

	mov		r4, #0			//m = 0
	mov		r5, #0			//n = 0

loopTop:
	mov		r5, #0			//n = 0

setupAck:
	mov		r0, r4			//move m into first parameter
	mov		r1, r5			//move n into 2nd parameter
	bl		ackermann		//make call to ack
	
	mov		r3, r0			//load return value of ack into 3rd parameter
	ldr		r0, msgAddr	
	mov		r1, r4			//load m	into the 1st parameter
	mov		r2, r5			//load n into the 2nd parameter	
	bl		printf			//call print
	add		r5, r5, #1		//n++	

	cmp		r5, #5			//check what index in loop we are
	ble		setupAck
	
	add		r4, r4, #1		//m++
	cmp		r4, #5			
	ble		loopTop			

	mov		r3, #0
	mov		r0, r3
	
epilogue:
	sub		sp, fp, #4
	pop		{r5, fp, pc}

msgAddr: 
	.word msg
	