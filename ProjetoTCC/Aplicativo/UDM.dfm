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
    Params.Strings = (
      'Database=F:\Sistema\DATABASE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=10.0.0.100'
      'Port=3050'
      'Protocol=TCPIP'
      'DriverID=FB')
    LoginPrompt = False
    Left = 48
    Top = 16
  end
end
