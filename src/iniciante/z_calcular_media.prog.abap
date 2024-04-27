*&---------------------------------------------------------------------*
*& Report z_calcular_media
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_calcular_media.

TYPES: BEGIN OF ty_cliente,
        nome          TYPE string,
        salario       TYPE wrbtr,
       END OF ty_cliente.

DATA: lt_clientes TYPE TABLE OF ty_cliente WITH DEFAULT KEY.

DATA: lv_total_salario TYPE wrbtr,
      lv_media_salario TYPE wrbtr.

      lt_clientes = VALUE #(
        ( nome          = 'Cliente 1'
          salario       = '1780.67' )
        ( nome          = 'Cliente 2'
          salario       = '1850.66' )
        ( nome          = 'Cliente 3'
          salario       = '1990.65' )
      ).


"     Versão 1
      LOOP AT lt_clientes INTO DATA(ls_cliente).
        lv_total_salario += ls_cliente-salario.
      ENDLOOP.
      lv_media_salario = lv_total_salario / LINES( lt_clientes ).

"     Versão 2
      DATA lv_media TYPE wrbtr.
           lv_media = REDUCE  wrbtr( INIT soma = '0000.00'
                                     FOR  ls_clientes IN lt_clientes
                                     NEXT soma = soma + ls_clientes-salario ) / LINES( lt_clientes ).

      WRITE: / 'A média salarial versão 1:', lv_media_salario.
      WRITE: / 'A média salarial versão 2:', lv_media.
