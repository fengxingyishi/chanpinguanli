{*******************************************************************************
* ģ������: ���ú�����
* ��д��Ա: Chris Mao
* ��д����: 2004.10.30
******************************************************************************}
unit JrCommon;

interface

uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
ShellAPI, CommDlg, MMSystem, StdCtrls, Registry, Winsock;
const
 SQuery=   'ȷ�϶Ի���';
// ������Ϣ
{$IFDEF GB2312}
SCnInformation = '��ʾ';
SCnWarning = '����';
SCnError = '����';
{$ELSE}
SCnInformation = 'Information';
SCnWarning = 'Warning';
SCnError = 'Error';
{$ENDIF}

C1=52845; //�ַ��������㷨�Ĺ���
C2=22719; //�ַ��������㷨�Ĺ���

resourcestring

{$IFDEF GB2312}
SUnknowError = 'δ֪����';
SErrorCode = '������룺';
{$ELSE}
SUnknowError = 'Unknow error';
SErrorCode = 'Error code:';
{$ENDIF}
//------------------------------------------------------------------------------
//�����ຯ��
//------------------------------------------------------------------------------
function FindFormClass(FormClassName: PChar): TFormClass;
function HasInstance(FormClassName: PChar): Boolean;

//------------------------------------------------------------------------------
//���öԻ�����
//------------------------------------------------------------------------------
procedure InfoDlg(const Msg: String; ACaption: String = SCnInformation);
{ ��Ϣ�Ի��� }

procedure ErrorDlg(const Msg: String; ACaption: String = SCnError);
{ ����Ի��� }

procedure WarningDlg(const Msg: String; ACaption: String = SCnWarning);
{ ����Ի��� }

function QueryDlg(const Msg: String; ACaption: String = SQuery): Boolean;
{ ȷ�϶Ի��� }

function QueryNoDlg(const Msg: string; ACaption: string = SQuery): Boolean;
{ ȷ�϶Ի���Ĭ�ϰ�ťΪ"��" }

function JrInputQuery(const ACaption, APrompt: String; var Value: string): Boolean;
{ ����Ի��� }

function JrInputBox(const ACaption, APrompt, ADefault: string): String;
{ ����Ի��� }

//------------------------------------------------------------------------------
//��չ�ļ�Ŀ¼��������
//------------------------------------------------------------------------------

procedure RunFile(const FileName: String; Handle: THandle = 0; Param: string = '');
{ ����һ���ļ� }

function AppPath: string;
{ Ӧ�ó���·�� }

function GetProgramFilesDir: string;
{ ȡProgram FilesĿ¼ }

function GetWindowsDir: string;
{ ȡWindowsĿ¼}

function GetWindowsTempPath: string;
{ ȡ��ʱ�ļ�·�� }

function GetSystemDir: string;
{ ȡϵͳĿ¼ }

//------------------------------------------------------------------------------
//��չ�ַ�����������
//------------------------------------------------------------------------------

function InStr(const sShort: string; const sLong: string): Boolean;
{ �ж�s1�Ƿ������s2�� }

function IntToStrSp(Value: Integer; SpLen: Integer = 3; Sp: Char = ','): string;
{ ���ָ������������ַ�ת�� }

function ByteToBin(Value: Byte): string;
{ �ֽ�ת�����ƴ� }

function StrRight(Str: string; Len: Integer): string;
{ �����ַ����ұߵ��ַ� }

function StrLeft(Str: string; Len: Integer): string;
{ �����ַ�����ߵ��ַ� }

function Spc(Len: Integer): string;
{ ���ؿո� }

procedure SwapStr(var s1, s2: string);
{ �����ִ� }

//------------------------------------------------------------------------------
// ��չ����ʱ���������
//------------------------------------------------------------------------------

function GetYear(Date: TDate): Word;
{ ȡ������ݷ��� }

function GetMonth(Date: TDate): Word;
{ ȡ�����·ݷ��� }

function GetDay(Date: TDate): Word;
{ ȡ������������ }

function GetHour(Time: TTime): Word;
{ ȡʱ��Сʱ���� }

function GetMinute(Time: TTime): Word;
{ ȡʱ����ӷ��� }

function GetSecond(Time: TTime): Word;
{ ȡʱ������� }

