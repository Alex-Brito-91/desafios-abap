*&---------------------------------------------------------------------*
*& Report z_dados_sflight
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_dados_sflight.

DATA: lt_sflight TYPE TABLE OF sflight.

      SELECT *
        FROM sflight
        INTO TABLE lt_sflight.

        LOOP AT lt_sflight INTO DATA(ls_sflight).
          WRITE: / ls_sflight-planetype.
        ENDLOOP.
