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

TYPES: BEGIN OF ty_zovcab_b.
         INCLUDE TYPE ty_zovcab.
         TYPES: nomecliente TYPE char30, "acrescentando campo nome cliente na tabela interna
       END OF ty_zovcab_b.

TYPES: BEGIN OF ty_zovcab_a.
         INCLUDE TYPE zovcab.
         TYPES: cidade TYPE char18, "acrescentando campo cidade na tabela interna
         estado TYPE char2,  "acrescentando campo estado na tabela interna
       END OF ty_zovcab_a.

DATA: it_zovcab_custom TYPE ty_zovcab_a OCCURS 0 WITH HEADER LINE, "tabela interna adicionado campos novos.
      it_zovcab_b      TYPE ty_zovcab_b OCCURS 0 WITH HEADER LINE. "tabela interna adicionado campo novo.

DATA: it_zovcab     TYPE ty_zovcab OCCURS 0 WITH HEADER LINE,
      wa_zovcab     TYPE ty_zovcab,
      it_zovcab_aux TYPE STANDARD TABLE OF zovcab WITH HEADER LINE, "declaração de types para ver se é a mesma coisa
      wa_zovcab_aux TYPE zovcab. "declaração de types para ver se é a mesma coisa

ranges: r_ordem for zovcab-ordemid.

* declaração de parametros
PARAMETERS: p_ordem TYPE zovcab-ordemid.
SELECT-OPTIONS: s_ordem FOR zovcab-ordemid.

START-OF-SELECTION.
  PERFORM find_dados USING p_ordem.
  PERFORM find_tt_dados.
  PERFORM find_ordem USING p_ordem.
  PERFORM list_dados.

*&---------------------------------------------------------------------*
*& Form FIND_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> VR_ORDEM
*&---------------------------------------------------------------------*
FORM find_dados USING p_vr_ordem. " s_vr_ordem type ty_ordemid. "como passar um intervalo de dados como parâmetro
  SELECT mandt ordemid criacao_data criacao_hora criacao_usuario clienteid totalitens totalfrete totalordem status
    FROM zovcab
    INTO TABLE it_zovcab
    WHERE ordemid IN s_ordem.

  SELECT *
    FROM zovcab
    INTO TABLE @it_zovcab_aux
    WHERE ordemid EQ @p_vr_ordem.
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

*& nessa tabela interna "it_zovcab_custom" foi adicionado um campo novo chamado cidade.
*&---------------------------------------------------------------------*
*& Form FIND_ORDEM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_ORDEM
*&---------------------------------------------------------------------*
FORM find_ordem USING p_p_ordem.
  SELECT *
    FROM zovcab
    INTO TABLE @it_zovcab_custom
    WHERE ordemid EQ @p_p_ordem.

  SELECT *
    FROM zovcab
    INTO TABLE @it_zovcab_b
    WHERE ordemid EQ @p_p_ordem.
ENDFORM.


*&---------------------------------------------------------------------*
*& Form LIST_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM list_dados .
  LOOP AT it_zovcab INTO wa_zovcab.
    WRITE:/'----------------------------------------',
          /'ordemid: ', wa_zovcab-ordemid LEFT-JUSTIFIED,
          /'data: ', wa_zovcab-criacao_data DD/MM/YYYY,
          /'hora: ', wa_zovcab-criacao_hora ENVIRONMENT TIME FORMAT,
          /'usuario: ', wa_zovcab-criacao_usuario LEFT-JUSTIFIED,
          /'clienteid: ', wa_zovcab-clienteid LEFT-JUSTIFIED,
          /'totalitens: ', wa_zovcab-totalitens LEFT-JUSTIFIED,
          /'totalfrete: ', wa_zovcab-totalfrete LEFT-JUSTIFIED,
          /'totalordem: ', wa_zovcab-totalordem LEFT-JUSTIFIED,
          /'status: ', wa_zovcab-status.
  ENDLOOP.

ENDFORM.