function GetMSecond(Time: TTime): Word;
{ ȡʱ�������� }

//------------------------------------------------------------------------------
// λ��������
//------------------------------------------------------------------------------
type
TByteBit = 0..7; // Byte����λ����Χ
TWordBit = 0..15; // Word����λ����Χ
TDWordBit = 0..31; // DWord����λ����Χ

procedure SetBit(var Value: Byte; Bit: TByteBit; IsSet: Boolean); overload;
{ ���ö�����λ }

procedure SetBit(var Value: WORD; Bit: TWordBit; IsSet: Boolean); overload;
{ ���ö�����λ }

procedure SetBit(var Value: DWORD; Bit: TDWordBit; IsSet: Boolean); overload;
{ ���ö�����λ }

function GetBit(Value: Byte; Bit: TByteBit): Boolean; overload;
{ ȡ������λ }

function GetBit(Value: WORD; Bit: TWordBit): Boolean; overload;
{ ȡ������λ }

function GetBit(Value: DWORD; Bit: TDWordBit): Boolean; overload;
{ ȡ������λ }

//------------------------------------------------------------------------------
// ϵͳ���ܺ���
//------------------------------------------------------------------------------

procedure ChangeFocus(Handle: THandle; Forword: Boolean = False);
{ �ı佹�� }

procedure MoveMouseIntoControl(AWinControl: TControl);
{ �ƶ���굽�ؼ� }

procedure AddComboBoxTextToItems(ComboBox: TComboBox; MaxItemsCount: Integer = 10);
{ �� ComboBox ���ı��������ӵ������б��� }

function DynamicResolution(x, y: WORD): Boolean;
{ ��̬���÷ֱ��� }

procedure StayOnTop(Handle: HWND; OnTop: Boolean);
{ �������Ϸ���ʾ }

procedure SetHidden(Hide: Boolean);
{ ���ó����Ƿ������������ }

procedure SetTaskBarVisible(Visible: Boolean);
{ �����������Ƿ�ɼ� }

procedure SetDesktopVisible(Visible: Boolean);
{ ���������Ƿ�ɼ� }

function GetWorkRect: TRect;
{ ȡ�������� }

procedure BeginWait;
{ ��ʾ�ȴ���� }

procedure EndWait;
{ �����ȴ���� }

function CheckWindows9598: Boolean;
{ ����Ƿ�Win95/98ƽ̨ }

function GetOSString: string;
{ ���ز���ϵͳ��ʶ�� }

function GetComputeNameStr : string;
{ �õ������� }

function GetLocalUserName: string;
{ �õ������û��� }

function GetLocalIP: String;
{ �õ�����IP��ַ }

//------------------------------------------------------------------------------
// ��������
//------------------------------------------------------------------------------

function TrimInt(Value, Min, Max: Integer): Integer; overload;
{ ���������Min..Max֮�� }

function InBound(Value: Integer; Min, Max: Integer): Boolean;
{ �ж�����Value�Ƿ���Min��Max֮�� }

procedure Delay(const uDelay: DWORD);
{ ��ʱ }

procedure BeepEx(const Freq: WORD = 1200; const Delay: WORD = 1);
{ ��Win9X�������ȷ��� }

function GetHzPy(const AHzStr: string): string;
{ ȡ���ֵ�ƴ�� }

function UpperCaseMoney(const Money: Double): String;
{ ת��Ϊ������ }

function SoundCardExist: Boolean;
{ �����Ƿ���� }

implementation

//------------------------------------------------------------------------------
//�����ຯ��
//------------------------------------------------------------------------------

function FindFormClass(FormClassName: PChar): TFormClass;
begin
Result := TFormClass(GetClass(FormClassName));
end;

function HasInstance(FormClassName: PChar): Boolean;
var
i: integer;
begin
Result:=False;
for i := Screen.FormCount - 1 downto 0 do begin
Result := SameText(Screen.Forms[i].ClassName, FormClassName);
if Result then begin
TForm(Screen.Forms[i]).BringToFront;
Break;
end;
end;
end;

//------------------------------------------------------------------------------
//���öԻ�����
//------------------------------------------------------------------------------

procedure InfoDlg(const Msg: String; ACaption: String = ScnInformation);
begin
Application.MessageBox(PChar(Msg), PChar(ACaption), MB_OK + MB_ICONINFORMATION);
end;

