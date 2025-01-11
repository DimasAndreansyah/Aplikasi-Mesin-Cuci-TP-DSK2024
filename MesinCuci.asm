INCLUDE emu8086.inc

.MODEL SMALL
.STACK 100H
.DATA
    MSG_START    DB 'Menu Mesin Cuci', 13, 10, '$'
    MSG_MODE     DB 13, 10, 'Pilih Mode: [1] Otomatis, [2] Manual, [3] Keluar$', 13, 10, '$'
    MSG_AUTO     DB 13, 10, 'Pilih Siklus Otomatis:', 13, 10, 'klik [1] untuk cuci otomatis$', 13, 10, '$'
    MSG_MANUAL   DB 13, 10, 'Pilih Operasi Manual:', 13, 10, 'klik [1] untuk Cuci$', 13, 10, '$'
    MSG_END      DB 13, 10, 'Proses Selesai!$', 13, 10, '$'
    MSG_ERROR    DB 13, 10, 'Pilihan tidak valid!$', 13, 10, '$'

    CHOICE       DB ?  ; Variabel untuk menyimpan pilihan pengguna

.CODE
START:
    ; Inisialisasi segment register
    MOV AX, @DATA
    MOV DS, AX

    ; Tampilkan pesan awal
    LEA DX, MSG_START
    MOV AH, 09H
    INT 21H

MAIN_MENU:
    ; Tampilkan menu utama
    LEA DX, MSG_MODE
    MOV AH, 09H
    INT 21H

    ; Masukkan pilihan
    CALL INPUT_CHOICE
    CMP CHOICE, '1'
    JE AUTOMATIC_MODE
    CMP CHOICE, '2'
    JE MANUAL_MODE
    CMP CHOICE, '3'
    JE EXIT_PROGRAM
    JMP INVALID_CHOICE

AUTOMATIC_MODE:
    ; Tampilkan menu mode otomatis
    LEA DX, MSG_AUTO
    MOV AH, 09H
    INT 21H

    ; Masukkan pilihan
    CALL INPUT_CHOICE
    CMP CHOICE, '1'
    JE QUICK_CYCLE

    ; Siklus cepat
QUICK_CYCLE:
    CALL WASH
    JMP MAIN_MENU


MANUAL_MODE:
    ; Tampilkan menu mode manual
    LEA DX, MSG_MANUAL
    MOV AH, 09H
    INT 21H

    ; Masukkan pilihan
    CALL INPUT_CHOICE
    CMP CHOICE, '1'
    JE WASH_AND_RETURN
    CMP CHOICE, '2'
    JMP INVALID_CHOICE

INVALID_CHOICE:
    ; Tampilkan pesan kesalahan
    LEA DX, MSG_ERROR
    MOV AH, 09H
    INT 21H
    JMP MAIN_MENU

WASH_AND_RETURN:
    CALL WASH
    JMP MAIN_MENU


WASH:
    ; Fungsi mencuci
    LEA DX, MSG_END
    MOV AH, 09H
    INT 21H
    RET

INPUT_CHOICE:
    ; Fungsi untuk membaca input dari pengguna
    MOV AH, 01H
    INT 21H
    MOV CHOICE, AL
    RET

EXIT_PROGRAM:
    ; Keluar dari program
    LEA DX, MSG_END
    MOV AH, 09H
    INT 21H
    MOV AX, 4C00H
    INT 21H

END START
