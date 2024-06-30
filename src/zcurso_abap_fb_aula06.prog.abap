*&---------------------------------------------------------------------*
*& Report ZCURSO_ABAP_FB_AULA06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcurso_abap_fb_aula06.

TABLES: zovcab, zovitem.

TYPES:
  BEGIN OF ty_zovcab,
    mandt           TYPE zovcab-mandt,
    ordemid         TYPE zovcab-ordemid,
    criacao_data    TYPE zovcab-criacao_data,
    criacao_hora    TYPE zovcab-criacao_hora,
    criacao_usuario TYPE zovcab-criacao_usuario,
    clienteid       TYPE zovcab-clienteid,
    totalitens      TYPE zovcab-totalitens,
    totalfrete      TYPE zovcab-totalfrete,
    totalordem      TYPE zovcab-totalordem,
    status          TYPE zovcab-status,
  END OF ty_zovcab,

  BEGIN OF ty_zovitem,
    mandt      TYPE zovitem-mandt,
    ordemid    TYPE zovitem-ordemid,
    itemid     TYPE zovitem-itemid,
    material   TYPE zovitem-material,
    descricao  TYPE zovitem-descricao,
    quantidade TYPE zovitem-quantidade,
    precouni   TYPE zovitem-precouni,
    precotot   TYPE zovitem-precotot,
  END OF ty_zovitem.


DATA: it_zovcab     TYPE ty_zovcab OCCURS 0 WITH HEADER LINE,
      wa_zovcab     TYPE ty_zovcab,
      it_zovcab_aux TYPE STANDARD TABLE OF zovcab WITH HEADER LINE, "declaração de types para ver se é a mesma coisa
      wa_zovcab_aux TYPE zovcab. "declaração de types para ver se é a mesma coisa

* declaração de parametros
PARAMETERS: p_ordem TYPE zovcab-ordemid.


START-OF-SELECTION.
  PERFORM find_dados USING p_ordem.
  "PERFORM find_tt_dados.


*&---------------------------------------------------------------------*
*& Form FIND_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> VR_ORDEM
*&---------------------------------------------------------------------*
FORM find_dados USING p_vr_ordem.
  SELECT mandt ordemid criacao_data criacao_hora criacao_usuario clienteid totalitens totalfrete totalordem status
    FROM zovcab
    INTO TABLE it_zovcab
    WHERE ordemid EQ p_vr_ordem.

  SELECT *
    FROM zovcab
    INTO TABLE @it_zovcab_aux
    WHERE ordemid EQ @p_vr_ordem.
  BREAK-POINT.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form FIND_TT_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM find_tt_dados .
  SELECT *
    FROM zovcab
    INTO TABLE @it_zovcab_aux.
ENDFORM.
