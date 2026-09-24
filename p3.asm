BITS 32

SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4

STDIN equ 0
STDOUT equ 1

section .data

title db "The Dividing Program", 0xA
titleLen equ $ - title

msg1 db "Please enter a single digit number: "
len1 equ $ - msg1

msg2 db 0xA, "Please enter a single digit number: "
len2 equ $ - msg2

quotMsg db 0xA, "The quotient is: "
quotLen equ $ - quotMsg

remMsg db 0xA, "The remainder is: "
remLen equ $ - remMsg

section .bss

num1 resb 2
num2 resb 2
quotient resb 1
remainder resb 1

section .text
global _start

_start:

	; Print title
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, title
	mov edx, titleLen
	int 0x80

	; First prompt
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80

	; Read first digit
	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, num1
	mov edx, 2
	int 0x80

	; Second prompt
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg2
	mov edx, len2
	int 0x80

	; Read second digit
	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, num2
	mov edx, 2
	int 0x80

	; Convert first number
	mov al, [num1]
	sub al, '0'

	; Clear AH
	mov ah, 0

	; Convert second number
	sub byte [num2], '0'

	; Divide AX by second number
	idiv byte [num2]

	; Save quotient
	add al, '0'
	mov [quotient], al

	; Save remainder
	add ah, '0'
	mov [remainder], ah

	; Print quotient label
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, quotMsg
	mov edx, quotLen
	int 0x80

	; Print quotient
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, quotient
	mov edx, 1
	int 0x80

	; Print remainder label
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, remMsg
	mov edx, remLen
	int 0x80

	; Print remainder
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, remainder
	mov edx, 1
	int 0x80

	; Exit
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80
