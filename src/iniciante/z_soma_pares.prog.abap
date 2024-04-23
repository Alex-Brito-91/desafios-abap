*&---------------------------------------------------------------------*
*& Report z_soma_pares
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_soma_pares.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_numero TYPE i.
SELECTION-SCREEN END OF BLOCK b1.

DATA: lv_pares TYPE i.

START-OF-SELECTION.

DO p_numero TIMES.
DATA(lv_index) = sy-index.
  IF lv_index MOD 2 EQ 0.
    lv_pares += lv_index.
  ENDIF.
ENDDO.

WRITE: / lv_pares.