procedure ErrorDlg(const Msg: String; ACaption: String = ScnError);
begin
Application.MessageBox(PChar(Msg), PChar(ACaption), MB_OK + MB_ICONERROR);
end;

procedure WarningDlg(const Msg: String; ACaption: String = ScnWarning);
begin
Application.MessageBox(PChar(Msg), PChar(ACaption), MB_OK + MB_ICONWARNING);
end;

function QueryDlg(const Msg: String; ACaption: String = SQuery): Boolean;
begin
Result := Application.MessageBox(PChar(Msg), PChar(ACaption),
MB_YESNO + MB_ICONQUESTION) = IDYES;
end;

function QueryNoDlg(const Msg: string; ACaption: string = SQuery): Boolean;
begin
Result := Application.MessageBox(PChar(Msg), PChar(ACaption),
MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES;
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
I: Integer;
Buffer: array[0..51] of Char;
begin
for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
Result.X := Result.X div 52;
end;

function JrInputQuery(const ACaption, APrompt: String; var Value: string): Boolean;
var
Form: TForm;
Prompt: TLabel;
Edit: TEdit;
DialogUnits: TPoint;
ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
Result := False;
Form := TForm.Create(Application);
with Form do
try
Scaled := False;
Font.Name := SDefaultFontName;
Font.Size := SDefaultFontSize;
Font.Charset := SDefaultFontCharset;
Canvas.Font := Font;
DialogUnits := GetAveCharSize(Canvas);
BorderStyle := bsDialog;
Caption := ACaption;
ClientWidth := MulDiv(180, DialogUnits.X, 4);
ClientHeight := MulDiv(63, DialogUnits.Y, 8);
Position := poScreenCenter;
Prompt := TLabel.Create(Form);
with Prompt do
begin
Parent := Form;
AutoSize := True;
Left := MulDiv(8, DialogUnits.X, 4);
Top := MulDiv(8, DialogUnits.Y, 8);
Caption := APrompt;
end;
Edit := TEdit.Create(Form);
with Edit do
begin
Parent := Form;
Left := Prompt.Left;
Top := MulDiv(19, DialogUnits.Y, 8);
Width := MulDiv(164, DialogUnits.X, 4);
MaxLength := 255;
Text := Value;
SelectAll;
end;
ButtonTop := MulDiv(41, DialogUnits.Y, 8);
ButtonWidth := MulDiv(50, DialogUnits.X, 4);
ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
with TButton.Create(Form) do
begin
Parent := Form;
Caption := SMsgDlgOK;
ModalResult := mrOk;
Default := True;
SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
ButtonHeight);
end;
with TButton.Create(Form) do
begin
Parent := Form;
Caption := SMsgDlgCancel;
ModalResult := mrCancel;
Cancel := True;
SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
ButtonHeight);
end;
if ShowModal = mrOk then
begin
Value := Edit.Text;
Result := True;
end;
finally
Form.Free;
end;
end;

function JrInputBox(const ACaption, APrompt, ADefault: string): String;
begin
Result := ADefault;
JrInputQuery(ACaption, APrompt, Result);
end;

//------------------------------------------------------------------------------
//��չ�ļ�Ŀ¼��������
//------------------------------------------------------------------------------

procedure RunFile(const FileName: String; Handle: THandle = 0; Param: string = '');
begin
ShellExecute(Handle, nil, PChar(FileName), PChar(Param), nil, SW_SHOWNORMAL);
end;

function AppPath: string;
begin
Result := ExtractFilePath(Application.ExeName);
end;

const
HKLM_CURRENT_VERSION_WINDOWS = 'SoftwareMicrosoftWindowsCurrentVersion';

function RelativeKey(const Key: string): PChar;
begin
Result := PChar(Key);
if (Key <> '') and (Key[1] = '') then
Inc(Result);
end;

