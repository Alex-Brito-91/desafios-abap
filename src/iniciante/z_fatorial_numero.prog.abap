*&---------------------------------------------------------------------*
*& Report z_fatorial_numero
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_fatorial_numero.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_numero TYPE int8.
SELECTION-SCREEN END OF BLOCK b1.

DATA i_fatorial TYPE int8.
i_fatorial = 1.

START-OF-SELECTION.

DO p_numero TIMES.
  i_fatorial = i_fatorial * sy-index.
ENDDO.

DATA: numero   TYPE string,
      fatorial TYPE string.

numero   = p_numero.
fatorial = i_fatorial.

CONDENSE numero.
CONDENSE fatorial.

WRITE: / 'O Fatorial de', numero , 'é', fatorial.
