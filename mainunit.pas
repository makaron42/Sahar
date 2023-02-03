unit MainUnit;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, ActnList, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    EditKey: TEdit;
    ImageLogo: TImage;
    LabelName: TLabel;
    LabelOrigin: TLabel;
    LabelResult: TLabel;
    MemoOrigin: TMemo;
    MemoResult: TMemo;
    OpenDialog: TOpenDialog;
    PanelOrigin: TPanel;
    PanelManage: TPanel;
    PanelResult: TPanel;
    PanelName: TPanel;
    PanelCrypto: TPanel;
    PanelMenu: TPanel;
    Option: TRadioGroup;
    SaveDialog: TSaveDialog;
    ScrollBox2: TScrollBox;
    SpeedButtonCopy: TSpeedButton;
    SpeedButtonSaveToFile: TSpeedButton;
    SpeedButtonEncrypt: TSpeedButton;
    SpeedButtonDecrypt: TSpeedButton;
    SpeedButtonOpenFile: TSpeedButton;
    SpeedButtonInfo: TSpeedButton;
    Splitter1: TSplitter;
    Timer1: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure OptionClick(Sender: TObject);
    procedure SpeedButtonCopyClick(Sender: TObject);
    procedure SpeedButtonDecryptClick(Sender: TObject);
    //procedure RadioGroup1Click(Sender: TObject);
    procedure SpeedButtonEncryptClick(Sender: TObject);
    procedure SpeedButtonOpenFileClick(Sender: TObject);
    procedure SpeedButtonSaveToFileClick(Sender: TObject);
  private

  public

  end;


  { Cipher }

  Cipher = class
    Name: String;
    Info: String;

    function Encrypt(text : String; key : String) : String; virtual; abstract;
    function Decrypt(text : String; key : String) : String; virtual; abstract;
  private

  public

  end;

  { Caesar }

  Caesar = class(Cipher)
  private

  public       
    name: String;
    Constructor Create;
    function Encrypt(text : String; key : String) : String;
    function Decrypt(text : String; key : String) : String;
  end;

  Affine = class(Cipher)
  private

  public     
    name: String; 
    Constructor Create;
    function Encrypt(text : String; key : String) : String;
    function Decrypt(text : String; key : String) : String;
  end;

  Vigenere = class(Cipher)
  private

  public     
    name: String;       
    Constructor Create;
    function Encrypt(text : String; key : String) : String;
    function Decrypt(text : String; key : String) : String;
  end;

  FrequencyCryptanalysis = class(Cipher)
  private

  public        
    name: String;   
    Constructor Create;
    function Encrypt(text : String; key : String) : String;
    function Decrypt(text : String; key : String) : String;
  end;

var
  Form1: TForm1;
  Appear: Boolean;
  x:integer;
  alphabet: string = 'abcdefghijklmnopqrstuvwxyz';

implementation

{$R *.lfm}

{ Caesar }

Constructor Caesar.Create;
begin
  name := 'Caesar Cipher';
end;

function Caesar.Encrypt(text : String; key : String) : String;
var
  i : Integer;
  c : Char;
  newC : String;
  sb : TStringBuilder;
  cleanText : String;
  cleanKey : Integer;
