unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, FileAccess, OAuth2, JsonObject, Winapi.ShellAPI, Vcl.OleCtrls,
  SHDocVw, Http, BinData, StringBuilder, HttpResponse, Vcl.Buttons, Vcl.Mask,
  Vcl.DBCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBox4: TGroupBox;
    SpeedButton2: TSpeedButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    IDConta: PWideChar;
    function ValidarEMail(aStr: string): Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  oauth2: HCkOAuth2;
  success: Boolean;
  url: PWideChar;
  numMsWaited: Integer;
  json: HCkJsonObject;
  fac: HCkFileAccess;
  http: HCkHttp;
  jsonToken: HCkJsonObject;
  jsonUserData: HCkJsonObject;
  resp: HCkHttpResponse;
  jResp: HCkJsonObject;
  respStatusCode: Integer;
  envelopeId: PWideChar;
  uri: PWideChar;
  statusDateTime: PWideChar;
  status: PWideChar;
  sbResponseBody: HCkStringBuilder;
  account_id: PWideChar;
  is_default: Boolean;
  account_name: PWideChar;
  base_uri: PWideChar;
  sub: PWideChar;
  name: PWideChar;
  given_name: PWideChar;
  family_name: PWideChar;
  created: PWideChar;
  email: PWideChar;
  i: Integer;
  count_i: Integer;
begin
  try
   //{FAZ AUTORIZAÇÃO NO DOCUSIGN}

  // This example requires the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

    oauth2 := CkOAuth2_Create();

// This should be the port in the localhost Redirect URI for your app defined in the Docusign developer portal.
// The Redirect URI would look like "http://localhost:3017/" if the port number is 3017.
    CkOAuth2_putListenPort(oauth2, 3017);

// For the developer sandbox environment, the authorization endpoint is https://account-d.docusign.com/oauth/auth
// For the production platform, the authorization endpoint is https://account.docusign.com/oauth/auth
    CkOAuth2_putAuthorizationEndpoint(oauth2, 'https://account-d.docusign.com/oauth/auth');
    CkOAuth2_putTokenEndpoint(oauth2, 'https://account-d.docusign.com/oauth/token');

// Replace these with actual values.
// The client ID is also known as the "integration key" in Docusign.
    CkOAuth2_putClientId(oauth2, '634515ef-c43b-4150-bd6b-c53755e443df');
// This is your secret key for the authorization code grant.
    CkOAuth2_putClientSecret(oauth2, '5a920656-24ba-46ec-b20f-90de18dc6bb8');

    CkOAuth2_putScope(oauth2, 'signature');

// Begin the OAuth2 three-legged flow.  This returns a URL that should be loaded in a browser.
    url := CkOAuth2__startAuth(oauth2);
    if (CkOAuth2_getLastMethodSuccess(oauth2) <> True) then
    begin
      Memo1.Lines.Add(CkOAuth2__lastErrorText(oauth2));
      Exit;
    end;

// At this point, your application should load the URL in a browser.
// Add the code to load the url in a web browser here...
    ShellExecute(Handle, 'open', url, nil, nil, SW_SHOWMAXIMIZED);

// Now wait for the authorization.
// We'll wait for a max of 30 seconds.
    numMsWaited := 0;
    while (numMsWaited < 30000) and (CkOAuth2_getAuthFlowState(oauth2) < 3) do
    begin
      CkOAuth2_SleepMs(oauth2, 100);
      numMsWaited := numMsWaited + 100;
    end;

// If there was no response from the browser within 30 seconds, then
// the AuthFlowState will be equal to 1 or 2.
// 1: Waiting for Redirect. The OAuth2 background thread is waiting to receive the redirect HTTP request from the browser.
// 2: Waiting for Final Response. The OAuth2 background thread is waiting for the final access token response.
// In that case, cancel the background task started in the call to StartAuth.
    if (CkOAuth2_getAuthFlowState(oauth2) < 3) then
    begin
      CkOAuth2_Cancel(oauth2);
      Memo1.Lines.Add('No response from the browser!');
      Exit;
    end;

