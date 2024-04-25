*&---------------------------------------------------------------------*
*& Report z_sequencia_fibonacci
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_sequencia_fibonacci.

TYPES: ty_integer TYPE TABLE OF i WITH DEFAULT KEY.
DATA(lt_fibonacci) = VALUE ty_integer( ( 0 ) ( 1 ) ).
DATA: lv_num_anterior TYPE i,
      lv_num_atual    TYPE i,
      lv_fibonacci    TYPE i.

DO 8 TIMES.

  READ TABLE lt_fibonacci INTO lv_num_atual    INDEX lines( lt_fibonacci ).
  READ TABLE lt_fibonacci INTO lv_num_anterior INDEX lines( lt_fibonacci ) - 1.
  lv_fibonacci = lv_num_atual + lv_num_anterior.
  APPEND lv_fibonacci TO lt_fibonacci.

ENDDO.

LOOP AT lt_fibonacci INTO DATA(ls_fibonacci).
  WRITE: / ls_fibonacci.
ENDLOOP.
