*&---------------------------------------------------------------------*
*& Include          ZREPORT_CLIENTE_FRM
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Form CONSULTAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM consultar .
  SELECT *
  INTO TABLE gt_cliente
  FROM zsd_cliente UP TO p_limit ROWS
  WHERE zclinr       IN s_zclinr[]
  AND erdat          IN s_erdat[]
  AND erzet          IN s_erzet[]
  AND nome           IN s_nome[]
  AND email          IN s_email[]
  AND limite_credito IN s_lcred[]
  AND status         IN s_status[].
ENDFORM.

*&---------------------------------------------------------------------*
*& Form SHOW_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM show_alv .
  DATA: ls_fieldcat TYPE slis_fieldcat_alv,
        lt_fieldcat TYPE STANDARD TABLE OF slis_fieldcat_alv.

  CLEAR lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ZCLINR'.
  ls_fieldcat-seltext_m = 'Cód. Cliente'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ERDAT'.
  ls_fieldcat-seltext_m = 'Data Criação'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ERZET'.
  ls_fieldcat-seltext_m = 'Hora Criação'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'NOME'.
  ls_fieldcat-seltext_m = 'Nome'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'EMAIL'.
  ls_fieldcat-seltext_m = 'E-mail'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'LIMITE_CREDITO'.
  ls_fieldcat-seltext_m = 'Limite'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'STATUS'.
  ls_fieldcat-seltext_m = 'Status'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK        = ' '
*     I_BYPASSING_BUFFER       = ' '
*     I_BUFFER_ACTIVE          = ' '
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SET_PF_STATUS'
      i_callback_user_command  = 'HANDLE_ALV_EVENT'
*     I_CALLBACK_TOP_OF_PAGE   = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME         =
*     I_BACKGROUND_ID          = ' '
      i_grid_title             = 'Relatório de Cliente'
*     I_GRID_SETTINGS          =
*     IS_LAYOUT                =
      it_fieldcat              = lt_fieldcat
*     IT_EXCLUDING             =
*     IT_SPECIAL_GROUPS        =
*     IT_SORT                  =
*     IT_FILTER                =
*     IS_SEL_HIDE              =
*     I_DEFAULT                = 'X'
      i_save                   = 'X'
*     IS_VARIANT               =
*     IT_EVENTS                =
*     IT_EVENT_EXIT            =
*     IS_PRINT                 =
*     IS_REPREP_ID             =
*     I_SCREEN_START_COLUMN    = 0
*     I_SCREEN_START_LINE      = 0
*     I_SCREEN_END_COLUMN      = 0
*     I_SCREEN_END_LINE        = 0
*     I_HTML_HEIGHT_TOP        = 0
*     I_HTML_HEIGHT_END        = 0
*     IT_ALV_GRAPHICS          =
*     IT_HYPERLINK             =
*     IT_ADD_FIELDCAT          =
*     IT_EXCEPT_QINFO          =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER  =
*     ES_EXIT_CAUSED_BY_USER   =
    TABLES
      t_outtab                 = gt_cliente
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.


FORM set_pf_status USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STANDARD'.
ENDFORM.


FORM handle_alv_event USING ucomm    TYPE sy-ucomm
                            selfield TYPE slis_selfield.

  DATA: ld_field TYPE char10.

  READ TABLE gt_cliente INTO gs_cliente INDEX selfield-tabindex.
  ld_field = gs_cliente-zclinr.
  CONDENSE ld_field NO-GAPS.

  SET PARAMETER ID 'ZCLINR' FIELD ld_field.


  CASE ucomm.
    WHEN 'CREATE'.
      CALL TRANSACTION 'ZSD001'.
    WHEN 'EDIT'.
      CALL TRANSACTION 'ZSD002' AND SKIP FIRST SCREEN.
    WHEN 'DELETE'.
      CALL TRANSACTION 'ZSD003'.
  ENDCASE.

  PERFORM consultar. "carrega os cliente novamente
  selfield-refresh = 'X'. "atualiza a tela.

ENDFORM.
