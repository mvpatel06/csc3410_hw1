BITS 32

SYS_EXIT	 equ 1
SYS_READ	 equ 3
SYS_WRITE	 equ 4

STDIN		 equ 0
STDOUT		 equ 1

section .data

	title db "The Adding Program", 0xA
	titleLen equ $ - title

	msg1 db "Please enter a single digit number: "
	len1 equ $ - msg1

	msg2 db 0xA, "Please enter a second single digit number: "
	len2 equ $ - msg2

	msg3 db 0xA, "The answer is: "
	len3 equ $ - msg3

section .bss

	num1 resb 2
	num2 resb 2
	res resb 1

section .text
global _start

_start:

	; Prints title
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, title
	mov edx, titleLen
	int 0x80

	; The prompt for first number
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80

	; Reads first number
	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, num1
	mov edx, 2
	int 0x80

	; The prompt for second number
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg2
	mov edx, len2
	int 0x80

	; Reads second number
	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, num2
	mov edx, 2
	int 0x80

	; Converts ASCII digits to numbers
	mov eax, [num1]
	sub eax, '0'

	mov ebx, [num2]
	sub ebx, '0'

	; Adds the numbers
	add eax, ebx

	; Converts the result bask to ASCII
	add eax, '0'

	; Store result
	mov [res], al

	; Prints answer message
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg3
	mov edx, len3
	int 0x80

	; Print result
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, res
	mov edx, 1
	int 0x80

exit:
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80
