unit Pkcs11;

interface

type

HCkPkcs11 = Pointer;
HCkCert = Pointer;
HCkJsonObject = Pointer;
HCkString = Pointer;


function CkPkcs11_Create: HCkPkcs11; stdcall;
procedure CkPkcs11_Dispose(handle: HCkPkcs11); stdcall;
procedure CkPkcs11_getDebugLogFilePath(objHandle: HCkPkcs11; outPropVal: HCkString); stdcall;

procedure CkPkcs11_putDebugLogFilePath(objHandle: HCkPkcs11; newPropVal: PWideChar); stdcall;

function CkPkcs11__debugLogFilePath(objHandle: HCkPkcs11): PWideChar; stdcall;

procedure CkPkcs11_getLastErrorHtml(objHandle: HCkPkcs11; outPropVal: HCkString); stdcall;

function CkPkcs11__lastErrorHtml(objHandle: HCkPkcs11): PWideChar; stdcall;

procedure CkPkcs11_getLastErrorText(objHandle: HCkPkcs11; outPropVal: HCkString); stdcall;

function CkPkcs11__lastErrorText(objHandle: HCkPkcs11): PWideChar; stdcall;

procedure CkPkcs11_getLastErrorXml(objHandle: HCkPkcs11; outPropVal: HCkString); stdcall;

function CkPkcs11__lastErrorXml(objHandle: HCkPkcs11): PWideChar; stdcall;

function CkPkcs11_getLastMethodSuccess(objHandle: HCkPkcs11): wordbool; stdcall;

procedure CkPkcs11_putLastMethodSuccess(objHandle: HCkPkcs11; newPropVal: wordbool); stdcall;

function CkPkcs11_getNumCerts(objHandle: HCkPkcs11): Integer; stdcall;

procedure CkPkcs11_getSharedLibPath(objHandle: HCkPkcs11; outPropVal: HCkString); stdcall;

procedure CkPkcs11_putSharedLibPath(objHandle: HCkPkcs11; newPropVal: PWideChar); stdcall;

function CkPkcs11__sharedLibPath(objHandle: HCkPkcs11): PWideChar; stdcall;

function CkPkcs11_getVerboseLogging(objHandle: HCkPkcs11): wordbool; stdcall;

procedure CkPkcs11_putVerboseLogging(objHandle: HCkPkcs11; newPropVal: wordbool); stdcall;

procedure CkPkcs11_getVersion(objHandle: HCkPkcs11; outPropVal: HCkString); stdcall;

function CkPkcs11__version(objHandle: HCkPkcs11): PWideChar; stdcall;

function CkPkcs11_CloseSession(objHandle: HCkPkcs11): wordbool; stdcall;

function CkPkcs11_Discover(objHandle: HCkPkcs11; onlyTokensPresent: wordbool; json: HCkJsonObject): wordbool; stdcall;

function CkPkcs11_FindAllCerts(objHandle: HCkPkcs11): wordbool; stdcall;

function CkPkcs11_FindCert(objHandle: HCkPkcs11; certPart: PWideChar; partValue: PWideChar; cert: HCkCert): wordbool; stdcall;

function CkPkcs11_GetCert(objHandle: HCkPkcs11; index: Integer; cert: HCkCert): wordbool; stdcall;

function CkPkcs11_Initialize(objHandle: HCkPkcs11): wordbool; stdcall;

function CkPkcs11_InitPin(objHandle: HCkPkcs11; pin: PWideChar): wordbool; stdcall;

function CkPkcs11_InitToken(objHandle: HCkPkcs11; slotId: Integer; pin: PWideChar; tokenLabel: PWideChar): wordbool; stdcall;

function CkPkcs11_Login(objHandle: HCkPkcs11; userType: Integer; pin: PWideChar): wordbool; stdcall;

function CkPkcs11_Logout(objHandle: HCkPkcs11): wordbool; stdcall;

function CkPkcs11_OpenSession(objHandle: HCkPkcs11; slotId: Integer; readWrite: wordbool): wordbool; stdcall;

function CkPkcs11_SaveLastError(objHandle: HCkPkcs11; path: PWideChar): wordbool; stdcall;

function CkPkcs11_SetPin(objHandle: HCkPkcs11; oldPin: PWideChar; newPin: PWideChar): wordbool; stdcall;

implementation

{$Include chilkatDllPath.inc}

function CkPkcs11_Create; external DLLName;
procedure CkPkcs11_Dispose; external DLLName;
procedure CkPkcs11_getDebugLogFilePath; external DLLName;
procedure CkPkcs11_putDebugLogFilePath; external DLLName;
function CkPkcs11__debugLogFilePath; external DLLName;
procedure CkPkcs11_getLastErrorHtml; external DLLName;
function CkPkcs11__lastErrorHtml; external DLLName;
procedure CkPkcs11_getLastErrorText; external DLLName;
function CkPkcs11__lastErrorText; external DLLName;
procedure CkPkcs11_getLastErrorXml; external DLLName;
function CkPkcs11__lastErrorXml; external DLLName;
function CkPkcs11_getLastMethodSuccess; external DLLName;
procedure CkPkcs11_putLastMethodSuccess; external DLLName;
function CkPkcs11_getNumCerts; external DLLName;
procedure CkPkcs11_getSharedLibPath; external DLLName;
procedure CkPkcs11_putSharedLibPath; external DLLName;
function CkPkcs11__sharedLibPath; external DLLName;
function CkPkcs11_getVerboseLogging; external DLLName;
procedure CkPkcs11_putVerboseLogging; external DLLName;
procedure CkPkcs11_getVersion; external DLLName;
function CkPkcs11__version; external DLLName;
function CkPkcs11_CloseSession; external DLLName;
function CkPkcs11_Discover; external DLLName;
function CkPkcs11_FindAllCerts; external DLLName;
function CkPkcs11_FindCert; external DLLName;
function CkPkcs11_GetCert; external DLLName;
function CkPkcs11_Initialize; external DLLName;
function CkPkcs11_InitPin; external DLLName;
function CkPkcs11_InitToken; external DLLName;
function CkPkcs11_Login; external DLLName;
function CkPkcs11_Logout; external DLLName;
function CkPkcs11_OpenSession; external DLLName;
function CkPkcs11_SaveLastError; external DLLName;
function CkPkcs11_SetPin; external DLLName;



end.
