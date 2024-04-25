*&---------------------------------------------------------------------*
*& Report z_positivo_negativo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_positivo_negativo.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_numero TYPE i.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

DATA numero TYPE string.
numero = p_numero.
CONDENSE numero.

IF p_numero < 0.
  WRITE: / 'Número', numero, 'é negativo'.
ELSEIF p_numero EQ 0.
  WRITE: / 'Este número é igual a zero'.
ELSE.
  WRITE: / 'Número', numero, 'é positivo'.
ENDIF.
