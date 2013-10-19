unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Unit1,quanju, DB, ADODB, Grids, DBGrids, ComCtrls,
  DBCtrls,jpeg, ExtCtrls,Math, Mask, Menus, ActnList, dbcgrids;

type
  TForm2 = class(TForm)
    souEdt: TEdit;
    souButton: TButton;
    dbgrd1: TDBGrid;
    ds1: TDataSource;
    qry1: TADOQuery;
    pgc1: TPageControl;
    liebiao: TTabSheet;
    xiangxi: TTabSheet;
    dbimg1: TDBImage;
    btn1: TButton;
    img1: TImage;
    btn2: TButton;
    btn3: TButton;
    OpenDialog1: TOpenDialog;
    ts1: TTabSheet;
    ds2: TDataSource;
    qry2: TADOQuery;
    btAuto: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    dbedt1: TDBEdit;
    dbedt2: TDBEdit;
    dbedt3: TDBEdit;
    dbedt4: TDBEdit;
    dbedt5: TDBEdit;
    dbedt6: TDBEdit;
    dbedt7: TDBEdit;
    dbedt8: TDBEdit;
    dbedt9: TDBEdit;
    dbedt10: TDBEdit;
    dbedt11: TDBEdit;
    dbedt12: TDBEdit;
    dbedt13: TDBEdit;
    dbedtID: TDBEdit;
    dbnvgr1: TDBNavigator;
    lbl12: TLabel;
    lbl13: TLabel;
    dbmmo1: TDBMemo;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    cbbid: TComboBox;
    actlst1: TActionList;
    actshowImage: TAction;
    dbtxtID: TDBText;
    pnl1: TPanel;
    scrlbr1: TScrollBar;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure yangshi(Sender: TObject);
    procedure souButtonClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure qry1BeforeScroll(DataSet: TDataSet);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);

    procedure dbgrd1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btAutoClick(Sender: TObject);
    procedure souEdtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure actshowImageExecute(Sender: TObject);
    procedure dbnvgr1Click(Sender: TObject; Button: TNavigateBtn);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure qry1AfterScroll(DataSet: TDataSet);
    procedure pnl1Resize(Sender: TObject);
    procedure scrlbr1Change(Sender: TObject);
    procedure dbimg1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbimg1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbimg1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
//    procedure adoTable1AfterScroll(DataSet: TDataSet); //显示图像
    function ViewPicture(img:TImage; query:TADOQuery; fieldname:String; pictype:String):boolean;
    function DBGridAutoSize(mDBGrid: TDBGrid; mOffset: Integer = 5): Boolean;
    function DBGridRecordSize(mColumn: TColumn): Boolean;
  end;

var
  Form2: TForm2;
   i :string='';
   b: Integer=0;
   a1,a2:Integer;
   w :Double;
   x1,y1 :Integer; //鼠标按下的坐标
   x2,y2 :Integer;  //鼠标按下中的坐标
   mos:Boolean=False;//鼠标是否 按下
implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var tem,last:string;
  begin
//    try
//    Form1 := TForm1.Create(nil);
//    Form1.Showmodal;
//
//    if isLogin <>1 then  //判断是不是登陆成功
//   begin
//      Application.Terminate;
//      Exit;
//    end;
//    finally
//    Form1.Free;
//    end;

  //Application.CreateForm(TForm2, Form2);

  //查出序号
  //ShowMessage(cbb1.Items.GetText);
  qry2.ConnectionString :='Provider=Microsoft.ACE.OLEDB.12.0;Data Source='+ExtractFileDir(Application.Exename)+'\db.mdb;Persist Security Info=False;Jet OLEDB:Database Password=123';
  qry2.Active:=True;
  //ShowMessage (IntToStr(qry2.RowsAffected));
  qry2.Last;
  last:=qry2.FieldByName('id').AsString ;
  qry2.First;
  while tem<>last do
  begin
      tem:=qry2.FieldByName('id').AsString ;
      cbbid.Items.Add(tem);
      qry2.Next;
  end;

  //ShowMessage(tem);
  end;

procedure TForm2.Button1Click(Sender: TObject);
  begin
    Application.CreateForm(TForm1, Form1);
    form1.ShowModal;
  end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
    qry1.Close;
    action:=caFree;
  end;

