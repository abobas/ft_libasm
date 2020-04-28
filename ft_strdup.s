; **************************************************************************** ;
;                                                                              ;
;                                                         ::::::::             ;
;    ft_strdup.s                                        :+:    :+:             ;
;                                                      +:+                     ;
;    By: telly <telly@student.codam.nl>               +#+                      ;
;                                                    +#+                       ;
;    Created: 2020/04/16 15:33:43 by telly         #+#    #+#                  ;
;    Updated: 2020/04/16 15:41:36 by telly         ########   odam.nl          ;
;                                                                              ;
; **************************************************************************** ;

global  ft_strdup
extern  malloc

ft_strdup:
                    cmp     rdi, 0                          ;check input string
                    je      error
                    mov     rcx, 0                          ;index
length_inc:
                    inc     rcx
length:
                    cmp     byte[rdi + rcx], 0              ;check end of string
                    jne     length_inc
allocate:
                    mov     rbx, rdi                        ;save string in register rbx
                    mov     rdi, rcx                        ;argument malloc = size
                    call    malloc
                    cmp     rax, 0                          ;check malloc return value
                    je      error
                    mov     rcx, 0                          ;reset index to 0
                    jmp     copy
increment_copy:
                    inc     rcx               
copy:
                    mov     dl, byte[rbx + rcx]
                    mov     byte[rax + rcx], dl             ;copy char into destination string
                    cmp     dl, 0                           ;check delimiter
                    je      return
                    jmp     increment_copy
error:
                    mov    rax, 0                           ;error return
                    ret           
return:
                    ret