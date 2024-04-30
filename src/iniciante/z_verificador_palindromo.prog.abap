*&---------------------------------------------------------------------*
*& Report z_verificador_palindromo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_verificador_palindromo.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_texto TYPE string.
SELECTION-SCREEN END OF BLOCK b1.

  DATA(texto_verificar) = TO_UPPER( p_texto ).
  CONDENSE texto_verificar NO-GAPS.

  DATA: lv_index1     TYPE i,
        texto_invertido TYPE string.

  DO STRLEN( texto_verificar ) TIMES.
    lv_index1 = sy-index - 1.
    DATA(lv_char1) = texto_verificar+lv_index1(1).
      texto_invertido = |{ lv_char1 }{ texto_invertido }|.
  ENDDO.

START-OF-SELECTION.

  IF texto_invertido EQ texto_verificar.
    WRITE: / p_texto, 'é Palíndromo'.
  ELSE.
    WRITE: / p_texto, 'não é Palíndromo'.
  ENDIF.

  WRITE: / 'Texto normal:', p_texto,
         / 'Texto invertido para conferência:', texto_invertido.
