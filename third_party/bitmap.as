
#module ;======================================================

#uselib "gdi32.dll"
#cfunc _CreateDC "CreateDCA" sptr, sptr, sptr, int
#cfunc _CreateCompatibleDC "CreateCompatibleDC" int
#cfunc _CreateCompatibleBitmap "CreateCompatibleBitmap" int, int, int
#func  _SelectObject "SelectObject" int, int
#func  _BitBlt "BitBlt" int, int, int, int, int, int, int, int, int
#func  _DeleteDC "DeleteDC" int
#func  _DeleteObject "DeleteObject" int

#define NULL 0
#define SRCCOPY     0x00CC0020

;--------------------------------------------------------------
; CreateBitmap  �f�B�X�v���C�݊�DDB�I�u�W�F�N�g�쐬
;--------------------------------------------------------------
#defcfunc _CreateBitmap int px, int py, int sx, int sy

; �f�B�X�v���C�̃f�o�C�X�R���e�L�X�g�̃n���h���擾
hdcScreen = _CreateDC("DISPLAY", NULL, NULL, NULL)

; �f�B�X�v���C�݊��r�b�g�}�b�v�I�u�W�F�N�g�쐬
hBitmap = _CreateCompatibleBitmap(hdcScreen, sx, sy)

; �f�B�X�v���C�݊��f�o�C�X�R���e�L�X�g�쐬
hdcMemory = _CreateCompatibleDC(hdcScreen)

; �r�b�g�}�b�v���f�o�C�X�R���e�L�X�g�ɑI��
_SelectObject hdcMemory, hBitmap
hOldBitmap = stat

; HSP�E�B���h�E����r�b�g�}�b�v�ɃC���[�W���R�s�[
_BitBlt hdcMemory, 0, 0, sx, sy, hdc, px, py, SRCCOPY

; �f�o�C�X�R���e�L�X�g�̑I���r�b�g�}�b�v��߂�
_SelectObject hdcMemory, hOldBitmap

; �f�o�C�X�R���e�L�X�g���폜
_DeleteDC hdcMemory
_DeleteDC hdcScreen

; �r�b�g�}�b�v�I�u�W�F�N�g�̃n���h����Ԃ�
return hBitmap

;--------------------------------------------------------------
; CreateDIB  DIB�Z�N�V�����I�u�W�F�N�g�쐬
;--------------------------------------------------------------
#defcfunc CreateDIB int px, int py, int sx, int sy

; DIB�Z�N�V�����I�u�W�F�N�g�쐬
hBitmap = _CreateCompatibleBitmap(hdc, sx, sy)

; �������f�o�C�X�R���e�L�X�g�쐬
hdcMemory = _CreateCompatibleDC(hdc)

; �r�b�g�}�b�v���f�o�C�X�R���e�L�X�g�ɑI��
_SelectObject hdcMemory, hBitmap
hOldBitmap = stat

; HSP�E�B���h�E����r�b�g�}�b�v�ɃC���[�W���R�s�[
_BitBlt hdcMemory, 0, 0, sx, sy, hdc, px, py, SRCCOPY

; �f�o�C�X�R���e�L�X�g�̑I���r�b�g�}�b�v��߂�
_SelectObject hdcMemory, hOldBitmap

; �f�o�C�X�R���e�L�X�g���폜
_DeleteDC hdcMemory

; �r�b�g�}�b�v�I�u�W�F�N�g(DIB�Z�N�V����)�̃n���h����Ԃ�
return hBitmap

;--------------------------------------------------------------
; DeleteBitmap  �r�b�g�}�b�v�I�u�W�F�N�g�폜
;--------------------------------------------------------------
#deffunc DeleteBitmap int hbmp

; �r�b�g�}�b�v�I�u�W�F�N�g���폜
_DeleteObject hbmp
return

#global ;======================================================