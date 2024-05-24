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
  ( id = 1 name = 'Maria'   discipline = 'Portuguese' note = 7 )
  ( id = 2 name = 'Carlos'  discipline = 'Science'    note = 6 )
  ( id = 3 name = 'Ana'     discipline = 'History'    note = 9 )
  ( id = 4 name = 'Laura'   discipline = 'Biology'    note = 10 )
  ( id = 5 name = 'Sophia'  discipline = 'Physics'    note = 4 )
  ( id = 6 name = 'Pedro'   discipline = 'Chemistry'  note = 5 )
  ( id = 7 name = 'John'    discipline = 'Math'       note = 1 )
  ( id = 8 name = 'Gabriel' discipline = 'Geography'  note = 8 )

).

DATA: lt_students_sorted TYPE TABLE OF ty_students.

LOOP AT lt_students INTO DATA(ls_students).
  IF lt_students_sorted[] IS INITIAL.
    APPEND ls_students TO lt_students_sorted.
    DATA(nota_atual) = ls_students-note.
  ELSE.
    IF ls_students-note <= nota_atual.
      APPEND ls_students TO lt_students_sorted.
      nota_atual = ls_students-note.
    ELSE.
      LOOP AT lt_students_sorted INTO DATA(ls_students_sorted).
        IF ls_students-note > ls_students_sorted-note.
          INSERT ls_students INTO lt_students_sorted INDEX sy-tabix.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDIF.
ENDLOOP.

LOOP AT lt_students_sorted INTO ls_students_sorted.
  WRITE: / `Nota:`, ls_students_sorted-note LEFT-JUSTIFIED, `- Aluno:`, ls_students_sorted-name.
ENDLOOP.
