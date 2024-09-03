*&---------------------------------------------------------------------*
*& Include          SAPMZSD_CLIENTE_E02
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module PAI_9001 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

MODULE pai_9001 OUTPUT.
  CLEAR gd_okcode.
  SET PF-STATUS 'S9001'.

  IF sy-tcode = 'ZSD002'.
    SET TITLEBAR 'MOD'.
  ENDIF.

  IF sy-tcode = 'ZSD003'.
    SET TITLEBAR 'DEL'.
  ENDIF.

ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  PAI_9001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9001 INPUT.
  CASE gd_okcode.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
    WHEN 'EXEC' OR ''.
      IF sy-tcode = 'ZSD002'.
        PERFORM modificar_cliente.
      ENDIF.

      IF sy-tcode = 'ZSD003'.
        PERFORM excluir_cliente.
      ENDIF.
  ENDCASE.
ENDMODULE.