// Check the AuthFlowState to see if authorization was granted, denied, or if some error occurred
// The possible AuthFlowState values are:
// 3: Completed with Success. The OAuth2 flow has completed, the background thread exited, and the successful JSON response is available in AccessTokenResponse property.
// 4: Completed with Access Denied. The OAuth2 flow has completed, the background thread exited, and the error JSON is available in AccessTokenResponse property.
// 5: Failed Prior to Completion. The OAuth2 flow failed to complete, the background thread exited, and the error information is available in the FailureInfo property.
    if (CkOAuth2_getAuthFlowState(oauth2) = 5) then
    begin
      Memo1.Lines.Add('OAuth2 failed to complete.');
      Memo1.Lines.Add(CkOAuth2__failureInfo(oauth2));
      Exit;
    end;

    if (CkOAuth2_getAuthFlowState(oauth2) = 4) then
    begin
      Memo1.Lines.Add('OAuth2 authorization was denied.');
      Memo1.Lines.Add(CkOAuth2__accessTokenResponse(oauth2));
      Exit;
    end;

    if (CkOAuth2_getAuthFlowState(oauth2) <> 3) then
    begin
      Memo1.Lines.Add('Unexpected AuthFlowState:' + IntToStr(CkOAuth2_getAuthFlowState(oauth2)));
      Exit;
    end;

    Memo1.Lines.Add('OAuth2 authorization granted!');
    Memo1.Lines.Add('Access Token = ' + CkOAuth2__accessToken(oauth2));

// Get the full JSON response:
    json := CkJsonObject_Create();
    CkJsonObject_Load(json, CkOAuth2__accessTokenResponse(oauth2));
    CkJsonObject_putEmitCompact(json, False);
    Memo1.Lines.Add(CkJsonObject__emit(json));

// The JSON response looks like this:

// {
//   "access_token": "eyJ0eXA....YQyig",
//   "token_type": "Bearer",
//   "refresh_token": "eyJ0eXA....auE3eHKg",
//   "expires_in": 28800
// }

// Save the JSON to a file for future requests.
    fac := CkFileAccess_Create();
    CkFileAccess_WriteEntireTextFile(fac, 'docusign.json', CkJsonObject__emit(json), 'utf-8', False);


  //{PEGA OS DADOS DO USUARIO}
  // This example assumes the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

    http := CkHttp_Create();

// Implements the following CURL command:

// curl --header "Authorization: Bearer eyJ0eXAi.....UE8Kl_V8KroQ" https://account-d.docusign.com/oauth/userinfo

// Use the following online tool to generate HTTP code from a CURL command
// Convert a cURL Command to HTTP Source Code

// Adds the "Authorization: Bearer eyJ0eXAi.....UE8Kl_V8KroQ" header.
    jsonToken := CkJsonObject_Create();
// Load a previously obtained OAuth2 access token.
    success := CkJsonObject_LoadFile(jsonToken, 'docusign.json');
    if (success = False) then
    begin
      Memo1.Lines.Add(CkJsonObject__lastErrorText(jsonToken));
      Exit;
    end;

    CkHttp_putAuthToken(http, CkJsonObject__stringOf(jsonToken, 'access_token'));

    sbResponseBody := CkStringBuilder_Create();
    success := CkHttp_QuickGetSb(http, 'https://account-d.docusign.com/oauth/userinfo', sbResponseBody);
    if (success = False) then
    begin
      Memo1.Lines.Add(CkHttp__lastErrorText(http));
      Exit;
    end;

    jResp := CkJsonObject_Create();
    CkJsonObject_LoadSb(jResp, sbResponseBody);
    CkJsonObject_putEmitCompact(jResp, False);

    Memo1.Lines.Add('Response Body:');
    Memo1.Lines.Add(CkJsonObject__emit(jResp));

    respStatusCode := CkHttp_getLastStatus(http);
    Memo1.Lines.Add('Response Status Code = ' + IntToStr(respStatusCode));
    if (respStatusCode >= 400) then
    begin
      Memo1.Lines.Add('Response Header:');
      Memo1.Lines.Add(CkHttp__lastHeader(http));
      Memo1.Lines.Add('Failed.');
      Exit;
    end;

// Sample JSON response:
// (Sample code for parsing the JSON response is shown below)

// {
//   "sub": "564f7988-xxxx-xxxx-xxxx-781ee556ab7a",
//   "name": "Example J Smith",
//   "given_name": "Example",
//   "family_name": "Smith",
//   "created": "2018-04-13T22:03:03.45",
//   "email": "Example.Smith@exampledomain.com",
//   "accounts": [
//     {
//       "account_id": "18b4799a-xxxx-xxxx-xxxx-b5b4b8a97604",
//       "is_default": true,
//       "account_name": "ExampleAccount",
//       "base_uri": "https://demo.docusign.net"
//     }
//   ]
// }

