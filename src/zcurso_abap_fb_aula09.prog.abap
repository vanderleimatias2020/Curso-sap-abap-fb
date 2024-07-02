*&---------------------------------------------------------------------*
*& Report ZCURSO_ABAP_FB_AULA09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcurso_abap_fb_aula09.

TABLES: ztmmuser00_ex04.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
PARAMETERS: p_matri TYPE  ztmmuser00_ex04-matricula,
            p_nome  TYPE  ztmmuser00_ex04-nome,
            p_data  TYPE  ztmmuser00_ex04-datanascimento,
            p_rg    TYPE  ztmmuser00_ex04-rg,
            p_cpf   TYPE  ztmmuser00_ex04-cpf,
            p_sexo  TYPE  ztmmuser00_ex04-sexo.
SELECTION-SCREEN END OF BLOCK b1.

" criando tabela interna
DATA: it_ztmmuser00_ex04 TYPE STANDARD TABLE OF ztmmuser00_ex04 WITH HEADER LINE,
      wa_ztmmuser00_ex04 TYPE ztmmuser00_ex04.


START-OF-SELECTION.
  PERFORM grava_tabela.


*&---------------------------------------------------------------------*
*& Form GRAVA_TABELA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM grava_tabela .
  wa_ztmmuser00_ex04-matricula      = p_matri.
  wa_ztmmuser00_ex04-nome           = p_nome.
  wa_ztmmuser00_ex04-datanascimento = p_data.
  wa_ztmmuser00_ex04-rg             = p_rg.
  wa_ztmmuser00_ex04-cpf            = p_cpf.
  wa_ztmmuser00_ex04-sexo           = p_sexo.
  "APPEND wa_ztmmuser00_ex04.

  MOVE:
  wa_ztmmuser00_ex04-matricula      TO ztmmuser00_ex04-matricula,
  wa_ztmmuser00_ex04-nome           TO ztmmuser00_ex04-nome,
  wa_ztmmuser00_ex04-datanascimento TO ztmmuser00_ex04-datanascimento,
  wa_ztmmuser00_ex04-rg             TO ztmmuser00_ex04-rg,
  wa_ztmmuser00_ex04-cpf            TO ztmmuser00_ex04-cpf,
  wa_ztmmuser00_ex04-sexo           TO ztmmuser00_ex04-sexo.
  INSERT ztmmuser00_ex04.

  IF sy-subrc EQ 0.
    COMMIT WORK.
    WRITE 'Gravado na tabela com sucesso!'.
  ENDIF.
ENDFORM.
