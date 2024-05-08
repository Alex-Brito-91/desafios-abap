*&---------------------------------------------------------------------*
*& Report z_filterrp
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT z_filterrp.

TABLES: sflight.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS:     p_carrid TYPE sflight-carrid.
  SELECT-OPTIONS: s_connid FOR sflight-connid.
SELECTION-SCREEN END OF BLOCK b1.

CLASS alv_color DEFINITION.

  PUBLIC SECTION.

    TYPES:  BEGIN OF ty_sflight.
              INCLUDE TYPE zst_sflight.
    TYPES:    color   TYPE lvc_t_scol,
            END OF ty_sflight.

    DATA:  it_sflight TYPE TABLE OF ty_sflight,
           st_sflight TYPE ty_sflight,

           lo_alv     TYPE REF TO cl_salv_table,
           lo_columns TYPE REF TO cl_salv_columns_table,
           lo_col     TYPE REF TO cl_salv_column_list.

    METHODS: select_data,
             alv_color,
             alv_display,
             run.

ENDCLASS.

CLASS alv_color IMPLEMENTATION.

  METHOD select_data.

    SELECT carrid, connid, fldate, planetype, seatsmax, seatsocc
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE @it_sflight
    WHERE carrid EQ @p_carrid
    AND connid IN @s_connid.

  ENDMETHOD.

  METHOD alv_color.

    DATA: col    TYPE lvc_s_scol,
          coltab TYPE lvc_t_scol.

    DATA(c_red)     = VALUE lvc_s_colo( col = 6 int = 0 inv = 0 ).
    DATA(c_yellow)  = VALUE lvc_s_colo( col = 3 int = 0 inv = 0 ).
    DATA(c_green)   = VALUE lvc_s_colo( col = 5 int = 0 inv = 0 ).

    LOOP AT it_sflight ASSIGNING FIELD-SYMBOL(<fs_sflight>).

      DATA(lv_percent) = ( <fs_sflight>-seatsocc * 100 ) / <fs_sflight>-seatsmax.

      IF lv_percent < 50.
        col-fname = 'SEATSOCC'.
        col-color = c_green.
        APPEND col TO coltab.
        CLEAR col.
      ELSEIF lv_percent >= 50 AND lv_percent < 70.
        col-fname = 'SEATSOCC'.
        col-color = c_yellow.
        APPEND col TO coltab.
        CLEAR col.
      ELSE.
        col-fname = 'SEATSOCC'.
        col-color = c_red.
        APPEND col TO coltab.
        CLEAR col.
      ENDIF.

      <fs_sflight>-color = coltab.
      MODIFY it_sflight FROM <fs_sflight>.

      CLEAR lv_percent.
      CLEAR coltab.

    ENDLOOP.

  ENDMETHOD.

  METHOD alv_display.

    CALL METHOD cl_salv_table=>factory
     IMPORTING
      r_salv_table = lo_alv
     CHANGING
    t_table = it_sflight.

    lo_columns = lo_alv->get_columns( ).
    lo_col ?= lo_columns->get_column( 'SEATSOCC' ).
    lo_columns->set_color_column( 'COLOR' ).

    lo_alv->display( ).

  ENDMETHOD.

  METHOD run.

    me->select_data( ).
    me->alv_color( ).
    me->alv_display( ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA(lo_alvcolor) = NEW alv_color( ).
  lo_alvcolor->run( ).