// Sample code for parsing the JSON response...
// Use the following online tool to generate parsing code from sample JSON:
// Generate Parsing Code from JSON

    sub := CkJsonObject__stringOf(jResp, 'sub');
    name := CkJsonObject__stringOf(jResp, 'name');
    given_name := CkJsonObject__stringOf(jResp, 'given_name');
    family_name := CkJsonObject__stringOf(jResp, 'family_name');
    created := CkJsonObject__stringOf(jResp, 'created');
    email := CkJsonObject__stringOf(jResp, 'email');
    i := 0;
    count_i := CkJsonObject_SizeOfArray(jResp, 'accounts');
    while i < count_i do
    begin
      CkJsonObject_putI(jResp, i);
      account_id := CkJsonObject__stringOf(jResp, 'accounts[i].account_id');
      is_default := CkJsonObject_BoolOf(jResp, 'accounts[i].is_default');
      account_name := CkJsonObject__stringOf(jResp, 'accounts[i].account_name');
      base_uri := CkJsonObject__stringOf(jResp, 'accounts[i].base_uri');

      i := i + 1;
    end;

    IDConta := CkJsonObject__stringOf(jResp, 'accounts[0].account_id');

    fac := CkFileAccess_Create();
    CkFileAccess_WriteEntireTextFile(fac, 'UserData.json', CkJsonObject__emit(jResp), 'utf-8', False);


  //{CRIA O ENVELOPE PARA ASSINATURA}
  // This example assumes the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

    http := CkHttp_Create();

// Load a previously obtained OAuth2 access token.
    jsonToken := CkJsonObject_Create();
    success := CkJsonObject_LoadFile(jsonToken, 'docusign.json');
    if (success = False) then
    begin
      Memo1.Lines.Add(CkJsonObject__lastErrorText(jsonToken));
      Exit;
    end;

// Adds the "Authorization: Bearer eyJ0eXAi.....UE8Kl_V8KroQ" header.
    CkHttp_putAuthToken(http, CkJsonObject__stringOf(jsonToken, 'access_token'));

// Send the following request.
// Make sure to use your own account ID (obtained from Get Docusign User Account Information)

// POST https://demo.docusign.net/restapi/v2.1/accounts/7f3f65ed-5e87-418d-94c1-92499ddc8252/envelopes HTTP/1.1
// Accept: application/json
// Cache-Control: no-cache
// Authorization: Bearer eyJ0eX...
// Content-Length: ...
// Content-Type: application/json
//
// {
//   "emailSubject": "Sign for Project XYZ Approval"
// }

    json := CkJsonObject_Create();
    CkJsonObject_UpdateString(json, 'emailSubject', 'Sign for Project XYZ Approval');

    CkHttp_SetRequestHeader(http, 'Cache-Control', 'no-cache');
    CkHttp_SetRequestHeader(http, 'Accept', 'application/json');

// Use your own account ID here.
    CkHttp_SetUrlVar(http, 'accountId', IDConta);

// PostJson automatically sets the Content-Type header to "application/json"
    resp := CkHttp_PostJson(http, 'https://demo.docusign.net/restapi/v2.1/accounts/{$accountId}/envelopes', CkJsonObject__emit(json));
    if (CkHttp_getLastMethodSuccess(http) = False) then
    begin
      Memo1.Lines.Add(CkHttp__lastErrorText(http));
      Exit;
    end;

    jResp := CkJsonObject_Create();
    CkJsonObject_Load(jResp, CkHttpResponse__bodyStr(resp));
    CkJsonObject_putEmitCompact(jResp, False);

    Memo1.Lines.Add('Response Body:');
    Memo1.Lines.Add(CkJsonObject__emit(jResp));

// If you get a 401 response status code, it's likely you need to refresh the DocuSign OAuth2 token).
    respStatusCode := CkHttpResponse_getStatusCode(resp);
    Memo1.Lines.Add('Response Status Code = ' + IntToStr(respStatusCode));
    if (respStatusCode >= 400) then
    begin
      Memo1.Lines.Add('Response Header:');
      Memo1.Lines.Add(CkHttpResponse__header(resp));
      Memo1.Lines.Add('Failed.');
      CkHttpResponse_Dispose(resp);
      Exit;
    end;
    CkHttpResponse_Dispose(resp);

// Sample JSON response:
// (Sample code for parsing the JSON response is shown below)

// {
//   "envelopeId": "4943126a-a6e0-40ca-8707-50f22bf3888c",
//   "uri": "/envelopes/4943126a-a6e0-40ca-8707-50f22bf3888c",
//   "statusDateTime": "2021-01-23T20:21:42.1400000Z",
//   "status": "created"
// }

