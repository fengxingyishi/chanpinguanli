program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  quanju in 'quanju.pas';
 // JrCommon in 'JrCommon.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='产品管理';
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
