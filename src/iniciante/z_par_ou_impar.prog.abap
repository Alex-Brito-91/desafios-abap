*&---------------------------------------------------------------------*
*& Report z_par_ou_impar
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_par_ou_impar.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_number TYPE i.
SELECTION-SCREEN END OF BLOCK B1.

START-OF-SELECTION.

  IF p_number MOD 2 = 0.
    WRITE: / p_number,'é Par!'.
  ELSE.
    WRITE: / p_number,'é Ímpar!'.
  ENDIF.