// Sample code for parsing the JSON response...
// Use the following online tool to generate parsing code from sample JSON:
// Generate Parsing Code from JSON

    envelopeId := CkJsonObject__stringOf(jResp, 'envelopeId');
    uri := CkJsonObject__stringOf(jResp, 'uri');
    statusDateTime := CkJsonObject__stringOf(jResp, 'statusDateTime');
    status := CkJsonObject__stringOf(jResp, 'status');

    fac := CkFileAccess_Create();
    CkFileAccess_WriteEntireTextFile(fac, 'Envelope.json', CkJsonObject__emit(jResp), 'utf-8', False);

    GroupBox1.Enabled := True;
  finally
    CkHttp_Dispose(http);
    CkJsonObject_Dispose(jsonToken);
    CkJsonObject_Dispose(json);
    CkJsonObject_Dispose(jResp);
    CkStringBuilder_Dispose(sbResponseBody);
    CkOAuth2_Dispose(oauth2);
    CkFileAccess_Dispose(fac);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  http: HCkHttp;
  success: Boolean;
  pdfData: HCkBinData;
  json: HCkJsonObject;
  jsonToken: HCkJsonObject;
  jsonUser : HCkJsonObject;
  jsonEnvelope: HCkJsonObject;
  sbAuth: HCkStringBuilder;
  resp: HCkHttpResponse;
  sbResponseBody: HCkStringBuilder;
  jResp: HCkJsonObject;
  respStatusCode: Integer;
  envelopeId: PWideChar;
  uri: PWideChar;
  statusDateTime: PWideChar;
  status: PWideChar;
  IDConta: PWideChar;
begin
 // This example assumes the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

  http := CkHttp_Create();

// Implements the following CURL command:

// curl --request POST https://demo.docusign.net/restapi/v2.1/accounts/${accountId}/envelopes \
//      --header "Authorization: Bearer ${accessToken}" \
//      --header "Content-Type: application/json" \
//      --data '{
//     "emailSubject": "Please sign this document",
//     "documents": [
//         {
//             "documentBase64": "JVBERi0xLjMKMyAwIG9iag ... dGFydHhyZWYKNjk5CiUlRU9GCg==",
//             "name": "Lorem Ipsum",
//             "fileExtension": "pdf",
//             "documentId": "1"
//         }
//     ],
//     "recipients": {
//         "signers": [
//             {
//                 "email": "joe_sample@example.com",
//                 "name": "Joe Sample",
//                 "recipientId": "1",
//                 "routingOrder": "1",
//                 "tabs": {
//                     "signHereTabs": [
//                         {
//                             "documentId": "1", "pageNumber": "1",
//                             "recipientId": "1", "tabLabel": "SignHereTab",
//                             "xPosition": "195", "yPosition": "147"
//                         }
//                     ]
//                 }
//             }
//         ]
//     },
//     "status": "sent"
// }'

// Use this online tool to generate code from sample JSON:
// Generate Code to Create JSON

// The following JSON is sent in the request body.

// {
//   "emailSubject": "Please sign this document",
//   "documents": [
//     {
//       "documentBase64": "JVBERi0xLjMKMyAwIG9iag ... dGFydHhyZWYKNjk5CiUlRU9GCg==",
//       "name": "Lorem Ipsum",
//       "fileExtension": "pdf",
//       "documentId": "1"
//     }
//   ],
//   "recipients": {
//     "signers": [
//       {
//         "email": "joe_sample@example.com",
//         "name": "Joe Sample",
//         "recipientId": "1",
//         "routingOrder": "1",
//         "tabs": {
//           "signHereTabs": [
//             {
//               "documentId": "1",
//               "pageNumber": "1",
//               "recipientId": "1",
//               "tabLabel": "SignHereTab",
//               "xPosition": "195",
//               "yPosition": "147"
//             }
//           ]
//         }
//       }
//     ]
//   },
//   "status": "sent"
// }

// Load a PDF to be signed.
  pdfData := CkBinData_Create();
  success := CkBinData_LoadFile(pdfData, PWideChar(Edit1.Text));
  if (success = False) then
  begin
    Memo1.Lines.Add('Failed to load local PDF file.');
    Exit;
  end;

  json := CkJsonObject_Create();
  CkJsonObject_UpdateString(json, 'emailSubject', 'Please sign this document');
  CkJsonObject_UpdateString(json, 'documents[0].documentBase64', CkBinData__getEncoded(pdfData, 'base64'));
  CkJsonObject_UpdateString(json, 'documents[0].name', 'Lorem Ipsum');
  CkJsonObject_UpdateString(json, 'documents[0].fileExtension', 'pdf');
  CkJsonObject_UpdateString(json, 'documents[0].documentId', '1');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].email', pWideChar(Edit2.Text));
  CkJsonObject_UpdateString(json, 'recipients.signers[0].name', 'Joe Sample');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].recipientId', '1');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].routingOrder', '1');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].tabs.signHereTabs[0].documentId', '1');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].tabs.signHereTabs[0].pageNumber', '1');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].tabs.signHereTabs[0].recipientId', '1');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].tabs.signHereTabs[0].tabLabel', 'SignHereTab');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].tabs.signHereTabs[0].xPosition', '195');
  CkJsonObject_UpdateString(json, 'recipients.signers[0].tabs.signHereTabs[0].yPosition', '147');
  CkJsonObject_UpdateString(json, 'status', 'sent');

