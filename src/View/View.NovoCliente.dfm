object FrameNovoCliente: TFrameNovoCliente
  Left = 0
  Top = 0
  Width = 461
  Height = 94
  TabOrder = 0
  PixelsPerInch = 96
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 94
    Align = alClient
    BevelOuter = bvNone
    Color = 15263976
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 494
    ExplicitHeight = 107
    object edtNomeCliente: TEdit
      Left = 8
      Top = 51
      Width = 329
      Height = 23
      Hint = 'Informe o nome  ou uma descri'#231#227'o do cliente'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = 'Nome'
      OnKeyDown = edtNomeClienteKeyDown
    end
    object btnSalvar: TButton
      Left = 343
      Top = 50
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = btnSalvarClick
    end
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 461
      Height = 36
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Novo Cliente'
      TabOrder = 2
      ExplicitWidth = 494
      object imgFechar: TImage
        Left = 416
        Top = 0
        Width = 45
        Height = 35
        Cursor = crHandPoint
        Align = alRight
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
          0020080300000044A48AC60000000467414D410000B18F0BFC61050000000173
          52474200AECE1CE900000132504C5445000000C93636C53A3AC73838CA3535C8
          3636C83737C93636C93636C93636C93636C93636C93636C93636C93636C93636
          C83737C93636C93636C93636C93636C93636C93636C93636C93636C93636C936
          36C93636C93636C93636C93636C93636C93636C93636C93636C93636C93636C9
          3636C93636C93636C93636C93636C93636C93636C93636C93636C83737C93636
          C93636C93636C93636C93636C93636C93636C93636C93636C93636C93636C936
          36C93636C93636C93636C93535CA3B3BCD4747CE4949CB3C3CCA3939E39898F2
          D0D0D35C5CC83333D35D5DF3D2D2E59D9DFDF7F7FFFFFFF4D8D8F5D8D8FDF9F9
          E59C9CCE4747F2CFCFF4D7D7F1CDCDF4D5D5D35A5AD35B5BF4D6D6F6DDDDF6DE
          DEF6DCDCF3D1D1CE4A4AE49B9BFDF8F8FEFBFBE5A0A0CB3E3EF2CDCDE59F9FCB
          3D3DEE5E47730000003D74524E5300000000000000032A72ADD5F4F3AE2B0339
          98DFFC381A8AEAE91935C1FEBF3246D8D6421BC0023A93DE6BA5F2D402E83785
          BEBDD33F34318694A6A76C87BC503000000001624B47444CF76F10F300000009
          704859730000009D0000009D018F72E76E000001DB4944415478DA6D935B4F22
          411085EBD00C8383049215E38588715D12D6C428C647FF7FB2D9188D0FC46B5C
          B22B24CC2A030A884CB7D5333D17C07AE9749D2F75EB2E9031E4A0ED982EA4F8
          C8C153913F921D561BC6D9524A0CA62A0132AA02FCA0B4DD49D1C9F806C8621D
          D8A5797B04DAD6340040355469D9FEE141CC58056DE5B40E951283CB79F929E3
          33F01D1BEC0164424060C6B7AEBA575C9C57678FA57B1C195D77F4A698B829DD
          02758FEBCF5836F06E0847E5A5C0E0837B99B9A8BB071CE01BB8607B18105A27
          CABB3A654FA294FDA993E66DBE0631427D055D5D92FB849542230C6B0832BA17
          A46BADC339A13831130E8DF958959E29F8198526A589220D5957FDA8A173148F
          688E60B3B3B14E17384BC6E794C5808FA2EF8D12E75780ECA7812F52C413637B
          592CB244DE1CD15F68D3E6577A4F13CFC9A0B4CEFD912AA6081E9419B59393A6
          7FC7101333EAC3BFFAB1C4763F9E6F48F86B7FC2C74239BF4F6455F13F9A7F40
          AC01778A06B88C3E0C6AD6309E8FA3C436AE39C0AB7FC55FAE522D309195735F
          6E5FEBA34E47819762C76D2E7D5AE2DBB8D726157CFBBD6E93966D8CDF8C058B
          E39FBE6C2CCA8F15EB970E8330E0F2EAD5DA1DAD27CBDB98F452CB5B1FB7D2CB
          1B22D82B5FEAF5AF6CE26A328D4AFE0417EDDE24036C43C30000002574455874
          646174653A63726561746500323031372D30322D30385430393A33363A32372B
          30313A30303450BA090000002574455874646174653A6D6F6469667900323031
          372D30322D30385430393A33363A32372B30313A3030450D02B5000000467445
          5874736F66747761726500496D6167654D616769636B20362E372E382D392032
          3031362D30362D31362051313620687474703A2F2F7777772E696D6167656D61
          6769636B2E6F7267E6BF34B600000018744558745468756D623A3A446F63756D
          656E743A3A50616765730031A7FFBB2F00000018744558745468756D623A3A49
          6D6167653A3A68656967687400353132C0D0505100000017744558745468756D
          623A3A496D6167653A3A5769647468003531321C7C03DC000000197445587454
          68756D623A3A4D696D657479706500696D6167652F706E673FB2564E00000017
          744558745468756D623A3A4D54696D650031343836353432393837CAE4A2B600
          000011744558745468756D623A3A53697A650031394B4242A6611F8F0000004F
          744558745468756D623A3A5552490066696C653A2F2F2E2F75706C6F6164732F
          6361726C6F7370726576692F4244314E4446422F313135342F31343836353634
          3339392D636C6F73655F38313531322E706E67FEB5973B0000000049454E44AE
          426082}
        OnClick = imgFecharClick
        ExplicitLeft = 448
        ExplicitTop = 1
        ExplicitHeight = 34
      end
      object Panel1: TPanel
        Left = 0
        Top = 35
        Width = 461
        Height = 1
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        ExplicitTop = 34
      end
    end
  end
end
