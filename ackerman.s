	.arch armv7-a
	.text
	.align	2
	.global	ackermann
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	ackermann, %function

// r0 contains a number m
// r1 contains a number n
ackermann:
	push		{r1-r2, fp, lr}
	add		fp, sp, #8
	sub		sp, sp, #12

	cmp		r0, #0			//CHECK #1 M == 0
	blt		illegalParameter
	bne		check2			//go to check 2

	add		r0, r1, #1		//return n + 1
	b		epilogue

check2:
	cmp		r1, #0			//if n != 0 
	blt		illegalParameter
	bne		check3			//go to check 3
	
	blt		epilogue

	sub		r0, r0, #1		//param1 = m - 1
	mov		r1, #1			//move 1 to r1 
	bl		ackermann		//make call - ack(m - 1, 1);
	b		epilogue

check3:
	mov		r2,r0
	sub		r1,r1,#1
	bl		ackermann				//make call ack(m, n - 1)

	mov		r1,r0
	sub		r0,r2,#1
	bl 		ackermann
	b 		epilogue	

illegalParameter:
	mov		r0, #-1

epilogue:
	sub		sp, fp, #8		

	pop		{r1-r2, fp, pc}