// Get our previously obtained OAuth2 access token, which should contain JSON like this:
// {
//   "access_token": "eyJ0eXA....YQyig",
//   "token_type": "Bearer",
//   "refresh_token": "eyJ0eXA....auE3eHKg",
//   "expires_in": 28800
// }

  jsonToken := CkJsonObject_Create();
  success := CkJsonObject_LoadFile(jsonToken, 'docusign.json');
  if (success = False) then
  begin
    Memo1.Lines.Add(CkJsonObject__lastErrorText(jsonToken));
    Exit;
  end;

  jsonUser := CkJsonObject_Create();
  success := CkJsonObject_LoadFile(jsonUser, 'UserData.json');
  if (success = False) then
  begin
    Memo1.Lines.Add(CkJsonObject__lastErrorText(jsonUser));
    Exit;
  end;

  jsonEnvelope := CkJsonObject_Create();
  success := CkJsonObject_LoadFile(jsonEnvelope, 'Envelope.json');
  if (success = False) then
  begin
    Memo1.Lines.Add(CkJsonObject__lastErrorText(jsonEnvelope));
    Exit;
  end;

  sbAuth := CkStringBuilder_Create();
  CkStringBuilder_Append(sbAuth, 'Bearer ');
  CkStringBuilder_Append(sbAuth, CkJsonObject__stringOf(jsonToken, 'access_token'));

  CkHttp_SetRequestHeader(http, 'Authorization', CkStringBuilder__getAsString(sbAuth));
  CkHttp_SetRequestHeader(http, 'Content-Type', 'application/json');

// Use your own account ID here.
  IDConta := CkJsonObject__stringOf(jsonUser, 'accounts[0].account_id');

// Don't forget to modify this line to use your account ID
  resp := CkHttp_PostJson3(http, PWideChar('https://demo.docusign.net/restapi/v2.1/accounts/'+IDConta+'/envelopes'), 'application/json', json);
  if (CkHttp_getLastMethodSuccess(http) = False) then
  begin
    Memo1.Lines.Add(CkHttp__lastErrorText(http));
    Exit;
  end;

  sbResponseBody := CkStringBuilder_Create();
  CkHttpResponse_GetBodySb(resp, sbResponseBody);
  jResp := CkJsonObject_Create();
  CkJsonObject_LoadSb(jResp, sbResponseBody);
  CkJsonObject_putEmitCompact(jResp, False);

  Memo1.Lines.Add('Response Body:');
  Memo1.Lines.Add(CkJsonObject__emit(jResp));

  respStatusCode := CkHttpResponse_getStatusCode(resp);
  Memo1.Lines.Add('Response Status Code = ' + IntToStr(respStatusCode));
  if (respStatusCode >= 400) then
  begin
    Memo1.Lines.Add('Response Header:');
    Memo1.Lines.Add(CkHttpResponse__header(resp));
    Memo1.Lines.Add('Failed.');
    CkHttpResponse_Dispose(resp);
    Exit;
  end;
  CkHttpResponse_Dispose(resp);

// Sample JSON response:
// (Sample code for parsing the JSON response is shown below)

// {
//   "envelopeId": "d51cfdab-22ed-4832-bf68-446c44077ffc",
//   "uri": "/envelopes/d51cfdab-22ed-4832-bf68-446c44077ffc",
//   "statusDateTime": "2018-04-17T16:31:51.8830000Z",
//   "status": "sent"
// }

