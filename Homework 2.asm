# Tyler Echols
# Assignment 2 
# CS 2340.004 - Computer Architecture - F20
# Karen Mazidi
########################################################################################
# Due 9/13/20  
# Project Objective: Prompt user to Type in a word or phrase 
# Repeat Word or Phrase
# Count the Number of words,
# and Count the number of characters   
######################################################################################### 

		.data 
	
step1: 		.asciiz "Type A Word, or sentenace" 
step2:		.asciiz " Here's the word count:"   
step3:		.asciiz " Here's the charater count:" 
endmessage1: 	.asciiz " Closing Program " 
endmessage2: 	.asciiz " Gooodbye" 
string0: 	.space 100
		.align 2 
Wcount:		.word 0	
Vcount:		.word 0 

main:		.text 

Location1: 

 	# Taking input of word 
	li 	$v0, 54 
	la 	$a0, step1 
	la 	$a1, string0 
	li 	$a2, 54   
	syscall 
	
	
	# If user hits ok with blank line, or cancel 
	# $a1 contains status value 0: OK status. 
	# Buffer contains the input string. 
	# -2: Cancel was chosen. No change to buffer. 
	# -3: OK was chosen but no data had been input into field. No change to buffer. 
	# -4: length of the input string exceeded the specified maximum. 
	# Buffer contains the maximum allowable input string plus a terminating null. 
	
	beq 	$a1, -3, Mainexit 
	beq 	$a1, -2, Mainexit
	la 	$a1, string0 
	jal 	WordCount 
	sw 	$v1, Wcount 			# stores from v1 into Wcount
	sw	$v0, Vcount 			# stores from vo into Vcdount 
	
	
	la 	$a0, string0 
	li	$v0, 4 
	syscall			
	
	# Displaying step2 message
	la 	$a0, step2
	li	$v0, 4
	syscall
	# Space
	li 	$a0, 32  
	li 	$v0, 11 
	syscall
	
	#  Displaying Word Count
	lw	$a0, Wcount                    
	li	$v0, 1 
	syscall
	
	# Displaying step3 message
	la	$a0, step3
	li	$v0, 4
	syscall 
	
	# Space
	li 	$a0, 32 
	li 	$v0, 11 
	syscall
	# Display Character Count 
	lw 	$a0, Vcount 
	li	$v0, 1  
	syscall 
	# New Line 
	li 	$a0, 10
	li 	$v0, 11 
	syscall
	
	# Back to the top of loop       
	j  	Location1  
	
		
WordCount: 
	# This is using $a1 to read in String0
	  li	 $v0, 0 			# Letter Count 
	  li	 $v1, 0				# Word Count 
  	  li	 $t1, 0 			# the byte value of the string
  	  
 	 addi 	$sp, $sp, -4 			# moving value down by 4 
	 sw	$s1, ($sp) 			# save $s1 to store on stack, since value was movedd down by 4  
	 li 	$s1, 9 	 	    

  	   
  	   
Loop1WC: 

	lb 	$t1, ($a1) 		        # loading byte from address at a1 
	beqz 	$t1, WordCountExit		# If t1 equals 0 go to WordCountExit 
	addi	$a1, $a1, 1			# Increase Addresse by 1, so it loads new letter instead or repeating the same letter  
	addi	$v0, $v0, 1 			# Increasing the Count of letters by 1 
	beq  	$t1, 32, CheckingWhiteSpace  	# Checks for Space
	beq 	$t1, 10, CheckingWhiteSpace 	# Checks for line feed  
	beq	$t1, 9,	 CheckingWhiteSpace 	# Checks Horizontal Tab 
	   
	
Skip:	 
	
	j 	Loop1WC 			# jump back into loop 
 
CheckingWhiteSpace: 
	
	 add 	$v1, $v1, 1 			# Checking Word Count 
	 j	Loop1WC  			# Goes Back to the top of Loop1WC 
 
 WordCountExit: 
  	sub	$v0, $v0, 1
  	lw 	$s1, ($sp)			# retore $s1
	addi 	$sp, $sp, 4 
 	jr 	$ra 				# return to the return address  			
Mainexit: 	
	# Close Program 
	li 	$v0, 59 
	la 	$a0, endmessage1
	la 	$a1, endmessage2 
	syscall 
	
	li 	$v0, 10 
	syscall 
	
	
	
	
	
	
	
	
	
	 
	
	
	
	
	 

