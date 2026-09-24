BITS 32

SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4

STDIN equ 0
STDOUT equ 1

section .data

title db "The Swapping Program", 0xA
titleLen equ $ - title

msg1 db "Please enter a two character string: "
len1 equ $ - msg1

msg2 db 0xA, "The answer is: "
len2 equ $ - msg2

section .bss

two_char_string resb 3

section .text
global _start

_start:

	; Print title
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, title
	mov edx, titleLen
	int 0x80

	; Prompt user
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80

	; Read two-character string
	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, two_char_string
	mov edx, 3
	int 0x80

	; Swap characters
	mov al, [two_char_string]
	mov bl, [two_char_string + 1]

	mov [two_char_string], bl
	mov [two_char_string + 1], al

	; Print answer message
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg2
	mov edx, len2
	int 0x80

	; Print swapped string
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, two_char_string
	mov edx, 2
	int 0x80

	; Exit
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80