// Sample code for parsing the JSON response...
// Use the following online tool to generate parsing code from sample JSON:
// Generate Parsing Code from JSON

  envelopeId := CkJsonObject__stringOf(jResp, 'envelopeId');
  uri := CkJsonObject__stringOf(jResp, 'uri');
  statusDateTime := CkJsonObject__stringOf(jResp, 'statusDateTime');
  status := CkJsonObject__stringOf(jResp, 'status');

  CkHttp_Dispose(http);
  CkBinData_Dispose(pdfData);
  CkJsonObject_Dispose(json);
  CkJsonObject_Dispose(jsonToken);
  CkStringBuilder_Dispose(sbAuth);
  CkStringBuilder_Dispose(sbResponseBody);
  CkJsonObject_Dispose(jResp);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit1.Text := OpenDialog1.FileName;
    Button2.Enabled := Edit1.Text <> '';
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  http: HCkHttp;
  jsonToken: HCkJsonObject;
  jsonUser: HCkJsonObject;
  jsonEnvelope: HCkJsonObject;
  success: Boolean;
  json: HCkJsonObject;
  i: Integer;
  sbJson: HCkStringBuilder;
  url: PWideChar;
  resp: HCkHttpResponse;
  jResp: HCkJsonObject;
  respStatusCode: Integer;
  creationReason: PWideChar;
  requireUploadSignature: PWideChar;
  email: PWideChar;
  recipientId: PWideChar;
  requireIdLookup: PWideChar;
  routingOrder: PWideChar;
  status: PWideChar;
  completedCount: PWideChar;
  deliveryMethod: PWideChar;
  recipientType: PWideChar;
  recipientCount: PWideChar;
  count_i: Integer;
begin
  if not ValidarEMail(Edit2.Text) then
    exit;

  // This example assumes the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

  http := CkHttp_Create();

// Load a previously obtained OAuth2 access token.
  jsonToken := CkJsonObject_Create();
  success := CkJsonObject_LoadFile(jsonToken, 'docusign.json');
  if (success = False) then
  begin
    Memo1.Lines.Add(CkJsonObject__lastErrorText(jsonToken));
    Exit;
  end;

  jsonUser := CkJsonObject_Create();
  success := CkJsonObject_LoadFile(jsonUser, 'UserData.json');
  if (success = False) then
  begin
    Memo1.Lines.Add(CkJsonObject__lastErrorText(jsonUser));
    Exit;
  end;

  jsonEnvelope := CkJsonObject_Create();
  success := CkJsonObject_LoadFile(jsonEnvelope, 'Envelope.json');
  if (success = False) then
  begin
    Memo1.Lines.Add(CkJsonObject__lastErrorText(jsonEnvelope));
    Exit;
  end;

// Adds the "Authorization: Bearer eyJ0eXAi.....UE8Kl_V8KroQ" header.
  CkHttp_putAuthToken(http, CkJsonObject__stringOf(jsonToken, 'access_token'));

// Send the following request.
// Make sure to use your own account ID (obtained from Get Docusign User Account Information)

// POST https://demo.docusign.net/restapi/v2.1/accounts/<account ID>/envelopes/<envelope ID>/recipients HTTP/1.1
// Accept: application/json
// Cache-Control: no-cache
// Authorization: Bearer eyJ0eX...
// Content-Length: ...
// Content-Type: application/json
//
// {
//   "carbonCopies": [
//     {
//       "email": "support@chilkatsoft.com",
//       "name": "Chilkat Support",
//       "recipientId": "101",
//       "tabs": {}
//     }
//   ],
//   "signers": [
//     {
//       "email": "admin@chilkatsoft.com",
//       "name": "Chilkat Admin",
//       "recipientId": "1",
// 	 "tabs": {
// 	    "signHereTabs": [{
// 	        "anchorString": "Please Sign Here",
// 	        "anchorXOffset": "1",
// 	        "anchorYOffset": "0",
// 	        "anchorIgnoreIfNotPresent": "false",
// 	        "anchorUnits": "inches"
// 	    }]
// 	}
//     },
//     {
//       "email": "matt@chilkat.io",
//       "name": "Matt",
//       "recipientId": "2",
// 	 "tabs": {
// 	    "signHereTabs": [{
// 	        "anchorString": "Please Also Sign Here",
// 	        "anchorXOffset": "1",
// 	        "anchorYOffset": "0",
// 	        "anchorIgnoreIfNotPresent": "false",
// 	        "anchorUnits": "inches"
// 	    }]
// 	}
//     }
//   ]
// }

  json := CkJsonObject_Create();
  i := 0;
  CkJsonObject_putI(json, i);
  CkJsonObject_UpdateString(json, 'signers[i].email', pWideChar(Edit2.Text));
  CkJsonObject_UpdateString(json, 'signers[i].name', 'Teste de Signatário');
  CkJsonObject_UpdateString(json, 'signers[i].recipientId', '1');
  CkJsonObject_UpdateString(json, 'signers[i].tabs.signHereTabs[0].anchorString', 'Please Sign Here');
  CkJsonObject_UpdateString(json, 'signers[i].tabs.signHereTabs[0].anchorXOffset', '1');
  CkJsonObject_UpdateString(json, 'signers[i].tabs.signHereTabs[0].anchorYOffset', '0');
  CkJsonObject_UpdateString(json, 'signers[i].tabs.signHereTabs[0].anchorIgnoreIfNotPresent', 'false');
  CkJsonObject_UpdateString(json, 'signers[i].tabs.signHereTabs[0].anchorUnits', 'inches');

  sbJson := CkStringBuilder_Create();
  CkJsonObject_putEmitCompact(json, False);
  CkJsonObject_EmitSb(json, sbJson);

  CkHttp_SetRequestHeader(http, 'Cache-Control', 'no-cache');
  CkHttp_SetRequestHeader(http, 'Accept', 'application/json');

