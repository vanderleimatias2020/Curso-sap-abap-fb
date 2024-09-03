*&---------------------------------------------------------------------*
*& Include          SAPMZSD_CLIENTE_E01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module PBO_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

MODULE pbo_9000 OUTPUT.
  SET PF-STATUS 'S9000'.
  clear: gd_okcode.


  IF sy-tcode = 'ZSD001'.
    SET TITLEBAR 'NEW'.
  ENDIF.

  IF sy-tcode = 'ZSD002'.
    SET TITLEBAR 'EDIT'.

    LOOP AT SCREEN.
      IF screen-name = 'GS_CLIENTE-ZCLINR'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PAI_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9000 INPUT.
  CASE gd_okcode.
    WHEN 'BACK'.
      LEAVE.
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
      IF sy-tcode = 'ZSD001'.
        PERFORM inserir.
      ENDIF.
      IF sy-tcode = 'ZSD002'.
        PERFORM modificar.
      ENDIF.
  ENDCASE.
ENDMODULE.
