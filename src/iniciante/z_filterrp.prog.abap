*&---------------------------------------------------------------------*
*& Report z_filterrp
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_filterrp.

TABLES: sflight.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS:     p_carrid TYPE sflight-carrid.
  SELECT-OPTIONS: s_connid FOR  sflight-connid.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_filter_sflight DEFINITION.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_sflight,
             t_carrid    TYPE sflight-carrid,
             t_connid    TYPE sflight-connid,
             t_fldate    TYPE sflight-fldate,
             t_planetype TYPE sflight-planetype,
             t_seatmax   TYPE sflight-seatsmax,
             t_seatsocc  TYPE sflight-seatsocc,
           END OF ty_sflight.

    DATA: lt_voos TYPE TABLE OF ty_sflight.

    METHODS: get_voos,
             display_alv,
             run.

ENDCLASS.

CLASS lcl_filter_sflight IMPLEMENTATION.

  METHOD get_voos.

    SELECT carrid, connid, fldate, planetype, seatsmax, seatsocc
      FROM sflight
      INTO TABLE @lt_voos
      WHERE carrid EQ @p_carrid
        AND connid IN @s_connid.

  ENDMETHOD.

  METHOD display_alv.

    cl_salv_table=>factory(
      IMPORTING
        r_salv_table = DATA(lo_alv)
      CHANGING
        t_table = lt_voos
    ).
    DATA(lo_function) = lo_alv->get_functions( ).
    lo_function->set_all( ).
    lo_alv->display( ).

  ENDMETHOD.

  METHOD run.

    me->get_voos( ).
    me->display_alv( ).

  ENDMETHOD.

ENDCLASS.

INITIALIZATION.
  DATA(lo_filter_sflight) = NEW lcl_filter_sflight( ).

START-OF-SELECTION.
  lo_filter_sflight->run( ).
