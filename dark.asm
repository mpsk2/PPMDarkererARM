	.file "dark.asm"
	.text
	.global dark
	.type dark, %function
dark:
	mul   r3, r1, r2         @ calculate number of iterations columns x rows
	@ at that point r3 is used and r1 and r2 are free

	cmp   r3, #0             @ check if number of iterations equals 0
        movle pc, lr             @ return

	@ we have array of arrays
	@ first argument is of type pixel**
	@ pixel[1] = pixel[0] + sizeof(pixel) * columns
	@ we store pixel[0] in r0, which is pointer
	@ than we will add 12 to it, as it is sizeof(pixel)
	@ we do not care which row and column it is
	@ because operations are independent
	@ r1 and r2 are free now
	@ r0, r1, r2 will hold pointers
	@ r3 hold iterations counter
	@ r1, r2 and r3 will be used for evaluation
	@ r4, r5, r6 will be used for evaulation
	@ r7, r8, r9 will hold constants

	ldr   r0, [r0]           @ store fields[0].r in r0
	mov   r1, r0             @ store fields[0].r in r1
        add   r1, r1, #4         @ add 4, so r1 is fields[0].g
	mov   r2, r0             @ store fields[0].r in r2
        add   r2, r2, #8         @ add 8, so r2 is fields[0].b

	mov   r7, #77            @ red    multiplier
        mov   r8, #151           @ green  multiplier
        mov   r9, #28            @ blue   multiplier

.LI0:
        sub   r3, r3, #1         @ decrement iterations counter

	@ store values

	ldr   r4, [r0]           @ store red   value at r4
	ldr   r5, [r1]           @ store green value at r5
	ldr   r6, [r2]           @ store blue  value at r6

	@ mul values by constants

	mul   r4, r7, r4         @ mul red   value by red   multiplier
	mul   r5, r8, r5         @ mul green value by green multiplier
	mul   r6, r9, r6         @ mul blue  value by blue  multiplier

	add   r4, r4, r5         @ add to red green
        add   r4, r4, r6         @ add to red and green blue

	mov   r4, r4, asr #8     @ div by 256

        str   r4, [r0]
        str   r4, [r1]
        str   r4, [r2]
	
	add   r0, r0, #12        @ go to next pixel
	add   r1, r1, #12        @ go to next pixel
	add   r2, r2, #12        @ go to next pixel


	cmp   r3, #0             @ compare iteratoins counter with 0
        bgt   .LI0               @ if is greater than, we need at least one more iteration, 
	                         @ jump to begging of loop
	
	sub   r3, r3, #1         @ decr one from iterations	
	mov   pc, lr             @ return
