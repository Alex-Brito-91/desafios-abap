*&---------------------------------------------------------------------*
*& Report z_filterrp
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT z_filterrp.

TYPE-POOLS: slis.
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
           st_sflight TYPE ty_sflight.

    DATA: it_fieldcat TYPE slis_t_fieldcat_alv,
          st_layout   TYPE slis_layout_alv.

    METHODS: select_data,
             alv_color,
             merge_alv,
             layout_alv,
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

        lv_percent = 0.
        CLEAR coltab.

      ENDLOOP.

    ENDMETHOD.

    METHOD merge_alv.

      CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
        EXPORTING
          i_program_name         = sy-repid
          i_structure_name       = 'ZST_SFLIGHT'

        CHANGING
          ct_fieldcat            = it_fieldcat
        EXCEPTIONS
          inconsistent_interface = 1
          program_error          = 2.

    ENDMETHOD.

    METHOD layout_alv.

      st_layout-zebra = 'X'.
      st_layout-colwidth_optimize = 'X'.
      st_layout-coltab_fieldname = 'COLOR'.

    ENDMETHOD.

    METHOD alv_display.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
          i_callback_program = sy-repid
          is_layout          = st_layout
          it_fieldcat        = it_fieldcat
        TABLES
          t_outtab           = it_sflight
        EXCEPTIONS
          program_error      = 1.

    ENDMETHOD.

    METHOD run.

      me->select_data( ).
      me->alv_color( ).
      me->merge_alv( ).
      me->layout_alv( ).
      me->alv_display( ).

    ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA(lo_alvcolor) = NEW alv_color( ).
  lo_alvcolor->run( ).