begin
  try
    cleanKey := StrToInt(Trim(key));
    cleanKey := cleanKey mod 26;
  except
    ShowMessage('Incorrect key');
    Result := '';
    Exit;
  end;
  sb:=TStringBuilder.Create();
  cleanText := StringReplace(text, LineEnding, '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ' ', '', [rfReplaceAll]);
  cleanText := LowerCase(cleanText);

  for c in cleanText do
  begin
    if (Ord(c) >= Ord('a')) and (Ord(c) <= Ord('z')) then
    begin
      if (Ord(c) + cleanKey <= Ord('z')) and (Ord(c) + cleanKey >= Ord('a')) then
        newC := Chr(Ord(c) + cleanKey)
      else if (Ord(c) + cleanKey < Ord('a')) then
        newC := Chr(Ord('z') + cleanKey + Ord(c) - Ord('a') + 1)
      else
        newC := Chr(Ord('a') + Ord(c) + cleanKey - Ord('z') - 1);
    end
    else begin
      newC := c;
    end;
    sb.Append(newC);
  end;

  Result := sb.ToString;
end;

function Caesar.Decrypt(text : String; key : String) : String;
var
  cleanKey : Integer;
begin
  try
    cleanKey := StrToInt(Trim(key));
    cleanKey := cleanKey mod 26;
    cleanKey *= -1;
  except
    ShowMessage('Incorrect key');
    Result := '';
    Exit;
  end;
  Result := Encrypt(text, IntToStr(cleanKey));
end;

{ Affine }

Constructor Affine.Create;
begin
  name := 'Affine Cipher';
end;

function Affine.Encrypt(text : String; key : String) : String;
var
  a : Integer;
  b : Integer;
  c : Char;
  sb : TStringBuilder;
  cleanText : String;
  newC : Char;
begin
  try
    a := StrToInt(Trim(key).Split([' ', ',', '|', ':', ';'])[0]);
    b := StrToInt(Trim(key).Split([' ', ',', '|', ':', ';'])[1]);
    if (a > 26) or (b > 26) then
      Raise Exception.Create('q');
    if ((a <> 1) or (a <> 26)) and ((26 mod a) = 0) then
      Raise Exception.Create('q');
  except
    ShowMessage('Incorrect key');
    Exit;
  end;
  sb:=TStringBuilder.Create();

  cleanText := StringReplace(text, LineEnding, '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ' ', '', [rfReplaceAll]);
  cleanText := LowerCase(cleanText);
  for c in cleanText do
  begin
    if alphabet.Contains(c) then  begin
      newC := alphabet[(alphabet.IndexOf(c) * a + b) mod 26 + 1] ;
      //sb.append((alphabet.IndexOf(c) * a + b) mod 26)
    end
    else
      newC := c;    
  sb.Append(newC);
  end;
  Result := sb.ToString;
end;

function Affine.Decrypt(text : String; key : String) : String;
var
  a : Integer;
  b : Integer;
  c : Char;
  sb : TStringBuilder;
  cleanText : String;
  newC : Char;
  aa : Integer;
  //i : Integer;
begin
  try
    a := StrToInt(Trim(key).Split([' ', ',', '|', ':', ';'])[0]);
    b := StrToInt(Trim(key).Split([' ', ',', '|', ':', ';'])[1]);
    //if (a > 26) or (b > 26) then
    //  Raise Exception.Create('q');
    //if ((a <> 1) or (a <> 26)) and ((26 mod a) = 0) then
    //  Raise Exception.Create('q');
  except
    ShowMessage('Incorrect key');
    Exit;
  end;
  sb:=TStringBuilder.Create();

  cleanText := StringReplace(text, LineEnding, '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ' ', '', [rfReplaceAll]);
  cleanText := LowerCase(cleanText);

  for aa := 0 to Pred(26) do
  begin
    if (a * aa) mod 26 = 1 then
      Break;
  end;

  //Form1.Caption := IntToStr(aa);

  for c in cleanText do
  begin
    if alphabet.Contains(c) then  begin
      newC := alphabet[(aa * (alphabet.IndexOf(c) + 26 - b)) mod 26 + 1];
      //Form1.Caption := IntToStr(aa) + IntToStr(alphabet.IndexOf(c)) + IntToStr(b) + ' ' + IntToStr((aa * (alphabet.IndexOf(c) + 26 - b)) mod 26);
      //Form1.Caption := alphabet[0];
      //Form1.Caption := IntToStr(aa * (Ord(c) + 26 - b) mod 26);
      //try
      //  newC := alphabet[((alphabet.IndexOf(c)-1 - b) div a) mod 26];  
      //  //Form1.Caption := IntToStr(((alphabet.IndexOf(c) - b) div a) mod 26);
      //except
      //  ShowMessage('Incorrect key');
      //  Exit;
      //end;
      ////sb.append((alphabet.IndexOf(c) * a + b) mod 26)
    end
    else
      newC := c;
  sb.Append(newC);
  end;
  Result := sb.ToString;
end;

{ Vigenere }
      
Constructor Vigenere.Create;
begin
  name := 'Vigenere Cipher';
end;

function Vigenere.Encrypt(text : String; key : String) : String;
var
  i : Integer;
  c : Char;
  newC : String;
  sb : TStringBuilder;
  cleanText : String;
  cleanKey : String;
  key_i : Integer;
  key_c : Char;
begin
  sb := TStringBuilder.Create();
  for c in Trim(key) do
  begin
    if alphabet.Contains(c) then
      sb.Append(c)
    else
    begin
      ShowMessage('Incorrect key');
      Exit;
    end;
  end;
  cleanKey := sb.ToString;

  sb:=TStringBuilder.Create();
  cleanText := StringReplace(text, LineEnding, '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ' ', '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ',', '', [rfReplaceAll]);    
  cleanText := StringReplace(cleanText, '.', '', [rfReplaceAll]);
  cleanText := LowerCase(cleanText);

  for i := 1 to Pred(cleanText.Length + 1) do
  begin
    c := cleanText[i];
    //Form1.Caption := c;
    if alphabet.Contains(c) then begin
      key_i := i mod cleanKey.Length; // индекс буквы в ключе | 0 = последний
      if key_i = 0 then
        key_c := cleanKey[cleanKey.Length]
      else
        key_c := cleanKey[key_i];
      //Form1.Caption := IntToStr(alphabet.IndexOf('g'));
      newC := alphabet[(alphabet.IndexOf(key_c) + alphabet.IndexOf(c)) mod 26 + 1];
      //sb.Append(key_c);
      //sb.Append('_')                                                                                                      ;
      //sb.Append(key_c)                        ;
      //sb.Append('|')                                                                                                      ;
      //sb.Append(c)                                                                                      ;
      //sb.Append('|')                                                                                                      ;
      //sb.Append((alphabet.IndexOf(key_c) + alphabet.IndexOf(c) + 1))  ;
      //sb.Append('|')                                                                                                      ;
      //sb.Append((alphabet.IndexOf(key_c) + alphabet.IndexOf(c) + 1) mod 27)
    end

    else
      newC := c;
    sb.Append(newC);
  end;
  Result := sb.ToString;
end;

function Vigenere.Decrypt(text : String; key : String) : String;
var
  i : Integer;
  c : Char;
  newC : String;
  sb : TStringBuilder;
  cleanText : String;
  cleanKey : String;
  key_i : Integer;
  key_c : Char;
  q : Integer;
begin
  sb := TStringBuilder.Create();
  for c in Trim(key) do
  begin
    if alphabet.Contains(c) then
      sb.Append(c)
    else
    begin
      ShowMessage('Incorrect key');
      Exit;
    end;
  end;
  cleanKey := sb.ToString;

  sb:=TStringBuilder.Create();
  cleanText := StringReplace(text, LineEnding, '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ' ', '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ',', '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, '.', '', [rfReplaceAll]);
  cleanText := LowerCase(cleanText);

  for i := 1 to Pred(cleanText.Length + 1) do
  begin
    c := cleanText[i];
    //Form1.Caption := c;
    if alphabet.Contains(c) then begin
      key_i := i mod cleanKey.Length; // индекс буквы в ключе | 0 = последний
      if key_i = 0 then
        key_c := cleanKey[cleanKey.Length]
      else
        key_c := cleanKey[key_i];

      q := alphabet.IndexOf(c) - alphabet.IndexOf(key_c);
      if q < 0 then
        q := 26 + alphabet.IndexOf(c) - alphabet.IndexOf(key_c);

      //Form1.Caption := IntToStr(alphabet.IndexOf('g'));
      newC := alphabet[q mod 26 + 1];
      //sb.Append(key_c);
      //sb.Append('_')                                                                                                      ;
      //sb.Append(key_c)                        ;
      //sb.Append('|')                                                                                                      ;
      //sb.Append(c)                                                                                      ;
      //sb.Append('|')                                                                                                      ;
      //sb.Append((alphabet.IndexOf(key_c) + alphabet.IndexOf(c) + 1))  ;
      //sb.Append('|')                                                                                                      ;
      //sb.Append((alphabet.IndexOf(key_c) + alphabet.IndexOf(c) + 1) mod 27)
    end

    else
      newC := c;
    sb.Append(newC);
  end;
  Result := sb.ToString;
end;

{ FrequencyCryptanalysis }

Constructor FrequencyCryptanalysis.Create;
begin
  name := 'Frequency Analysis';
end;

function FrequencyCryptanalysis.Encrypt(text : String; key : String) : String;
var
  i : Integer;
  c : Char;
  newC : String;
  sb : TStringBuilder;
  cleanText : String;
  cleanKey : String;
  key_i : Integer;
  key_c : Char;
  frequencies: array[1..27] of Float;
begin
  cleanText := StringReplace(text, LineEnding, '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ' ', '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, ',', '', [rfReplaceAll]);
  cleanText := StringReplace(cleanText, '.', '', [rfReplaceAll]);
  cleanText := LowerCase(cleanText);

  sb := TStringBuilder.Create();

  for i := 1 to Pred(alphabet.Length + 1) do
  begin
    frequencies[i] := (text.Length - (StringReplace(text, alphabet[i], '', [rfReplaceAll])).Length) / text.Length;
    if frequencies[i] <> 0 then
    begin
      sb.Append(alphabet[i]);
      sb.Append(': ');
      sb.Append(FloatToStr(SimpleRoundTo(frequencies[i]* 100, -2)));
      sb.Append('%');
      sb.Append(LineEnding);
    end;
  end;
  Result := sb.ToString;
end;

function FrequencyCryptanalysis.Decrypt(text : String; key : String) : String;
begin
  Result := Encrypt(text, key)
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Form1.Caption := 'penis' + LineEnding + 'penis penis';
end;

procedure TForm1.OptionClick(Sender: TObject);
var
  c: Caesar;
  a: Affine;
  v: Vigenere;
  f: FrequencyCryptanalysis;
begin
  c := Caesar.Create;
  a := Affine.Create;
  v := Vigenere.Create;
  f := FrequencyCryptanalysis.Create;

  case Option.ItemIndex of
    0: LabelName.Caption := c.name;
    1: LabelName.Caption := a.name;
    2: LabelName.Caption := v.name;
    3: LabelName.Caption := f.name;
  end;
end;

procedure TForm1.SpeedButtonCopyClick(Sender: TObject);
begin
  MemoResult.SelectAll;
  MemoResult.CopyToClipboard;
end;

procedure TForm1.SpeedButtonDecryptClick(Sender: TObject);
var
  c: Caesar; 
  a: Affine;
  v: Vigenere; 
  f: FrequencyCryptanalysis;   
  //Ciphers: array [0..4] of Cipher = (Caesar.Create as Cipher, Affine.Create as Cipher, Vigenere.Create as Cipher, FrequencyCryptanalysis.Create as Cipher);
begin
  case Option.ItemIndex of
    0: MemoResult.Text := c.Decrypt(MemoOrigin.Text, EditKey.Text);
    1: MemoResult.Text := a.Decrypt(MemoOrigin.Text, EditKey.Text);
    2: MemoResult.Text := v.Decrypt(MemoOrigin.Text, EditKey.Text);
    3: MemoResult.Text := f.Decrypt(MemoOrigin.Text, EditKey.Text);
  end;
  //MemoResult.Text := Ciphers[Option.ItemIndex].Decrypt(MemoOrigin.Text, EditKey.Text);
end;



procedure TForm1.SpeedButtonEncryptClick(Sender: TObject);
var
  c: Caesar;
  a: Affine;
  v: Vigenere;
  f: FrequencyCryptanalysis;
begin
  case Option.ItemIndex of
    0: MemoResult.Text := c.Encrypt(MemoOrigin.Text, EditKey.Text);
    1: MemoResult.Text := a.Encrypt(MemoOrigin.Text, EditKey.Text);
    2: MemoResult.Text := v.Encrypt(MemoOrigin.Text, EditKey.Text);
    3: MemoResult.Text := f.Encrypt(MemoOrigin.Text, EditKey.Text);
  end;
  //MemoResult.Text := Ciphers[Option.ItemIndex].Encrypt(MemoOrigin.Text, EditKey.Text);

end;

procedure TForm1.SpeedButtonOpenFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    MemoOrigin.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TForm1.SpeedButtonSaveToFileClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    MemoResult.Lines.SaveToFile(SaveDialog.FileName);
end;

end.