procedure TForm2.yangshi(Sender: TObject);
begin
if souEdt.Text='请输入关键字' then
begin
  souEdt.Font.Color:=clBlack;
  souEdt.Text:='';

end
else if souEdt.Text='' then
souEdt.Text:='请输入关键字';
//Edit1.Font.Color:=clSilver;
//Edit1.Repaint;
end;

procedure TForm2.souButtonClick(Sender: TObject);
var  guanjian:string;
begin
 guanjian:=souEdt.Text;
 if guanjian='请输入关键字' then
 qry1.SQL.Text:='select * from test'
 else
 qry1.SQL.Text:='SELECT test.* FROM test WHERE(((test.零部件名称) Like "%"+"'+guanjian+'"+"%"))or(((test.序号) Like "%"+"'+guanjian+'"+"%"))or(((test.零部件图号) Like "%"+"'+guanjian+'"+"%"))or(((test.产品型号) Like "%"+"'+guanjian+'"+"%"))or(((test.物料号) Like "%"+"'+guanjian+'"+"%"))or(((test.生产厂家) Like "%"+"'+guanjian+'"+"%"))';
 //ShowMessage(qry1.SQL.Text);
 qry1.Open;
 
end;

procedure TForm2.btn1Click(Sender: TObject);     //显示图片
var tempstream:TStringStream;
   tempjpeg:TJPEGImage;
   h1,h2 :Double;
begin

   //ViewPicture(img1,qry1,'图片','bmp');
 try
        tempstream:=TStringStream.Create('');
        //ShowMessage(inttostr(qry1.FieldByName('图片').DataSet.BlockReadSize));
        //if qry1.FieldByName('图片').DataSize=0 then exit;
        TBlobField(qry1.FieldByName('图片')).SaveToStream(tempstream);
        //if tempstream.Size=0 then exit;
        //ShowMessage(tempstream.DataString);
       // qry1.FieldByName('图片')
        tempstream.Position:=0;
       // qry1.Next;
       // i:=i+1;
        tempjpeg:=TJPEGImage.Create;
        tempjpeg.LoadFromStream(tempstream);
        //ShowMessage(inttostr(tempjpeg.Height)+'*'+inttostr(tempjpeg.Width));
        if tempjpeg.Height=0 then exit;
        //dbimg1.Height:=tempjpeg.Height; //调整图片的大小符合比例
        w:=tempjpeg.Height /tempjpeg.Width;
        h1:=pnl1.Height/w;
        h2:=pnl1.Width*w;
        if w<1 then
        begin
          dbimg1.Width:=pnl1.Width;
          dbimg1.Height:=Trunc(pnl1.width*w);
        end
        else
        begin
           dbimg1.Width:=Trunc(pnl1.Height/w);
          dbimg1.Height:=pnl1.Height;
        end;
        //dbimg1.Width:=Trunc( h1);
        dbimg1.Picture.Bitmap.Assign(tempjpeg);
        //tempstream.Position:=tempstream.Position+1;
       // dbimg1.Picture.Bitmap.LoadFromStream(tempstream);
       a1:=dbimg1.Width;
        a2:=dbimg1.Height;
        dbimg1.Top:=0;
        dbimg1.Left:=0;

  finally
        tempstream.Free;
        tempjpeg.Free;
  end;
end;

function TForm2.ViewPicture(img:TImage; query:TADOQuery; fieldname:String; pictype:String):boolean;
var
    jpg : TJpegImage;
    ts  : TStream;
   // gif : TGifImage;
begin
    result := false;

    pictype := LowerCase(pictype);
    try
        ts := query.CreateBlobStream(query.FieldByName(fieldname),bmRead);
        if ts.Size=0 then exit;

        if (pictype='bmp') or (pictype='image/bmp')  then
        begin
            try
                img.Picture.Bitmap.LoadFromStream(ts);
                result := true;
            except
            end;
        end;

        if (pictype='jpg') or (pictype='image/pjpeg') then
        begin
            jpg := TJpegImage.Create;
            try
                jpg.LoadFromStream(ts);
                img.Picture.Bitmap.Assign(jpg);
                result:=true;
            finally
                jpg.Free;
            end;
        end;

       // if (pictype='gif') or (pictype='image/gif') then
        //begin
        //    gif := TGifImage.Create;
        //    try
        //        gif.LoadFromStream(ts);
         //       img.Picture.Bitmap.Assign(gif);
         //       result:=true;
         //   finally
         //       gif.Free;
         //   end;
        //end;

        ts.Free;

    except end;
