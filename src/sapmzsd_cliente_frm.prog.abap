*&---------------------------------------------------------------------*
*& Include          SAPMZSD_CLIENTE_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form SALVAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM modificar_cliente.
  SELECT SINGLE *
  INTO gs_cliente
  FROM  zsd_cliente
  WHERE zclinr = gd_zclinr.

  IF sy-subrc <> 0.
    MESSAGE |O cliente { gd_zclinr } não existe| TYPE 'E'.
    EXIT.
  ENDIF.

  CALL SCREEN 9000.

ENDFORM.

FORM modificar.
  MODIFY zsd_cliente FROM gs_cliente.
  IF sy-subrc EQ 0.
    MESSAGE 'Cliente atualizado com sucesso' TYPE 'S'.
  ELSE.
    MESSAGE 'Erro ao atualizar cliente' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.

FORM inserir .
  gs_cliente-erdat = sy-datum.
  gs_cliente-erzet = sy-uzeit.

  INSERT zsd_cliente FROM gs_cliente.
  IF sy-subrc EQ 0.
    MESSAGE 'Cliente cadastrado com sucesso' TYPE 'S'.
  ELSE.
    MESSAGE 'Erro ao cadastrar cliente' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form EXCLUIR_CLIENTE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM excluir_cliente.
  SELECT SINGLE *
    INTO gs_cliente
    FROM zsd_cliente
    WHERE zclinr = gd_zclinr.
  IF sy-subrc <> 0.
    MESSAGE |O cliente { gd_zclinr } não existe| TYPE 'S' DISPLAY LIKE 'E'.
    EXIT. "sair se o cliente não for encontrado
  ENDIF.

  DELETE FROM zsd_cliente WHERE zclinr = gd_zclinr.
  IF sy-subrc EQ 0.
    MESSAGE 'Cliente excluído com sucesso' TYPE 'S'.
  ELSE.
    MESSAGE 'Erro ao excluir cliente' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
