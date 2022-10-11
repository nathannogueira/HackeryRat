object FrmCriarServidor: TFrmCriarServidor
  Left = 539
  Top = 275
  Caption = 'Criar Servidor'
  ClientHeight = 147
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object EdtIP: TsEdit
    Left = 81
    Top = 29
    Width = 241
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'IP Reverso:'
    BoundLabel.Font.Charset = ANSI_CHARSET
    BoundLabel.Font.Color = clGray
    BoundLabel.Font.Height = -12
    BoundLabel.Font.Name = 'Comic Sans MS'
    BoundLabel.Font.Style = []
  end
  object sButton2: TsButton
    Left = 84
    Top = 95
    Width = 75
    Height = 25
    Caption = 'Salvar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = sButton2Click
    SkinData.SkinSection = 'BUTTON'
  end
  object sButton3: TsButton
    Left = 180
    Top = 95
    Width = 75
    Height = 25
    Caption = 'Sair'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = sButton3Click
    SkinData.SkinSection = 'BUTTON'
  end
  object EdtApelido: TsEdit
    Left = 81
    Top = 59
    Width = 241
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Apelido:'
    BoundLabel.Font.Charset = ANSI_CHARSET
    BoundLabel.Font.Color = clGray
    BoundLabel.Font.Height = -12
    BoundLabel.Font.Name = 'Comic Sans MS'
    BoundLabel.Font.Style = []
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.exe'
    Filter = 'SERVIDOR|*.exe'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 336
    Top = 25
  end
end
