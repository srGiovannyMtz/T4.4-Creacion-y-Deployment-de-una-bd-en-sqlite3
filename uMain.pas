unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.Controls, FMX.StdCtrls, FMX.Layouts, Fmx.Bind.Navigator,
  FMX.DateTimeCtrls, FMX.EditBox, FMX.SpinBox, FMX.Edit,
  FMX.Controls.Presentation, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TfrmMain = class(TForm)
    ToolBar1: TToolBar;
    btnOpenDB: TButton;
    pnlData: TPanel;
    edtNoControl: TEdit;
    edtNombre: TEdit;
    rdbM: TRadioButton;
    rdbF: TRadioButton;
    spnEdad: TSpinBox;
    dtmFecha: TDateEdit;
    BindNavigator1: TBindNavigator;
    StatusBar1: TStatusBar;
    lblStatus: TLabel;
    db: TFDConnection;
    tblAlumno: TFDTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkPropertyToFieldIsChecked: TLinkPropertyToField;
    LinkPropertyToFieldIsChecked2: TLinkPropertyToField;
    LinkPropertyToFieldDate: TLinkPropertyToField;
    procedure FormCreate(Sender: TObject);
    procedure btnOpenDBClick(Sender: TObject);
    procedure rdbMClick(Sender: TObject);
    procedure rdbFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses

  System.IOUtils // Para hacer uso de TPath.
    ;

var
  dbFileName: String;
  bndDECorCON: boolean; // Se usa esta variable para determinar si esta conectado o no a la DB

procedure TfrmMain.btnOpenDBClick(Sender: TObject);
begin

  if not(bndDECorCON) then //

  begin
    // intentar abrir la bd
    try
      DB.Connected := true;
      lblStatus.Text := 'db ON';
      pnlData.Enabled := true;
      tblAlumno.Active := true;
      bndDECorCON := true;
      btnOpenDB.Text := 'Desconectar';
    Except
      on E: Exception do
        lblStatus.Text := 'db OFF : error intentando abrir';
    end; // end try
  end
  else
  begin
    DB.Connected := False;
    lblStatus.Text := 'db OFF';
    pnlData.Enabled := False;
    tblAlumno.Active := False;
    bndDECorCON := False;
    btnOpenDB.Text := 'Conectar';

  end; // end if
end;



procedure TfrmMain.FormCreate(Sender: TObject);
begin

bndDECorCON:= False;
  // por si se olvida desconcetar en tiempo de diseño
  DB.Connected := false;
  // configurar el componente de conexion FDConnection
  // ubicacion de la bd
{$IF DEFINED(MSWINDOWS)}
  // windows
  dbFileName := 'R:\SQLiteAlumnosDemo\escolar.db';
{$ELSE}
  // Android, iOS, Mac
  dbFileName := TPath.Combine(TPath.GetDocumentsPath, 'escolar.db');
{$ENDIF}
  DB.Params.Database := dbFileName;
  lblStatus.Text := 'db off';
  // para evitar que el usuario intente usar los datos
  pnlData.Enabled := false;
end;


procedure TfrmMain.rdbFClick(Sender: TObject);
begin
  if not(rdbF.IsChecked) then // checking
  begin

    tblAlumno.Edit;
    tblAlumno.FieldByName('sexo').AsString := 'F';
  end;
end;

procedure TfrmMain.rdbMClick(Sender: TObject);
begin

  if not (rdbM.IsChecked) then // checking
  begin
    tblAlumno.Edit;
    tblAlumno.FieldByName('sexo').AsString := 'M';
  end;

end;

end.
