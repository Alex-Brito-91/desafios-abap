*&---------------------------------------------------------------------*
*& Report z_encontrar_valor_lista
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_encontrar_valor_lista.

TYPES: BEGIN OF tt_values,
        field TYPE c,
       END OF tt_values.

DATA: lt_values        TYPE TABLE OF tt_values,
      lt_unique_values TYPE TABLE OF tt_values.

lt_values = VALUE #(
  ( field = 'A' )
  ( field = 'B' )
  ( field = 'B' )
  ( field = 'D' )
  ( field = 'G' )
  ( field = 'F' )
  ( field = 'A' )
  ( field = 'F' )
).

SORT lt_values.

MOVE-CORRESPONDING lt_values TO lt_unique_values.

DATA(contador) = 1.

LOOP AT lt_unique_values INTO DATA(ls_unique_values).

  DATA(valor_atual)   = lt_unique_values[ contador ].
  DATA(proximo_valor) = lt_unique_values[ contador + 1 ].

  IF valor_atual EQ proximo_valor.
    DELETE: lt_unique_values INDEX contador,
            lt_unique_values INDEX contador.
    contador = 1.
  ELSE.
    contador += 1.
  ENDIF.

ENDLOOP.

WRITE: / `Valores Únicos da Lista com SORT:`.
LOOP AT lt_unique_values INTO ls_unique_values.
  WRITE: ls_unique_values-field.
ENDLOOP.