function RegReadStringDef(const RootKey: HKEY; const Key, Name, Def: string): string;
var
RegKey: HKEY;
Size: DWORD;
StrVal: string;
RegKind: DWORD;
begin
Result := Def;
if RegOpenKeyEx(RootKey, RelativeKey(Key), 0, KEY_READ, RegKey) = ERROR_SUCCESS then
begin
RegKind := 0;
Size := 0;
if RegQueryValueEx(RegKey, PChar(Name), nil, @RegKind, nil, @Size) = ERROR_SUCCESS then
if RegKind in [REG_SZ, REG_EXPAND_SZ] then
begin
SetLength(StrVal, Size);
if RegQueryValueEx(RegKey, PChar(Name), nil, @RegKind, PByte(StrVal), @Size) = ERROR_SUCCESS then
begin
SetLength(StrVal, StrLen(PChar(StrVal)));
Result := StrVal;
end;
end;
RegCloseKey(RegKey);
end;
end;

procedure StrResetLength(var S: AnsiString);
begin
SetLength(S, StrLen(PChar(S)));
end;

function GetProgramFilesDir: string;
begin
Result := RegReadStringDef(HKEY_LOCAL_MACHINE, HKLM_CURRENT_VERSION_WINDOWS, 'ProgramFilesDir', '');
end;

function GetWindowsDir: string;
var
Required: Cardinal;
begin
Result := '';
Required := GetWindowsDirectory(nil, 0);
if Required <> 0 then
begin
SetLength(Result, Required);
GetWindowsDirectory(PChar(Result), Required);
StrResetLength(Result);
end;
end;

function GetWindowsTempPath: string;
var
Required: Cardinal;
begin
Result := '';
Required := GetTempPath(0, nil);
if Required <> 0 then
begin
SetLength(Result, Required);
GetTempPath(Required, PChar(Result));
StrResetLength(Result);
end;
end;

function GetSystemDir: string;
var
Required: Cardinal;
begin
Result := '';
Required := GetSystemDirectory(nil, 0);
if Required <> 0 then
begin
SetLength(Result, Required);
GetSystemDirectory(PChar(Result), Required);
StrResetLength(Result);
end;
end;

//------------------------------------------------------------------------------
//��չ�ַ�����������
//------------------------------------------------------------------------------

function InStr(const sShort: string; const sLong: string): Boolean;
var
s1, s2: string;
begin
s1 := LowerCase(sShort);
s2 := LowerCase(sLong);
Result := Pos(s1, s2) > 0;
end;

function IntToStrSp(Value: Integer; SpLen: Integer = 3; Sp: Char = ','): string;
var
s: string;
i, j: Integer;
begin
s := IntToStr(Value);
Result := '';
j := 0;
for i := Length(s) downto 1 do
begin
Result := s[i] + Result;
Inc(j);
if ((j mod SpLen) = 0) and (i <> 1) then Result := Sp + Result;
end;
end;

function ByteToBin(Value: Byte): string;
const
V: Byte = 1;
var
i: Integer;
begin
for i := 7 downto 0 do
if (V shl i) and Value <> 0 then
Result := Result + '1'
else
Result := Result + '0';
end;

function StrRight(Str: string; Len: Integer): string;
begin
if Len >= Length(Str) then
Result := Str
else
Result := Copy(Str, Length(Str) - Len + 1, Len);
end;

function StrLeft(Str: string; Len: Integer): string;
begin
if Len >= Length(Str) then
Result := Str
else
Result := Copy(Str, 1, Len);
end;

function Spc(Len: Integer): string;
begin
SetLength(Result, Len);
FillChar(PChar(Result)^, Len, ' ');
end;

procedure SwapStr(var s1, s2: string);
var
tempstr: string;
begin
tempstr := s1;
s1 := s2;
s2 := tempstr;
end;

//------------------------------------------------------------------------------
// ��չ����ʱ���������
//------------------------------------------------------------------------------

function GetYear(Date: TDate): Word;
var
m, d: WORD;
begin
DecodeDate(Date, Result, m, d);
end;

function GetMonth(Date: TDate): Word;
var
y, d: WORD;
begin
DecodeDate(Date, y, Result, d);
end;

function GetDay(Date: TDate): Word;
var
y, m: WORD;
begin
DecodeDate(Date, y, m, Result);
end;

function GetHour(Time: TTime): Word;
var
h, m, s, ms: WORD;
begin
DecodeTime(Time, Result, m, s, ms);
end;

function GetMinute(Time: TTime): Word;
var
h, s, ms: WORD;
begin
DecodeTime(Time, h, Result, s, ms);
end;

function GetSecond(Time: TTime): Word;
var
h, m, ms: WORD;
begin
DecodeTime(Time, h, m, Result, ms);
end;

