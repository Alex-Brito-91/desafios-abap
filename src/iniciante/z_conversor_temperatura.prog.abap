*&---------------------------------------------------------------------*
*& Report z_conversor_temperatura
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_conversor_temperatura.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECTION-SCREEN SKIP 1.
  PARAMETERS: p_temp1 TYPE p DECIMALS 1.
  PARAMETERS: rb_cel1 RADIOBUTTON GROUP rb1,
              rb_far1 RADIOBUTTON GROUP rb1.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECTION-SCREEN SKIP 1.
  PARAMETERS: rb_cel2 RADIOBUTTON GROUP rb2,
              rb_far2 RADIOBUTTON GROUP rb2.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.

DATA temp TYPE p DECIMALS 1.

IF rb_cel1 = 'X'.
  IF rb_far2 = 'X'.
    temp = 9 / 5 * p_temp1 + 32.
    DATA farenheit TYPE string.
    farenheit = temp.
    CONDENSE farenheit.
    WRITE: 'A temperatura é', farenheit, '°F' LEFT-JUSTIFIED.
  ELSE.
    MESSAGE 'Não se pode converter Celsius para Celsius!' TYPE 'I'.
  ENDIF.
ELSEIF rb_far1 = 'X'.
  IF rb_cel2 = 'X'.
    temp = 5 / 9 * ( p_temp1 - 32 ).
    DATA celsius TYPE string.
    celsius = temp.
    CONDENSE celsius.
    WRITE: 'A temperatura é', celsius, '°C' LEFT-JUSTIFIED.
  ELSE.
    MESSAGE 'Não se pode converter Farenheit para Farenheit!' TYPE 'I'.
  ENDIF.
ENDIF.
