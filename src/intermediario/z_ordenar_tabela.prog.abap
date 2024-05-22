*&---------------------------------------------------------------------*
*& Report z_ordenar_tabela
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ordenar_tabela.

TYPES: BEGIN OF ty_students,
        id         TYPE i,
        name       TYPE string,
        discipline TYPE string,
        note       TYPE i,
       END OF ty_students.

DATA lt_students TYPE TABLE OF ty_students.

lt_students = VALUE #(
  ( id = 1 name = 'John'    discipline = 'Math'       note = 8 )
  ( id = 2 name = 'Maria'   discipline = 'Portuguese' note = 7 )
  ( id = 3 name = 'Carlos'  discipline = 'Science'    note = 6 )
  ( id = 4 name = 'Ana'     discipline = 'History'    note = 9 )
  ( id = 5 name = 'Sophia'  discipline = 'Physics'    note = 5 )
  ( id = 6 name = 'Pedro'   discipline = 'Chemistry'  note = 4 )
  ( id = 7 name = 'Laura'   discipline = 'Biology'    note = 10 )
  ( id = 8 name = 'Gabriel' discipline = 'Geography'  note = 1 )
).

DATA lt_students_order TYPE TABLE OF ty_students.

SELECT MAX( note )
  FROM @lt_students AS students
  INTO @DATA(lv_contador).

DO lv_contador TIMES.
  LOOP AT lt_students INTO DATA(ls_index).
    IF ls_index-note EQ lv_contador.
      APPEND ls_index TO lt_students_order.
    ENDIF.
  ENDLOOP.
  lv_contador -= 1.
ENDDO.

cl_salv_table=>factory(
 IMPORTING
  r_salv_table = DATA(lo_alv)
 CHANGING
  t_table = lt_students_order
 ).

lo_alv->display( ).
