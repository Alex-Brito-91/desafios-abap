*&---------------------------------------------------------------------*
*& Report z_calculadora_avancada
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_calculadora_avancada.

CLASS lcl_calc DEFINITION.

  PUBLIC SECTION.

    DATA: num1        TYPE p DECIMALS 2,
          num2        TYPE p DECIMALS 2,
          resultado   TYPE p DECIMALS 2,
          operador_s  TYPE c,
          operador_a  TYPE c.

    METHODS: CONSTRUCTOR
              IMPORTING
                !iv_num1       TYPE p
                !iv_num2       TYPE p
                !iv_operador_s TYPE c
                !iv_operador_a TYPE c,

             calculo_simples,
             calculo_avancado,
             run.

ENDCLASS.

CLASS lcl_calc IMPLEMENTATION.

  METHOD constructor.

    me->num1       = iv_num1.
    me->num2       = iv_num2.
    me->operador_s = iv_operador_s.
    me->operador_a = iv_operador_a.

  ENDMETHOD.

  METHOD calculo_simples.

    IF num1 IS NOT INITIAL AND num2 IS NOT INITIAL.
      CASE operador_s.
      WHEN '1'.
        resultado = num1 + num2.
      WHEN '2'.
        resultado = num1 - num2.
      WHEN '3'.
        resultado = num1 * num2.
      WHEN '4'.
        IF num2 EQ 0.
          WRITE: 'Divisão por zero não é permitida'.
          EXIT.
        ELSE.
          resultado = num1 / num2.
        ENDIF.
    ENDCASE.
    ELSE.
      WRITE: 'Insira dois valores para o cálculo ser realizado!'.
      EXIT.
    ENDIF.

    WRITE: / 'Resultado:', resultado.

  ENDMETHOD.

  METHOD calculo_avancado.

    IF num2 EQ 0.
      CASE operador_a.
        WHEN '1'.
          resultado = SIN( num1 ).
        WHEN '2'.
          resultado = COS( num1 ).
        WHEN '3'.
          resultado = TAN( num1 ).
        WHEN '4'.
          resultado = LOG( num1 ).
        WHEN '5'.
          resultado = SQRT( num1 ).
      ENDCASE.
    ELSE.
      WRITE: 'Para este tipo de operação insira apenas no Valor 1'.
      EXIT.
    ENDIF.

    WRITE: / 'Resultado:', resultado.

  ENDMETHOD.

  METHOD run.

    IF operador_s IS NOT INITIAL AND operador_a EQ 0.
      me->calculo_simples( ).
    ELSEIF operador_a IS NOT INITIAL AND operador_s EQ 0.
      me->calculo_avancado( ).
    ELSE.
      WRITE: 'Escolha apenas uma operação!'.
      EXIT.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_num1 TYPE p DECIMALS 2,
              l_oper_s AS LISTBOX VISIBLE LENGTH 5 MODIF ID ops,
              l_oper_a AS LISTBOX VISIBLE LENGTH 5 MODIF ID opa,
              p_num2 TYPE p DECIMALS 2.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN OUTPUT.

  DATA(lt_oper_s) = VALUE vrm_values(
        ( key = '1' text = '+' )
        ( key = '2' text = '-' )
        ( key = '3' text = 'x' )
        ( key = '4' text = '÷' )
    ).

    CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'L_OPER_S'
      values          = lt_oper_s
    EXCEPTIONS
      id_illegal_name = 1
      others          = 2.


  DATA(lt_oper_a) = VALUE vrm_values(
      ( key = '1' text = 'sin' )
      ( key = '2' text = 'cos' )
      ( key = '3' text = 'tan' )
      ( key = '4' text = 'log' )
      ( key = '5' text = '√' )
    ).

    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING
        id              = 'L_OPER_A'
        values          = lt_oper_a
      EXCEPTIONS
        id_illegal_name = 1
        others          = 2.

START-OF-SELECTION.

  DATA: lo_calc TYPE REF TO lcl_calc.

  CREATE OBJECT lo_calc
    EXPORTING
      iv_num1       = p_num1
      iv_num2       = p_num2
      iv_operador_s = l_oper_s
      iv_operador_a = l_oper_a.

  lo_calc->run( ).
