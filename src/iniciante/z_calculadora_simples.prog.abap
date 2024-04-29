*&---------------------------------------------------------------------*
*& Report z_calculadora_simples
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_calculadora_simples.

TABLES: sscrfields.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  SELECTION-SCREEN SKIP 1.

  PARAMETERS: p_valor1 TYPE p DECIMALS 2.

  PARAMETERS: r_add  RADIOBUTTON GROUP rb1,
              r_sub  RADIOBUTTON GROUP rb1,
              r_mult RADIOBUTTON GROUP rb1,
              r_div  RADIOBUTTON GROUP rb1.

  PARAMETERS: p_valor2 TYPE p DECIMALS 2.

SELECTION-SCREEN END OF BLOCK b1.

DATA lv_resultado TYPE p DECIMALS 2.

START-OF-SELECTION.

  CASE 'X'.
    WHEN r_add.
      lv_resultado = p_valor1 + p_valor2.
    WHEN r_sub.
      lv_resultado = p_valor1 - p_valor2.
    WHEN r_mult.
      lv_resultado = p_valor1 * p_valor2.
    WHEN r_div.
      IF p_valor2 EQ 0.
        WRITE: 'Divisão por zero não é permitida!'.
        EXIT.
      ELSE.
        lv_resultado = p_valor1 / p_valor2.
      ENDIF.
  ENDCASE.

  WRITE: 'Resultado:', lv_resultado.
