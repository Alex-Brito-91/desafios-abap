*&---------------------------------------------------------------------*
*& Report z_soma_valores
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_soma_valores.

DATA: valor1    TYPE i,
      valor2    TYPE i,
      resultado TYPE i.

valor1    = 10.
valor2    = 20.
resultado = valor1 + valor2.

WRITE: resultado.