end;




procedure TForm2.qry1BeforeScroll(DataSet: TDataSet);
begin
dbimg1.dataField :='';
end;

procedure TForm2.btn2Click(Sender: TObject);   //保存图片
Var
  MyJPEG : TJPEGImage;
  MS: TMemoryStream;
Begin
  i:=cbbid.Text;
  if i='' then
   exit;
  qry2.ConnectionString :='Provider=Microsoft.ACE.OLEDB.12.0;Data Source='+ExtractFileDir(Application.Exename)+'\db.mdb;Persist Security Info=False;Jet OLEDB:Database Password=123';
  qry2.SQL.Text:='select * from test where id='+i;
  qry2.open;
  if img1.Picture.Graphic <>nil then
  begin
    MyJPEG := TJPEGImage.Create;
    
    Try
      With MyJPEG do
      Begin
        Assign(img1.Picture.Graphic);
        MS:=TMemoryStream.create;
        SaveToStream(MS);

        MS.Position := 0;
        qry2.Edit;
        TBlobField(qry2.FieldbyName('图片')).LoadFromStream(MS);
        qry2.Post;
        Messagebox(Getactivewindow(), '图像保存完毕！', '保存', MB_OK);
       End;
    Finally
      MyJPEG.Free;
      MS.Free;
    End;
  End else showmessage('Please choose a image first!');

end;
procedure TForm2.btn3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    //img1.Picture.LoadFromFile('');
    img1.Picture.LoadFromFile(OpenDialog1.FileName);
end;


procedure TForm2.dbgrd1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i :integer;
begin
  DBGridRecordSize(Column);

  if gdSelected in State then Exit;
  //定义表头的字体和背景颜色：
  for i :=0 to (Sender as TDBGrid).Columns.Count-1 do
  begin
    (Sender as TDBGrid).Columns[i].Title.Font.Name :='宋体'; //字体
    (Sender as TDBGrid).Columns[i].Title.Font.Size :=9; //字体大小
    (Sender as TDBGrid).Columns[i].Title.Font.Color :=$000000ff; //字体颜色(红色)
    (Sender as TDBGrid).Columns[i].Title.Color :=clSilver; //背景色(绿色)
  end;
  //隔行改变网格背景色：
  if qry1.RecNo mod 2 = 0 then
    (Sender as TDBGrid).Canvas.Brush.Color := $00B3CFB1 //定义背景颜色
  else
    (Sender as TDBGrid).Canvas.Brush.Color := RGB(255, 255, 223); //定义背景颜色
  //定义网格线的颜色：
  dbgrd1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  with (Sender as TDBGrid).Canvas do //画 cell 的边框
  begin
    Pen.Color := $00ff0000; //定义画笔颜色(蓝色)
    MoveTo(Rect.Left, Rect.Bottom); //画笔定位
    LineTo(Rect.Right, Rect.Bottom); //画蓝色的横线
    Pen.Color := $0000ff00; //定义画笔颜色(绿色)
    MoveTo(Rect.Right, Rect.Top); //画笔定位
    LineTo(Rect.Right, Rect.Bottom); //画绿色的竖线
  end;
end;


function TForm2.DBGridRecordSize(mColumn: TColumn): Boolean;
{ 返回记录数据网格列显示最大宽度是否成功 }
begin
  Result := False;
  if not Assigned(mColumn.Field) then Exit;
  mColumn.Field.Tag := Max(mColumn.Field.Tag,
  TDBGrid(mColumn.Grid).Canvas.TextWidth(mColumn.Field.DisplayText));
  Result := True;
end; { DBGridRecordSize }

function TForm2.DBGridAutoSize(mDBGrid: TDBGrid; mOffset: Integer = 5): Boolean;
{ 返回数据网格自动适应宽度是否成功 }
var
  I: Integer;
