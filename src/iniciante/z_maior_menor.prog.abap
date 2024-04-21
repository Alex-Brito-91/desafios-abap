*&---------------------------------------------------------------------*
*& Report z_maior_menor
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_maior_menor.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_valor1 TYPE i,
              p_valor2 TYPE i.
SELECTION-SCREEN END OF BLOCK b1.

DATA: s_valor1 TYPE string,
      s_valor2 TYPE string.

      s_valor1 = p_valor1.
      s_valor2 = p_valor2.

      CONDENSE s_valor1.
      CONDENSE s_valor2.

START-OF-SELECTION.
  IF p_valor1 > p_valor2.
    WRITE: s_valor1, 'é maior que', s_valor2.
  ELSEIF p_valor1 EQ p_valor2.
    WRITE: s_valor1, 'e' , s_valor2 , 'são iguais!'.
  ELSE.
    WRITE: s_valor1, 'é menor que', s_valor2.
  ENDIF.
