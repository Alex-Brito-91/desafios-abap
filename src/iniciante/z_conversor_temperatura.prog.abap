*&---------------------------------------------------------------------*
*& Report z_conversor_temperatura
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_conversor_temperatura.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_temp1 TYPE p DECIMALS 1.
  SELECTION-SCREEN SKIP 1.
  PARAMETERS: rb_cel1 RADIOBUTTON GROUP rb1,
              rb_far1 RADIOBUTTON GROUP rb1.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: rb_cel2 RADIOBUTTON GROUP rb2,
              rb_far2 RADIOBUTTON GROUP rb2.
SELECTION-SCREEN END OF BLOCK b2.
