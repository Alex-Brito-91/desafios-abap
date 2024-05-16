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

* Solução Usando Ordenação SORT
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

WRITE: / `Valores Únicos com SORT:`.
LOOP AT lt_unique_values INTO ls_unique_values.
  WRITE: ls_unique_values-field.
ENDLOOP.

* Solução Usando SELECT COUNT
SELECT field, COUNT(*) AS qtd
  FROM @lt_values AS values
  GROUP BY field
  INTO TABLE @DATA(lt_unique).
DELETE lt_unique WHERE qtd GT 1.

WRITE: / `Valores Únicos com SELECT COUNT:`.
LOOP AT lt_unique INTO DATA(ls_unique).
  WRITE: ls_unique-field.
ENDLOOP.

* Solução Usando Loop com Controlador
TYPES: BEGIN OF tt_values_unique,
        field TYPE c,
        qtd   TYPE i,
       END OF tt_values_unique.
DATA: lt_values_unique TYPE TABLE OF tt_values_unique.

LOOP AT lt_values INTO DATA(ls_values).
  COLLECT VALUE tt_values_unique( field = ls_values-field qtd = 1 ) INTO lt_values_unique.
ENDLOOP.
DELETE lt_values_unique WHERE qtd GT 1.

WRITE: / `Valores Únicos com LOOP:`.
LOOP AT lt_values_unique INTO DATA(ls_values_unique).
  WRITE: ls_values_unique-field.
ENDLOOP.