function GetMSecond(Time: TTime): Word;
var
h, m, s: WORD;
begin
DecodeTime(Time, h, m, s, Result);
end;

//------------------------------------------------------------------------------
// λ��������
//------------------------------------------------------------------------------

procedure SetBit(var Value: Byte; Bit: TByteBit; IsSet: Boolean); overload;
begin
if IsSet then
Value := Value or (1 shl Bit) else
Value := Value and not(1 shl Bit);
end;

procedure SetBit(var Value: WORD; Bit: TWordBit; IsSet: Boolean); overload;
begin
if IsSet then
Value := Value or (1 shl Bit) else
Value := Value and not(1 shl Bit);
end;

procedure SetBit(var Value: DWORD; Bit: TDWordBit; IsSet: Boolean); overload;
begin
if IsSet then
Value := Value or (1 shl Bit) else
Value := Value and not(1 shl Bit);
end;

function GetBit(Value: Byte; Bit: TByteBit): Boolean; overload;
begin
Result := Value and (1 shl Bit) <> 0;
end;

function GetBit(Value: WORD; Bit: TWordBit): Boolean; overload;
begin
Result := Value and (1 shl Bit) <> 0;
end;

function GetBit(Value: DWORD; Bit: TDWordBit): Boolean; overload;
begin
Result := Value and (1 shl Bit) <> 0;
end;

//------------------------------------------------------------------------------
// ϵͳ���ܺ���
//------------------------------------------------------------------------------

procedure ChangeFocus(Handle: THandle; Forword: Boolean = False);
begin
if ForWord then
PostMessage(Handle, WM_NEXTDLGCTL, 1, 0)
else
PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure MoveMouseIntoControl(AWinControl: TControl);
var
rtControl: TRect;
begin
rtControl := AWinControl.BoundsRect;
MapWindowPoints(AWinControl.Parent.Handle, 0, rtControl, 2);
SetCursorPos(rtControl.Left + (rtControl.Right - rtControl.Left) div 2,
rtControl.Top + (rtControl.Bottom - rtControl.Top) div 2);
end;

procedure AddComboBoxTextToItems(ComboBox: TComboBox; MaxItemsCount: Integer = 10);
begin
if (ComboBox.Text <> '') and (ComboBox.Items.IndexOf(ComboBox.Text) < 0) then
begin
ComboBox.Items.Insert(0, ComboBox.Text);
while (MaxItemsCount > 1) and (ComboBox.Items.Count > MaxItemsCount) do
ComboBox.Items.Delete(ComboBox.Items.Count - 1);
end;
end;

function DynamicResolution(x, y: WORD): Boolean;
var
lpDevMode: TDeviceMode;
begin
Result := EnumDisplaySettings(nil, 0, lpDevMode);
if Result then
begin
lpDevMode.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT;
lpDevMode.dmPelsWidth := x;
lpDevMode.dmPelsHeight := y;
Result := ChangeDisplaySettings(lpDevMode, 0) = DISP_CHANGE_SUCCESSFUL;
end;
end;

procedure StayOnTop(Handle: HWND; OnTop: Boolean);
const
csOnTop: array[Boolean] of HWND = (HWND_NOTOPMOST, HWND_TOPMOST);
begin
SetWindowPos(Handle, csOnTop[OnTop], 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
end;

var
WndLong: Integer;

procedure SetHidden(Hide: Boolean);
begin
ShowWindow(Application.Handle, SW_HIDE);
if Hide then
SetWindowLong(Application.Handle, GWL_EXSTYLE,
WndLong or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW or WS_EX_TOPMOST)
else
SetWindowLong(Application.Handle, GWL_EXSTYLE, WndLong);
ShowWindow(Application.Handle, SW_SHOW);
end;

const
csWndShowFlag: array[Boolean] of DWORD = (SW_HIDE, SW_RESTORE);

procedure SetTaskBarVisible(Visible: Boolean);
var
wndHandle: THandle;
begin
wndHandle := FindWindow('Shell_TrayWnd', nil);
ShowWindow(wndHandle, csWndShowFlag[Visible]);
end;

procedure SetDesktopVisible(Visible: Boolean);
var
hDesktop: THandle;
begin
hDesktop := FindWindow('Progman', nil);
ShowWindow(hDesktop, csWndShowFlag[Visible]);
end;

function GetWorkRect: TRect;
begin
SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0)
end;