// Use your own account ID here.
  CkHttp_SetUrlVar(http, 'accountId', CkJsonObject__stringOf(jsonUser, 'accounts[0].account_id'));
// Use the envelope ID returned by DocuSign when creating the draft envelope).
  CkHttp_SetUrlVar(http, 'envelopeId', CkJsonObject__stringOf(jsonEnvelope, 'envelopeId'));

  url := 'https://demo.docusign.net/restapi/v2.1/accounts/{$accountId}/envelopes/{$envelopeId}/recipients';
  resp := CkHttp_PTextSb(http, 'POST', url, sbJson, 'utf-8', 'application/json', False, False);
  if (CkHttp_getLastMethodSuccess(http) = False) then
  begin
    Memo1.Lines.Add(CkHttp__lastErrorText(http));
    Exit;
  end;

  jResp := CkJsonObject_Create();
  CkJsonObject_Load(jResp, CkHttpResponse__bodyStr(resp));
  CkJsonObject_putEmitCompact(jResp, False);

  Memo1.Lines.Add('Response Body:');
  Memo1.Lines.Add(CkJsonObject__emit(jResp));

// If you get a 401 response status code, it's likely you need to refresh the DocuSign OAuth2 token).
  respStatusCode := CkHttpResponse_getStatusCode(resp);
  Memo1.Lines.Add('Response Status Code = ' + IntToStr(respStatusCode));
  if (respStatusCode >= 400) then
  begin
    Memo1.Lines.Add('Response Header:');
    Memo1.Lines.Add(CkHttpResponse__header(resp));
    Memo1.Lines.Add('Failed.');
    CkHttpResponse_Dispose(resp);
    Exit;
  end;
  CkHttpResponse_Dispose(resp);

// Sample JSON response:
// (Sample code for parsing the JSON response is shown below)

// {
//     "signers": [
//         {
//             "creationReason": "sender",
//             "requireUploadSignature": "false",
//             "email": "admin@chilkatsoft.com",
//             "recipientId": "1",
//             "requireIdLookup": "false",
//             "routingOrder": "1",
//             "status": "created",
//             "completedCount": "0",
//             "deliveryMethod": "email",
//             "recipientType": "signer"
//         },
//         {
//             "creationReason": "sender",
//             "requireUploadSignature": "false",
//             "email": "matt@chilkat.io",
//             "recipientId": "2",
//             "requireIdLookup": "false",
//             "routingOrder": "1",
//             "status": "created",
//             "completedCount": "0",
//             "deliveryMethod": "email",
//             "recipientType": "signer"
//         }
//     ],
//     "agents": [],
//     "editors": [],
//     "intermediaries": [],
//     "carbonCopies": [
//         {
//             "email": "support@chilkatsoft.com",
//             "recipientId": "101",
//             "requireIdLookup": "false",
//             "routingOrder": "1",
//             "status": "created",
//             "completedCount": "0",
//             "deliveryMethod": "email",
//             "recipientType": "carboncopy"
//         }
//     ],
//     "certifiedDeliveries": [],
//     "inPersonSigners": [],
//     "seals": [],
//     "witnesses": [],
//     "recipientCount": "3"
// }

