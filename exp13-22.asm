assume cs:code
code segment
start:
 mov ax, cs      
    mov ds, ax
    mov si, offset lp
    
    ;搬运
    mov ax, 0
    mov es, ax
    mov di, 200h
    mov cx, offset lp_end - offset lp
    cld
    rep movsb

    ; 设置中断向量表 
    mov ax, 0
    mov es, ax
    mov word ptr es:[7ch*4], 200h     
    mov word ptr es:[7ch*4+2], 0        

    mov ax, 4c00h
    int 21h

    ;循环实现
lp: push bp           
    mov bp, sp          
    
    dec cx              
    jcxz lp_ret         
    
    add [bp+2], bx      

lp_ret:
    pop bp           
    iret    

lp_end:
    nop

code ends
end start
            