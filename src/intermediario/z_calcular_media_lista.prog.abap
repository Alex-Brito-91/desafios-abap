*&---------------------------------------------------------------------*
*& Report z_calcular_media_lista
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_calcular_media_lista.

TYPES: BEGIN OF ty_students,
        id         TYPE i,
        name       TYPE string,
        discipline TYPE string,
        note       TYPE i,
       END OF ty_students.

DATA lt_students TYPE TABLE OF ty_students.

lt_students = VALUE #(
  ( id = 1 name = `John`    discipline = `Math`       note = 8 )
  ( id = 2 name = `Maria`   discipline = `Portuguese` note = 7 )
  ( id = 3 name = `Carlos`  discipline = `Science`    note = 6 )
  ( id = 4 name = `Ana`     discipline = `History`    note = 9 )
  ( id = 5 name = `Sophia`  discipline = `Physics`    note = 5 )
  ( id = 6 name = `Pedro`   discipline = `Chemistry`  note = 4 )
  ( id = 7 name = `Laura`   discipline = `Biology`    note = 10 )
  ( id = 8 name = `Gabriel` discipline = `Geography`  note = 1 )
).

DATA: lv_notas TYPE i.

LOOP AT lt_students ASSIGNING FIELD-SYMBOL(<fs_students>).
  lv_notas += <fs_students>-note.
ENDLOOP.

DATA(lv_media) = lv_notas / LINES( lt_students ).

WRITE: / `Média dos Alunos:`, lv_media.
