*&---------------------------------------------------------------------*
*& Report z_inverter_string
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_inverter_string.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_string TYPE string.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
DATA s_reverse TYPE string.
s_reverse = REVERSE( p_string ).

DATA: gv_output_string TYPE string,
      gv_index         TYPE i.

DO STRLEN( p_string ) TIMES.
  gv_index         = sy-index - 1.
  DATA(gv_char)    = p_string+gv_index(1).
  gv_output_string = |{ gv_char }{ gv_output_string }|.
ENDDO.

WRITE: / 'inverter com o REVERSE:', s_reverse.
WRITE: / 'inverter com o laço DO: ', gv_output_string.