begin
  Result := False;
  if not Assigned(mDBGrid) then Exit;
  if not Assigned(mDBGrid.DataSource) then Exit;
  if not Assigned(mDBGrid.DataSource.DataSet) then Exit;
  if not mDBGrid.DataSource.DataSet.Active then Exit;
  for I := 0 to mDBGrid.Columns.Count - 1 do
  begin
    if not mDBGrid.Columns[I].Visible then Continue;
    if Assigned(mDBGrid.Columns[I].Field) then
      mDBGrid.Columns[I].Width := Max(mDBGrid.Columns[I].Field.Tag,
      mDBGrid.Canvas.TextWidth(mDBGrid.Columns[I].Title.Caption)) + mOffset
    else mDBGrid.Columns[I].Width :=mDBGrid.Canvas.TextWidth(mDBGrid.Columns[I].Title.Caption) + mOffset;
    mDBGrid.Refresh;
  end;
  Result := True;
end; { DBGridAutoSize }
procedure TForm2.btAutoClick(Sender: TObject);
begin
    DBGridAutoSize(dbgrd1);
end;

procedure TForm2.souEdtKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_RETURN) then
begin
souButton.Click;//直接调用Button1的事件处理程序完成相同的功能
end;
end;

procedure TForm2.N3Click(Sender: TObject);
begin
dbimg1.CutToClipboard;
//CutToClipboard
end;

procedure TForm2.N2Click(Sender: TObject);
begin
dbimg1.PasteFromClipboard;
end;

procedure TForm2.N1Click(Sender: TObject);
begin
dbimg1.CopyToClipboard;
end;

procedure TForm2.actshowImageExecute(Sender: TObject);
var tempstream:TStringStream;
   tempjpeg:TJPEGImage;
begin
 try
        tempstream:=TStringStream.Create('');
        TBlobField(qry1.FieldByName('图片')).SaveToStream(tempstream);
        tempstream.Position:=0;
        tempjpeg:=TJPEGImage.Create;
        tempjpeg.LoadFromStream(tempstream);
        dbimg1.Picture.Bitmap.Assign(tempjpeg);
  finally
        tempstream.Free;
        tempjpeg.Free;
  end;
end;

procedure TForm2.dbnvgr1Click(Sender: TObject; Button: TNavigateBtn);
begin
 actlst1.ExecuteAction(actshowImage);
end;



procedure TForm2.dbgrd1DblClick(Sender: TObject);
begin
//ShowMessage(IntToStr(dbgrd1.SelectedRows.IndexOf('id')));
  pgc1.TabIndex:=1;
  //btn1.Click;
end;

procedure TForm2.qry1AfterScroll(DataSet: TDataSet);
begin
btn1.Click;
end;

procedure TForm2.pnl1Resize(Sender: TObject);
begin
  dbimg1.Top:=0;
        dbimg1.Left:=0;
      if w<1 then
        begin
          dbimg1.Width:=pnl1.Width;
          dbimg1.Height:=Trunc(pnl1.width*w);
        end
      else
        begin
           dbimg1.Width:=Trunc(pnl1.Height/w);
          dbimg1.Height:=pnl1.Height;
        end;    
end;

procedure TForm2.scrlbr1Change(Sender: TObject);
var s :Double;
begin
  s:=scrlbr1.Position/10;

   dbimg1.Width:=Trunc(a1*s);
   dbimg1.Height:=Trunc(a2*s);
end;

procedure TForm2.dbimg1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
 //ShowMessage(IntToStr(x)+'+++'+inttostr(y));
 x1:=x;
 y1:=y;
 mos:=True;
end;

procedure TForm2.dbimg1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mos:=False;
//x2:=x-x1;
//y2:=y-y1;
//dbimg1.Top:=dbimg1.Top+y2;
//dbimg1.Left:=dbimg1.Left+x2;
//x1:=0;
//x2:=0;
//y1:=0;
//y2:=0
end;

procedure TForm2.dbimg1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
 begin
   if(mos)then
begin
x2:=x-x1;
y2:=y-y1;

dbimg1.Top:=dbimg1.Top+y2;
dbimg1.Left:=dbimg1.Left+x2;
end;
end;

end.
