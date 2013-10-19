unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, ADODB, DB,quanju;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    ADODataSet1: TADODataSet;
    procedure Edit1yangshi(Sender: TObject);
    procedure Edit2yangshi(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormClick(Sender: TObject;var Key: Word;Shift: TShiftState);
  private
    { Private declarations }
  public
    


    { Public declarations }
  end;

var
  Form1: TForm1;


implementation


{$R *.dfm}

procedure TForm1.Edit1yangshi(Sender: TObject);
begin
if Edit1.Text='请输入用户名' then
begin
  Edit1.Font.Color:=clBlack;
  Edit1.Text:='';

end
else if Edit1.Text='' then
Edit1.Text:='请输入用户名';
//Edit1.Font.Color:=clSilver;
//Edit1.Repaint;
end;

procedure TForm1.Edit2yangshi(Sender: TObject);
begin
  if Edit2.Text='请输入密码' then
    begin
      Edit2.Font.Color:=clBlack;
      edit2.Text:='';
      edit2.PasswordChar:='*';
    end
  else if Edit2.Text='' then
    begin
      Edit2.Font.Color:=clSilver;
      edit2.PasswordChar:=#0;
      Edit2.Text:='请输入密码';
    end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
     Edit2.Font.Color:=clSilver;
     Edit1.Font.Color:=clsilver;
end;

procedure TForm1.Button1Click(Sender: TObject);
var yhname:string;
    psw:string;
begin
    yhname:=Edit1.text;
    ADODataSet1.CommandText:='select psw from denglu where name="'+yhname+'";';
    ADODataSet1.Open;
    psw:=ADODataSet1.fieldByName('psw').AsString;
    //showmessage(ADODataSet1.CommandText);
    //ADODataSet1.Active:=true;
    if ((psw<>null)and(Edit2.Text=psw)) then
    //Showmessage(paw);
      begin
      //form1.Free;
      Form1.close;
        //Form2.Show;
        isLogin:=1;
      end
    else
    begin
      ShowMessage('输入的用户名密码错误！');
      Edit2.Text:='请输入密码';
    end;  
    ADODataSet1.Close;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=caFree;
end;

procedure TForm1.FormClick(Sender: TObject;var Key: Word;Shift: TShiftState);
begin
  if (Key=VK_RETURN) then
begin
Button1Click(Sender);//直接调用Button1的事件处理程序完成相同的功能
end;
end;

end.
