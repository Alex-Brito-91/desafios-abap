*&---------------------------------------------------------------------*
*& Report z_formatar_cpf
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_formatar_cpf.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_cpf TYPE char14.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

DATA: cpf_formatado_cf TYPE char14,
      cpf_formatado_em TYPE char14.

CALL FUNCTION 'CONVERSION_EXIT_CPFBR_OUTPUT'

  EXPORTING
    input  = p_cpf
  IMPORTING
    output = cpf_formatado_cf.

WRITE: / `CPF Formatado com Call Function:`, cpf_formatado_cf.
WRITE: p_cpf USING EDIT MASK '___.___.___-__' TO cpf_formatado_em.
WRITE: / `CPF Formatado com Edit Mask:`, cpf_formatado_em.
