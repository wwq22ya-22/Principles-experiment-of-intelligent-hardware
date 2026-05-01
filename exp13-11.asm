assume cs:code
code segment
start:
    mov ax, cs      
    mov ds, ax
    mov si, offset show
    
    ;搬运
    mov ax, 0
    mov es, ax
    mov di, 200h
    mov cx, offset show_end - offset show
    cld
    rep movsb

    ; 设置中断向量表 
    mov ax, 0
    mov es, ax
    mov word ptr es:[7ch*4], 200h     
    mov word ptr es:[7ch*4+2], 0        

    mov ax, 4c00h
    int 21h

    ;显示程序
show:
    push ax
    push bx
    push es
    push si
    push di

    mov ax, 0b800h
    mov es, ax

    mov di, 0       

    mov al, 160
    mul dh         
    add di, ax

    mov al, 2
    mul dl          
    add di, ax      


s:  mov al, [si]
    cmp al, 0
    je show_ret
    
    mov es:[di], al     
    mov es:[di+1], cl   
    
    inc si               
    add di, 2           
    jmp s

show_ret:
    pop di
    pop si
    pop es
    pop bx
    pop ax
    iret               

show_end:
    nop

code ends
end start