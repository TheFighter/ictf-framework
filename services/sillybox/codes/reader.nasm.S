BITS 32

; This is not actually guaranteed to work in NASM...
#include <asm/unistd_32.h>

%strlen contentlen CONTENT

start:

    call tg
tg: pop edi

    lea ebx, [edi + fname-tg]   ; p1 = &fname
    xor ecx, ecx                ; p2 = O_RDONLY
    mov eax, __NR_open
    call [gs:0x10]

    mov ebx, 1                  ; p1 = 1
    mov ecx, eax                ; p2 = fd
    xor edx, edx                ; p3 = NULL
    mov esi, contentlen         ; p4 = contentlen
    mov eax, __NR_sendfile
    call [gs:0x10]

    mov ebx, ecx                ; p1 = fd
    mov eax, __NR_close
    call [gs:0x10]

    mov ebx, 0
    mov eax, __NR_exit_group
    call [gs:0x10]

fname: db FILENAME, 0
