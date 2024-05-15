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

DATA: lv_soma_loop   TYPE i,
      lv_soma_reduce TYPE i,
      lv_media       TYPE i.

LOOP AT lt_students ASSIGNING FIELD-SYMBOL(<fs_students>).
  lv_soma_loop += <fs_students>-note.
ENDLOOP.
lv_media = lv_soma_loop / LINES( lt_students ).
WRITE: / `Média dos Alunos com Loop:`, lv_media.

CLEAR lv_media.

lv_soma_reduce = REDUCE i( INIT lv_soma TYPE i
                           FOR wa IN lt_students
                           NEXT lv_soma = lv_soma + wa-note ).
lv_media = lv_soma_reduce / LINES( lt_students ).
WRITE: / `Média dos Alunos com Reduce:`, lv_media.