// Sample code for parsing the JSON response...
// Use the following online tool to generate parsing code from sample JSON:
// Generate Parsing Code from JSON

  recipientCount := CkJsonObject__stringOf(json, 'recipientCount');
  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'signers');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    creationReason := CkJsonObject__stringOf(json, 'signers[i].creationReason');
    requireUploadSignature := CkJsonObject__stringOf(json, 'signers[i].requireUploadSignature');
    email := CkJsonObject__stringOf(json, 'signers[i].email');
    recipientId := CkJsonObject__stringOf(json, 'signers[i].recipientId');
    requireIdLookup := CkJsonObject__stringOf(json, 'signers[i].requireIdLookup');
    routingOrder := CkJsonObject__stringOf(json, 'signers[i].routingOrder');
    status := CkJsonObject__stringOf(json, 'signers[i].status');
    completedCount := CkJsonObject__stringOf(json, 'signers[i].completedCount');
    deliveryMethod := CkJsonObject__stringOf(json, 'signers[i].deliveryMethod');
    recipientType := CkJsonObject__stringOf(json, 'signers[i].recipientType');
    i := i + 1;
  end;

  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'agents');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    //    ...
    i := i + 1;
  end;

  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'editors');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    //    ...
    i := i + 1;
  end;

  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'intermediaries');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    //    ...
    i := i + 1;
  end;

  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'carbonCopies');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    email := CkJsonObject__stringOf(json, 'carbonCopies[i].email');
    recipientId := CkJsonObject__stringOf(json, 'carbonCopies[i].recipientId');
    requireIdLookup := CkJsonObject__stringOf(json, 'carbonCopies[i].requireIdLookup');
    routingOrder := CkJsonObject__stringOf(json, 'carbonCopies[i].routingOrder');
    status := CkJsonObject__stringOf(json, 'carbonCopies[i].status');
    completedCount := CkJsonObject__stringOf(json, 'carbonCopies[i].completedCount');
    deliveryMethod := CkJsonObject__stringOf(json, 'carbonCopies[i].deliveryMethod');
    recipientType := CkJsonObject__stringOf(json, 'carbonCopies[i].recipientType');
    i := i + 1;
  end;

  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'certifiedDeliveries');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    //    ...
    i := i + 1;
  end;

  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'inPersonSigners');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    //    ...
    i := i + 1;
  end;

  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'seals');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    //    ...
    i := i + 1;
  end;

  i := 0;
  count_i := CkJsonObject_SizeOfArray(json, 'witnesses');
  while i < count_i do
  begin
    CkJsonObject_putI(json, i);
    //    ...
    i := i + 1;
  end;

// If the recipient already exists within the envelope, we would get
// a success (201) response status code, but errors within the JSON response, such as this:

// {
//   "signers": [
//     {
//       "creationReason": "sender",
//       "requireUploadSignature": "false",
//       "email": "admin@chilkatsoft.com",
//       "recipientId": "1",
//       "requireIdLookup": "false",
//       "routingOrder": "1",
//       "status": "error",
//       "completedCount": "0",
//       "deliveryMethod": "email",
//       "errorDetails": {
//         "errorCode": "RECIPIENT_ALREADY_EXISTS_IN_ENVELOPE",
//         "message": "This recipientId already exists."
//       },
//       "recipientType": "signer"
//     },
//     {
//       "creationReason": "sender",
//       "requireUploadSignature": "false",
//       "email": "matt@chilkat.io",
//       "recipientId": "2",
//       "requireIdLookup": "false",
//       "routingOrder": "1",
//       "status": "error",
//       "completedCount": "0",
//       "deliveryMethod": "email",
//       "errorDetails": {
//         "errorCode": "RECIPIENT_ALREADY_EXISTS_IN_ENVELOPE",
//         "message": "This recipientId already exists."
//       },
//       "recipientType": "signer"
//     }
//   ],
//   "agents": [
//   ],
//   "editors": [
//   ],
//   "intermediaries": [
//   ],
//   "carbonCopies": [
//     {
//       "email": "support@chilkatsoft.com",
//       "recipientId": "101",
//       "requireIdLookup": "false",
//       "routingOrder": "1",
//       "status": "error",
//       "completedCount": "0",
//       "deliveryMethod": "email",
//       "errorDetails": {
//         "errorCode": "RECIPIENT_ALREADY_EXISTS_IN_ENVELOPE",
//         "message": "This recipientId already exists."
//       },
//       "recipientType": "carboncopy"
//     }
//   ],
//   "certifiedDeliveries": [
//   ],
//   "inPersonSigners": [
//   ],
//   "seals": [
//   ],
//   "witnesses": [
//   ],
//   "recipientCount": "3"
// }
//

  CkHttp_Dispose(http);
  CkJsonObject_Dispose(jsonToken);
  CkJsonObject_Dispose(json);
  CkStringBuilder_Dispose(sbJson);
  CkJsonObject_Dispose(jResp);
end;

function TForm1.ValidarEMail(aStr: string): Boolean;
begin
  aStr := Trim(UpperCase(aStr));
  if Pos('@', aStr) > 1 then
  begin
    Delete(aStr, 1, pos('@', aStr));
    Result := (Length(aStr) > 0) and (Pos('.', aStr) > 2);
  end
  else
    Result := False;
end;

end.

