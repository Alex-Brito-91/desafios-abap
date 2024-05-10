*&---------------------------------------------------------------------*
*& Report z_filterrp
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT z_filterrp.

TABLES: sflight.

CLASS alv_filters DEFINITION.

  PUBLIC SECTION.

    TYPES:  BEGIN OF ty_sflight.
              INCLUDE TYPE zst_sflight.
    TYPES:    color   TYPE lvc_t_scol,
            END OF ty_sflight.

    DATA: lv_carrid TYPE s_carr_id,
          lv_connid TYPE s_conn_id.

    DATA: it_sflight TYPE TABLE OF ty_sflight,
          st_sflight TYPE ty_sflight,
          lo_alv     TYPE REF TO cl_salv_table.

    METHODS: CONSTRUCTOR
              IMPORTING
                !iv_carrid TYPE s_carr_id
                !iv_connid TYPE s_conn_id,

             select_data,
             create_alv,
             rename_columns,
             color_alv,
             run.

ENDCLASS.

CLASS alv_filters IMPLEMENTATION.

  METHOD constructor.

    me->lv_carrid = iv_carrid.
    me->lv_connid = iv_connid.

  ENDMETHOD.

  METHOD select_data.

    SELECT carrid, connid, fldate, planetype, seatsmax, seatsocc
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE @it_sflight
    WHERE carrid EQ @lv_carrid
    AND connid EQ @lv_connid.

  ENDMETHOD.

  METHOD create_alv.

    TRY.

        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = lo_alv
          CHANGING
            t_table = it_sflight
        ).

      CATCH: cx_salv_msg.

    ENDTRY.

    DATA(lo_functions) = lo_alv->get_functions( ).
    lo_functions->set_all( ).

  ENDMETHOD.

  METHOD color_alv.

    LOOP AT it_sflight ASSIGNING FIELD-SYMBOL(<fs_sflight>).

      DATA(lv_percent) = ( <fs_sflight>-seatsocc * 100 ) / <fs_sflight>-seatsmax.

      IF lv_percent < 50.
        APPEND VALUE lvc_s_scol( fname = 'SEATSOCC' color = VALUE lvc_s_colo( col = 5 ) ) TO <fs_sflight>-color.
      ELSEIF lv_percent >= 50 AND lv_percent < 70.
        APPEND VALUE lvc_s_scol( fname = 'SEATSOCC' color = VALUE lvc_s_colo( col = 3 ) ) TO <fs_sflight>-color.
      ELSE.
        APPEND VALUE lvc_s_scol( fname = 'SEATSOCC' color = VALUE lvc_s_colo( col = 6 ) ) TO <fs_sflight>-color.
      ENDIF.

      MODIFY it_sflight FROM <fs_sflight>.

    ENDLOOP.

    TRY.
          lo_alv->get_columns( )->set_color_column( 'COLOR' ).
      CATCH cx_salv_data_error.
    ENDTRY.

  ENDMETHOD.

  METHOD rename_columns.

    DATA: lo_column TYPE REF TO cl_salv_column.
    DATA(lo_cols) = lo_alv->get_columns( ).

    TRY.

        lo_column ?= lo_cols->get_column( 'CARRID' ).
        lo_column->set_short_text( 'Linha' ).
        lo_column->set_medium_text( 'Linha Aérea' ).
        lo_column->set_long_text( 'Linha Aérea' ).
        lo_column->set_output_length( 5 ).

        lo_column ?= lo_cols->get_column( 'CONNID' ).
        lo_column->set_short_text( 'Número' ).
        lo_column->set_medium_text( 'Núm. do Vôo' ).
        lo_column->set_long_text( 'Núm. do Vôo' ).
        lo_column->set_output_length( 6 ).

        lo_column ?= lo_cols->get_column( 'FLDATE' ).
        lo_column->set_short_text( 'Data' ).
        lo_column->set_medium_text( 'Data Vôo' ).
        lo_column->set_long_text( 'Data do Vôo' ).
        lo_column->set_output_length( 9 ).

        lo_column ?= lo_cols->get_column( 'PLANETYPE' ).
        lo_column->set_short_text( 'Modelo' ).
        lo_column->set_medium_text( 'Modelo' ).
        lo_column->set_long_text( 'Modelo' ).
        lo_column->set_output_length( 7 ).

        lo_column ?= lo_cols->get_column( 'SEATSMAX' ).
        lo_column->set_short_text( 'Assentos' ).
        lo_column->set_medium_text( 'Capac. Assentos' ).
        lo_column->set_long_text( 'Capacidade Máx. Assentos' ).
        lo_column->set_output_length( 8 ).

        lo_column ?= lo_cols->get_column( 'SEATSOCC' ).
        lo_column->set_short_text( 'Ocupados' ).
        lo_column->set_medium_text( 'Ass. Ocupados' ).
        lo_column->set_long_text( 'Assentos Ocupados' ).
        lo_column->set_output_length( 8 ).

      CATCH cx_salv_not_found.

    ENDTRY.

  ENDMETHOD.

  METHOD run.

    me->select_data( ).
    me->create_alv( ).
    me->color_alv( ).
    me->rename_columns( ).
    me->lo_alv->display( ).

  ENDMETHOD.

ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS:     p_carrid TYPE sflight-carrid.
  SELECT-OPTIONS: s_connid FOR sflight-connid NO INTERVALS.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  DATA(lo_alv_filter) = NEW alv_filters( iv_carrid = p_carrid iv_connid = s_connid-low ).
  lo_alv_filter->run( ).