procedure BeginWait;
begin
Screen.Cursor := crHourGlass;
end;

procedure EndWait;
begin
Screen.Cursor := crDefault;
end;

function CheckWindows9598: Boolean;
var
V: TOSVersionInfo;
begin
V.dwOSVersionInfoSize := SizeOf(V);
Result := False;
if not GetVersionEx(V) then Exit;
if V.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
Result := True;
end;

function GetOSString: string;
var
OSPlatform: string;
BuildNumber: Integer;
begin
Result := 'Unknown Windows Version';
OSPlatform := 'Windows';
BuildNumber := 0;

case Win32Platform of
VER_PLATFORM_WIN32_WINDOWS:
begin
BuildNumber := Win32BuildNumber and $0000FFFF;
case Win32MinorVersion of
0..9:
begin
if Trim(Win32CSDVersion) = 'B' then
OSPlatform := 'Windows 95 OSR2'
else
OSPlatform := 'Windows 95';
end;
10..89:
begin
if Trim(Win32CSDVersion) = 'A' then
OSPlatform := 'Windows 98'
else
OSPlatform := 'Windows 98 SE';
end;
90:
OSPlatform := 'Windows Millennium';
end;
end;
VER_PLATFORM_WIN32_NT:
begin
if Win32MajorVersion in [3, 4] then
OSPlatform := 'Windows NT'
else if Win32MajorVersion = 5 then
begin
case Win32MinorVersion of
0: OSPlatform := 'Windows 2000';
1: OSPlatform := 'Windows XP';
end;
end;
BuildNumber := Win32BuildNumber;
end;
VER_PLATFORM_WIN32s:
begin
OSPlatform := 'Win32s';
BuildNumber := Win32BuildNumber;
end;
end;
if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) or
(Win32Platform = VER_PLATFORM_WIN32_NT) then
begin
if Trim(Win32CSDVersion) = '' then
Result := Format('%s %d.%d (Build %d)', [OSPlatform, Win32MajorVersion,
Win32MinorVersion, BuildNumber])
else
Result := Format('%s %d.%d (Build %d: %s)', [OSPlatform, Win32MajorVersion,
Win32MinorVersion, BuildNumber, Win32CSDVersion]);
end
else
Result := Format('%s %d.%d', [OSPlatform, Win32MajorVersion, Win32MinorVersion])
end;

function GetComputeNameStr : string;
var
dwBuff : DWORD;
CmpName : array [0..255] of Char;
begin
Result := '';
dwBuff := 256;
FillChar(CmpName, SizeOf(CmpName), 0);
if GetComputerName(CmpName, dwBuff) then
Result := StrPas(CmpName);
end;

function GetLocalUserName: string;
var
Count: DWORD;
begin
Count := 256 + 1; // UNLEN + 1
// set buffer size to 256 + 2 characters
SetLength(Result, Count);
if GetUserName(PChar(Result), Count) then
StrResetLength(Result)
else
Result := '';
end;

function GetLocalIP: String;
type
TaPInAddr = array [0..10] of PInAddr;
PaPInAddr = ^TaPInAddr;
var
phe : PHostEnt;
pptr : PaPInAddr;
Buffer : array [0..63] of char;
I : Integer;
GInitData : TWSADATA;

begin
WSAStartup($101, GInitData);
Result := '';
GetHostName(Buffer, SizeOf(Buffer));
phe :=GetHostByName(buffer);
if phe = nil then Exit;
pptr := PaPInAddr(Phe^.h_addr_list);
I := 0;
while pptr^[I] <> nil do begin
result:=StrPas(inet_ntoa(pptr^[I]^));
Inc(I);
end;
WSACleanup;
end;

//------------------------------------------------------------------------------
// ��������
//------------------------------------------------------------------------------

function TrimInt(Value, Min, Max: Integer): Integer; overload;
begin
if Value > Max then
Result := Max
else if Value < Min then
Result := Min
else
Result := Value;
end;

function InBound(Value: Integer; Min, Max: Integer): Boolean;
begin
Result := (Value >= Min) and (Value <= Max);
end;

