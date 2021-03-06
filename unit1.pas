unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, db, FileUtil, RTTICtrls,
  ListFilterEdit, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus, StdCtrls,
  DbCtrls, ComboEx, FileCtrl, MaskEdit;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    AuthGroupBox: TGroupBox;
    addhostButton: TButton;
    authaddButton: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    rdplabelEdit: TLabeledEdit;
    passwordEdit: TEdit;
    HostsGroupsAddButton: TButton;
    hostsgroupsEdit: TLabeledEdit;
    usernameEdit: TEdit;
    domainEdit: TEdit;
    authlabelEdit: TEdit;
    hostlabelEdit: TEdit;
    hostgroupsGroupBox: TGroupBox;
    HostEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    rdpGroupBox: TGroupBox;
    hostgroupbox: TGroupBox;
    ListBox1: TListBox;
    ListFilterEdit1: TListFilterEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PopupMenu1: TPopupMenu;
    SQLite3Connection: TSQLite3Connection;
    SQLQuery: TSQLQuery;
    SQLTransaction: TSQLTransaction;
    TrayIcon: TTrayIcon;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure rdpGroupBoxClick(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure LoadAuthData;
    procedure LoadHostData;
    procedure LoadRDPData;
    procedure LoadHistoryData;
    procedure LoadHostGroupsData;
  private
    { private declarations }
  public
    { public declarations }
  end;
  TAuthData=record
    id:integer;
    username:string;
    password:string;
    domain:string;
    caption:string;
  end;
  THostData=record
    id:integer;
    name:string;
    caption:string;
  end;
  TRDPData=record
    id:integer;
    hostdata_id:integer;
    authdata_id:integer;
    caption:string;
    hostgroup_id:integer;
  end;
  THistoryData=record
    id:integer;
    name:string;
    authdata_id:integer;
    authusr:string;
    authpwd:string;
    caption:string;
    ts:tdatetime;
  end;

var
  Form1: TForm1;
  AuthData: array of TAuthData;
  HostData: array of THostData;
  RDPData: array of TRDPData;
  HistoryData: array of THistoryData;
  HostGroupsData: TStringList;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
   tmpitem:TMenuItem;
   i:integer;
begin
 popupmenu1.Items.Clear;
 for i:=1 to 10 do begin
    tmpitem:=TMenuItem.Create(form1);
    tmpitem.Caption:=inttostr(i);
    popupmenu1.Items.Add(tmpitem);
 end;
end;

procedure TForm1.LoadAuthData;
var
   i:integer;
begin
 SetLength(AuthData,0);
  sqlquery.SQL.Text:='select id, username, password, domain, caption from authdata;';
//  sqlquery.SQL.Text:='select * from history;';
  SQLQuery.Open;
  SetLength(AuthData,sqlquery.FieldCount);
  i:=0;
  while not SQLQuery.Eof do
  begin
    AuthData[i].id:=sqlquery.FieldByName('id').AsInteger;
    AuthData[i].username:=sqlquery.FieldByName('username').AsString;
    AuthData[i].password:=sqlquery.FieldByName('password').AsString;
    AuthData[i].domain:=sqlquery.FieldByName('domain').AsString;
    AuthData[i].caption:=sqlquery.FieldByName('caption').AsString;

    SQLQuery.Next;
    inc(i);
  end;
  SQLQuery.Close;
end;

procedure TForm1.LoadHostData;
var
   i:integer;
begin
 SetLength(HostData,0);
  sqlquery.SQL.Text:='select id,name,caption from hosts;';
  SQLQuery.Open;
  SetLength(HostData,sqlquery.FieldCount);
  i:=0;
  while not SQLQuery.Eof do
  begin
    HostData[i].id:=sqlquery.FieldByName('id').AsInteger;
    HostData[i].name:=sqlquery.FieldByName('name').AsString;
    HostData[i].caption:=sqlquery.FieldByName('caption').AsString;

    SQLQuery.Next;
    inc(i);
  end;
  SQLQuery.Close;
end;

procedure TForm1.LoadRDPData;
var
   i:integer;
begin
 SetLength(RDPData,0);
  sqlquery.SQL.Text:='select id,authdata_id,hostdata_id,caption,hostgroup_id from rdpdata;';
  SQLQuery.Open;
  SetLength(RDPData,sqlquery.FieldCount);
  i:=0;
  while not SQLQuery.Eof do
  begin
    RDPData[i].id:=sqlquery.FieldByName('id').AsInteger;
    RDPData[i].authdata_id:=sqlquery.FieldByName('authdata_id').AsInteger;
    RDPData[i].hostdata_id:=sqlquery.FieldByName('hostdata_id').AsInteger;
    RDPData[i].caption:=sqlquery.FieldByName('caption').AsString;
    RDPData[i].hostgroup_id:=sqlquery.FieldByName('hostgroup_id').AsInteger;
    SQLQuery.Next;
    inc(i);
  end;
  SQLQuery.Close;
end;

procedure TForm1.LoadHistoryData;
var
   i:integer;
begin
 SetLength(HistoryData,0);
  sqlquery.SQL.Text:='select id, name, authdata_id, authusr, authpwd, caption, ts from history;';
  SQLQuery.Open;
  SetLength(HistoryData,sqlquery.FieldCount);
  i:=0;
  while not SQLQuery.Eof do
  begin
    HistoryData[i].id:=sqlquery.FieldByName('id').AsInteger;
    HistoryData[i].name:=sqlquery.FieldByName('name').AsString;
    HistoryData[i].authdata_id:=sqlquery.FieldByName('authdata_id').AsInteger;
    HistoryData[i].authusr:=sqlquery.FieldByName('authusr').AsString;
    HistoryData[i].authpwd:=sqlquery.FieldByName('authpwd').AsString;
    HistoryData[i].caption:=sqlquery.FieldByName('caption').AsString;
    HistoryData[i].ts:=sqlquery.FieldByName('ts').AsDateTime;
    SQLQuery.Next;
    inc(i);
  end;
  SQLQuery.Close;
end;

procedure TForm1.LoadHostGroupsData;
begin
 if not Assigned(HostGroupsData) then HostGroupsData:=TStringList.Create;
 HostGroupsData.Clear;
   sqlquery.SQL.Text:='select id, name from hostgroups;';
   SQLQuery.Open;
   while not SQLQuery.Eof do
   begin
     HostGroupsData.Add(sqlquery.FieldByName('name').AsString);
     SQLQuery.Next;
   end;
   SQLQuery.Close;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
   i:integer;
begin
 LoadHostGroupsData;
 LoadAuthData;
 LoadHostData;
 LoadRDPData;
 LoadHistoryData;
 ListFilterEdit1.Items.Clear;
 for i:=0 to length(HostData)-2 do ListFilterEdit1.Items.add(HostData[i].name);
// listbox1.ItemIndex:=0;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  form1.Hide;
end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.rdpGroupBoxClick(Sender: TObject);
begin

end;


procedure TForm1.TrayIconClick(Sender: TObject);
begin
  form1.Visible:=true;
end;

end.

