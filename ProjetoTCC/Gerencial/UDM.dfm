object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 284
  Width = 358
  object Conn: TFDConnection
    Params.Strings = (
      'Database=F:\Sistema\DATABASE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=10.0.0.100'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = Transaction
    Left = 32
    Top = 24
  end
  object Transaction: TFDTransaction
    Connection = Conn
    Left = 128
    Top = 16
  end
  object QryAux: TFDQuery
    Connection = Conn
    Transaction = Transaction
    UpdateTransaction = Transaction
    Left = 32
    Top = 88
  end
  object QryPesGeral: TFDQuery
    Connection = Conn
    Left = 128
    Top = 88
  end
end