procedure Delay(const uDelay: DWORD);
var
n: DWORD;
begin
n := GetTickCount;
while ((GetTickCount - n) <= uDelay) do
Application.ProcessMessages;
end;

procedure BeepEx(const Freq: WORD = 1200; const Delay: WORD = 1);
const
FREQ_SCALE = $1193180;
var
Temp: WORD;
begin
Temp := FREQ_SCALE div Freq;
asm
in al,61h;
or al,3;
out 61h,al;
mov al,$b6;
out 43h,al;
mov ax,temp;
out 42h,al;
mov al,ah;
out 42h,al;
end;
Sleep(Delay);
asm
in al,$61;
and al,$fc;
out $61,al;
end;
end;

function GetHzPy(const AHzStr: string): string;
const
ChinaCode: array[0..25, 0..1] of Integer = ((1601, 1636), (1637, 1832), (1833, 2077),
(2078, 2273), (2274, 2301), (2302, 2432), (2433, 2593), (2594, 2786), (9999, 0000),
(2787, 3105), (3106, 3211), (3212, 3471), (3472, 3634), (3635, 3722), (3723, 3729),
(3730, 3857), (3858, 4026), (4027, 4085), (4086, 4389), (4390, 4557), (9999, 0000),
(9999, 0000), (4558, 4683), (4684, 4924), (4925, 5248), (5249, 5589));
var
i, j, HzOrd: Integer;
begin
i := 1;
while i <= Length(AHzStr) do
begin
if (AHzStr[i] >= #160) and (AHzStr[i + 1] >= #160) then
begin
HzOrd := (Ord(AHzStr[i]) - 160) * 100 + Ord(AHzStr[i + 1]) - 160;
for j := 0 to 25 do
begin
if (HzOrd >= ChinaCode[j][0]) and (HzOrd <= ChinaCode[j][1]) then
begin
Result := Result + Char(Byte('A') + j);
Break;
end;
end;
Inc(i);
end else Result := Result + AHzStr[i];
Inc(i);
end;
end;

function UpperCaseMoney(const Money: Double): String;
var
tmp1,rr :string;
l,i,j,k:integer;
r: Double;
const
n1: array[0..9] of string = ('��', 'Ҽ', '��', '��', '��',
'��', '½', '��', '��', '��');
n2: array[0..3] of string = ('', 'ʰ' ,'��', 'Ǫ');
n3: array[0..2] of string = ('Ԫ', '��', '��');
begin
r:=Money;
tmp1:=FormatFloat('#.00',r);
l:=length(tmp1);
rr:='';
if strtoint(tmp1[l])<>0 then begin
rr:='��';
rr:=n1[strtoint(tmp1[l])]+rr;
end;

if strtoint(tmp1[l-1])<>0 then begin
rr:='��'+rr;
rr:=n1[strtoint(tmp1[l-1])]+rr;
end;

i:=l-3;
j:=0;k:=0;
while i>0 do begin
if j mod 4=0 then begin
rr:=n3[k]+rr;
inc(k);if k>2 then k:=1;
j:=0;
end;
if strtoint(tmp1[i])<>0 then
rr:=n2[j]+rr;
rr:=n1[strtoint(tmp1[i])]+rr;
inc(j);
dec(i);
end;

while pos('����',rr)>0 do
rr:= stringreplace(rr,'����','��',[rfReplaceAll]);
rr:=stringreplace(rr,'����','����',[rfReplaceAll]);
while pos('����',rr)>0 do
rr:= stringreplace(rr,'����','��',[rfReplaceAll]);
rr:=stringreplace(rr,'����','����',[rfReplaceAll]);
while pos('����',rr)>0 do
rr:= stringreplace(rr,'����','��',[rfReplaceAll]);
rr:=stringreplace(rr,'��Ԫ','Ԫ��',[rfReplaceAll]);
while pos('����',rr)>0 do
rr:= stringreplace(rr,'����','��',[rfReplaceAll]);
rr:=stringreplace(rr,'����','��',[rfReplaceAll]);

if copy(rr,length(rr)-1,2)='��' then
rr:=copy(rr,1,length(rr)-2);

result:=rr;
end;

function SoundCardExist: Boolean;
begin
Result := WaveOutGetNumDevs > 0;
end;

initialization
WndLong := GetWindowLong(Application.Handle, GWL_EXSTYLE);

end.
