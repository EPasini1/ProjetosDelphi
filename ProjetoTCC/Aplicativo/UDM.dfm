object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 311
  Width = 349
  object QryAux: TFDQuery
    Connection = Conn
    Left = 40
    Top = 80
  end
  object Conn: TFDConnection
    Left = 48
    Top = 16
  end
end
