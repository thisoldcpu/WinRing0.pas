unit winring0;


// WinRing0 is a DLL file used to access interanl system addresses, ports,
// registers, and counters from CrystalDewWorld.
// The library name is OpenLibSys and exports 54 functions
//
// The original author of WinRing0 is hiyohiyo
// WinRing0 license: The modified BSD license
// WinRing0 is a copyright of OpenLibSys.org. All rights reserved.
//
// Pascal header conversion by Jason McClain (ThisOldCPU)


interface

uses Windows, SysUtils;

type
  TWinRing0 = class
  const
  {$IFDEF WIN64}
    dllName = 'WinRing0x64.dll';
  {$ELSE}
    dllName = 'WinRing0.dll';
  {$ENDIF}

  public type
    TOlsStatus =     (NO_ERROR = 0,
                      DLL_NOT_FOUND = 1,
                      DLL_INCORRECT_VERSION = 2,
                      DLL_INITIALIZE_ERROR = 3);

    TOlsDllStatus =  (OLS_DLL_NO_ERROR = 0,
                      OLS_DLL_UNSUPPORTED_PLATFORM = 1,
                      OLS_DLL_DRIVER_NOT_LOADED = 2,
                      OLS_DLL_DRIVER_NOT_FOUND = 3,
                      OLS_DLL_DRIVER_UNLOADED = 4,
                      OLS_DLL_DRIVER_NOT_LOADED_ON_NETWORK = 5,
                      OLS_DLL_UNKNOWN_ERROR = 6);

    TOlsDriverType = (OLS_DRIVER_TYPE_UNKNOWN = 0,
                      OLS_DRIVER_TYPE_WIN_9X = 1,
                      OLS_DRIVER_TYPE_WIN_NT = 2,
                      OLS_DRIVER_TYPE_WIN_NT4 = 3,
                      OLS_DRIVER_TYPE_WIN_NT_X64 = 4,
                      OLS_DRIVER_TYPE_WIN_NT_IA64 = 5);

    TCpuid = function(index: DWORD; var eax, ebx, ecx, edx: DWORD): BOOL; stdcall;                                      //
    TCpuidPx = function(index: DWORD; var eax, ebx, ecx, edx: DWORD; processAffinityMask: DWORD_PTR): BOOL; stdcall;    //
    TCpuidTx = function(index: DWORD; var eax, ebx, ecx, edx: DWORD; threadAffinityMask: DWORD_PTR): BOOL; stdcall;     //

    TDeinitializeOls = procedure; stdcall;

    TGetDllStatus = function: DWORD; stdcall;                                                                           // Is the WinRing0 DLL valid and loaded?
    TGetDllVersion = function(var major, minor, revision, release: Byte): DWORD; stdcall;                               // Returns the curent version of WinRing0 DLL
    TGetDriverType = function: DWORD; stdcall;                                                                          // Get device driver type
    TGetDriverVersion = function(var major, minor, revision, release: Byte): DWORD; stdcall;                            // Get device driver version

    THlt = function: Integer; stdcall;                                                                                  //
    THltTx = function(threadAffinityMask: UIntPtr): Integer; stdcall;                                                   //
    THltPx = function(processAffinityMask:UIntPtr): Integer; stdcall;                                                   //

    TInitializeOls = function: BOOL; stdcall;                                                                           // Initialize OpenLibSys

    TIsCpuid = function: BOOL; stdcall;                                                                                 // Is CPUID present?
    TIsMsr = function: BOOL; stdcall;                                                                                   // Are Model-Specific Registers present?
    TIsTsc = function: BOOL; stdcall;                                                                                   // Are Time-Stamp Counters present?

    TRdmsr = function(index: DWORD; var eax: DWORD; var edx: DWORD): BOOL; stdcall;                                     // Read Model Specific Register
    TRdmsrPx = function(index: DWORD; var eax, edx: DWORD; processAffinityMask: DWORD_PTR): BOOL; stdcall;
    TRdmsrTx = function(index: DWORD; var eax, edx: DWORD; threadAffinityMask: DWORD_PTR): BOOL; stdcall;

    TRdpmc = function(index: DWORD; var eax: DWORD; var edx: DWORD): BOOL; stdcall;                                     // Read Performance-Monitoring Counter
    TRdpmcPx = function(index: DWORD; var eax, edx: DWORD; processAffinityMask: DWORD_PTR): BOOL; stdcall;
    TRdpmcTx = function(index: DWORD; var eax, edx: DWORD; threadAffinityMask: DWORD_PTR): BOOL; stdcall;

    TRdtsc = function(index: DWORD; var eax: DWORD; var edx: DWORD): BOOL; stdcall;                                     // Read Time-Stamp Counter
    TRdtscPx = function(index: DWORD; var eax, edx: DWORD; processAffinityMask: DWORD_PTR): BOOL; stdcall;
    TRdtscTx = function(index: DWORD; var eax, edx: DWORD; threadAffinityMask: DWORD_PTR): BOOL; stdcall;

    TReadIoPortByte = function(port: WORD): BYTE; stdcall;                                                              // Read a Byte from I/O port
    TReadIoPortWord = function(port: WORD): WORD; stdcall;                                                              // Read a WORD from I/O port
    TReadIoPortDword = function(port: WORD): DWORD; stdcall;                                                            // Read a DWORD from I/O port

    TReadIoPortByteEx = function(port: WORD; value: PBYTE): Boolean; stdcall;                                           // Read a Byte from I/O port with error checking
    TReadIoPortWordEx = function(port: WORD; value: PWORD): Boolean; stdcall;                                           // Read a WORD from I/O port with error checking
    TReadIoPortDwordEx = function(port: WORD; value: PDWORD): Boolean; stdcall;                                         // Read a DWORD from I/O port with error checking

    TWriteIoPortByte = function(port: WORD; value: BYTE): Boolean; stdcall;                                             // Write a Byte to I/O port
    TWriteIoPortWord = function(port: WORD; value: WORD): Boolean; stdcall;                                             // Write a WORD to I/O port
    TWriteIoPortDword = function(port: WORD; value: DWORD): Boolean; stdcall;                                           // Write a DWORD to I/O port

    TWriteIoPortByteEx = function (port: WORD; value: BYTE): Boolean; stdcall;                                          // Read a Byte from I/O port with error checking
    TWriteIoPortWordEx = function(port: WORD; value: WORD): Boolean; stdcall;                                           // Read a WORD from I/O port with error checking
    TWriteIoPortDwordEx = function(port: WORD; value: DWORD): Boolean; stdcall;                                         // Read a DWORD from I/O port with error checking

    TSetPciMaxBusIndex = procedure (max: BYTE); stdcall;                                                                //

    TReadPciConfigByte = function(pciAddress: DWORD; regAddress: BYTE): BYTE; stdcall;                                  //
    TReadPciConfigWord = function(pciAddress: DWORD; regAddress: BYTE): WORD; stdcall;                                  //
    TReadPciConfigDword = function(pciAddress: DWORD; regAddress: BYTE): DWORD; stdcall;                                //

    TReadPciConfigByteEx = function(pciAddress, regAddress: DWORD; value: PBYTE): Boolean; stdcall;                     //
    TReadPciConfigWordEx = function(pciAddress, regAddress: DWORD; value: PWORD): Boolean; stdcall;                     //
    TReadPciConfigDwordEx = function(pciAddress, regAddress: DWORD; value: PDWORD): Boolean; stdcall;                   //

    TWritePciConfigByte = procedure(pciAddress: DWORD; regAddress: BYTE; value: BYTE); stdcall;                         //
    TWritePciConfigWord = procedure(pciAddress: DWORD; regAddress: BYTE; value: WORD); stdcall;                         //
    TWritePciConfigDword = procedure(pciAddress: DWORD; regAddress: BYTE; value: DWORD); stdcall;                       //

    TWritePciConfigByteEx = function(pciAddress, regAddress: DWORD; value: BYTE): Boolean; stdcall;                     //
    TWritePciConfigWordEx = function(pciAddress, regAddress: DWORD; value: WORD): Boolean; stdcall;                     //
    TWritePciConfigDwordEx = function(pciAddress, regAddress: DWORD; value: DWORD): Boolean; stdcall;                   //

    TFindPciDeviceByClass = function(baseClass, subClass, programIf, index: Byte): uInt; stdcall;                       //
    TFindPciDeviceById = function(vendorId, deviceId: uShort; index: byte): Cardinal; stdcall;                          //

    TReadDmiMemory = function(buffer: PBYTE; count, unitSize: DWORD): DWORD; stdcall;
    TReadPhysicalMemory = function(address: DWORD_PTR; buffer: PBYTE; count, unitSize: DWORD): DWORD; stdcall;          //
    TWritePhysicalMemory = function(address: DWORD_PTR; buffer: PBYTE; count, unitSize: DWORD): DWORD; stdcall;         //

    TWrmsr = function(index: DWORD; var eax, edx: DWORD): BOOL; stdcall;
    TWrmsrPx = function(index: DWORD; var eax, edx: DWORD; processAffinityMask: DWORD_PTR): BOOL; stdcall;              //
    TWrmsrTx = function(index: DWORD; var eax, edx: DWORD; threadAffinityMask: DWORD_PTR): BOOL; stdcall;               //
  private
    FModule: THandle;
    FOlsStatus: TOlsStatus;

    FCpuid: TCpuid;
    FCpuidPx: TCpuidPx;
    FCpuidTx: TCpuidTx;

    FHlt: THlt;
    FHltTx: THltTx;
    FHltPx: THltPx;

    FGetDllStatus: TGetDllStatus;
    FGetDriverType: TGetDriverType;
    FGetDllVersion: TGetDllVersion;
    FGetDriverVersion: TGetDriverVersion;

    FInitializeOls: TInitializeOls;
    FDeinitializeOls: TDeinitializeOls;

    FIsCpuid: TIsCpuid;
    FIsMsr: TIsMsr;
    FIsTsc: TIsTsc;

    FRdmsr: TRdmsr;
    FRdmsrPx: TRdmsrPx;
    FRdmsrTx: TRdmsrTx;

    FRdpmc: TRdpmc;
    FRdpmcPx:  TRdpmcPx;
    FRdpmcTx:  TRdpmcTx;

    FRdtsc: TRdtsc;
    FRdtscPx:  TRdtscPx;
    FRdtscTx:  TRdtscTx;

    FWrmsr: TWrmsr;
    FWrmsrPx: TWrmsrPx;
    FWrmsrTx: TWrmsrTx;

    FReadIoPortByte: TReadIoPortByte;
    FReadIoPortWord: TReadIoPortWord;
    FReadIoPortDword: TReadIoPortDword;

    FReadIoPortByteEx: TReadIoPortByteEx;
    FReadIoPortWordEx: TReadIoPortWordEx;
    FReadIoPortDwordEx: TReadIoPortDwordEx;

    FWriteIoPortByte: TWriteIoPortByte;
    FWriteIoPortWord: TWriteIoPortWord;
    FWriteIoPortDword: TWriteIoPortDword;

    FWriteIoPortByteEx: TWriteIoPortByteEx;
    FWriteIoPortWordEx: TWriteIoPortWordEx;
    FWriteIoPortDwordEx: TWriteIoPortDwordEx;

    FSetPciMaxBusIndex: TSetPciMaxBusIndex;

    FReadPciConfigByte: TReadPciConfigByte;
    FReadPciConfigWord: TReadPciConfigWord;
    FReadPciConfigDword: TReadPciConfigDword;

    FReadPciConfigByteEx: TReadPciConfigByteEx;
    FReadPciConfigWordEx: TReadPciConfigWordEx;
    FReadPciConfigDwordEx: TReadPciConfigDwordEx;

    FWritePciConfigByte: TWritePciConfigByte;
    FWritePciConfigWord: TWritePciConfigWord;
    FWritePciConfigDword: TWritePciConfigDword;

    FWritePciConfigByteEx: TWritePciConfigByteEx;
    FWritePciConfigWordEx: TWritePciConfigWordEx;
    FWritePciConfigDwordEx: TWritePciConfigDwordEx;

    FFindPciDeviceById: TFindPciDeviceById;
    FFindPciDeviceByClass: TFindPciDeviceByClass;

    FReadDmiMemory: TReadDmiMemory;
    FReadPhysicalMemory: TReadPhysicalMemory;
    FWritePhysicalMemory: TWritePhysicalMemory;

  public
    property CPUID: TCpuid read FCpuid;
    property CpuidPx: TCpuidPx read FCpuidPx;
    property CpuidTx: TCpuidTx read FCpuidTx;

    property FindPciDeviceByClass: TFindPciDeviceByClass read FFindPciDeviceByClass;
    property FindPciDeviceById: TFindPciDeviceById read FFindPciDeviceById;

    property Hlt: THlt read FHlt;
    property HltTx: THltTx read FHltTx;
    property HltPx: THltTx read FHltTx;

    property GetDllStatus: TGetDllStatus read FGetDllStatus;
    property GetDriverType: TGetDriverType read FGetDriverType;
    property GetDllVersion: TGetDllVersion read FGetDllVersion;
    property GetDriverVersion: TGetDriverVersion read FGetDriverVersion;

    property InitializeOls: TInitializeOls read FInitializeOls;
    property DeinitializeOls: TDeinitializeOls read FDeinitializeOls;

    property IsCpuid: TIsCpuid read FIsCpuid;
    property IsMsr: TIsMsr read FIsMsr;
    property IsTsc: TIsTsc read FIsTsc;

    property Rdmsr: TRdmsr read FRdmsr;
    property RdmsrTx: TRdmsrTx read FRdmsrTx;
    property RdmsrPx: TRdmsrPx read FRdmsrPx;

    property Rdpmc: TRdpmc read FRdpmc;
    property RdpmcTx: TRdpmcTx read FRdpmcTx;
    property RdpmcPx: TRdpmcPx read FRdpmcPx;

    property Rdtsc: TRdtsc read FRdtsc;
    property RdtscTx: TRdtscTx read FRdtscTx;
    property RdtscPx: TRdtscPx read FRdtscPx;

    property Wrmsr: TWrmsr read FWrmsr;
    property WrmsrTx: TWrmsrTx read FWrmsrTx;
    property WrmsrPx: TWrmsrPx read FWrmsrPx;

    property ReadIoPortByte: TReadIoPortByte read FReadIoPortByte;
    property ReadIoPortWord: TReadIoPortWord read FReadIoPortWord;
    property ReadIoPortDword: TReadIoPortDword read FReadIoPortDword;

    property ReadIoPortByteEx: TReadIoPortByteEx read FReadIoPortByteEx;
    property ReadIoPortWordEx: TReadIoPortWordEx read FReadIoPortWordEx;
    property ReadIoPortDwordEx: TReadIoPortDwordEx read FReadIoPortDwordEx;

    constructor Create;
    destructor Destroy; override;
    function GetOlsStatus: TOlsStatus;
  end;

implementation

{ TWinRing0 }

constructor TWinRing0.Create;
var
  LFileName: String;
begin
  LFileName := dllName;
  FModule := LoadLibrary(PWideChar(LFileName));

  if FModule = 0 then
  begin
    FOlsStatus := TOlsStatus.DLL_NOT_FOUND;
  end
  else
  begin
    FCpuid := GetProcAddress(FModule, 'Cpuid');
    FCpuidPx := GetProcAddress(FModule, 'CpuidPx');
    FCpuidTx := GetProcAddress(FModule, 'CpuidTx');

    FDeinitializeOls := GetProcAddress(FModule, 'DeinitializeOls');

    FFindPciDeviceByClass := GetProcAddress(FModule, 'FindPciDeviceByClass');
    FFindPciDeviceById := GetProcAddress(FModule, 'FindPciDeviceById');

    FGetDllStatus := GetProcAddress(FModule, 'GetDllStatus');
    FGetDllVersion := GetProcAddress(FModule, 'GetDllVersion');
    FGetDriverVersion := GetProcAddress(FModule, 'GetDriverVersion');
    FGetDriverType := GetProcAddress(FModule, 'GetDriverType');

    FHlt := GetProcAddress(FModule, 'Hlt');
    FHltTx := GetProcAddress(FModule, 'HltTx');
    FHltPx := GetProcAddress(FModule, 'HltPx');

    FInitializeOls := GetProcAddress(FModule, 'InitializeOls');

    FIsCpuid := GetProcAddress(FModule, 'IsCpuid');
    FIsMsr := GetProcAddress(FModule, 'IsMsr');
    FIsTsc := GetProcAddress(FModule, 'IsTsc');

    FRdmsr := GetProcAddress(FModule, 'Rdmsr');
    FRdmsrPx := GetProcAddress(FModule, 'RdmsrPx');
    FRdmsrTx := GetProcAddress(FModule, 'RdmsrTx');

    FRdpmc := GetProcAddress(FModule, 'Rdpmc');
    FRdpmcPx := GetProcAddress(FModule, 'RdpmcPx');
    FRdpmcTx := GetProcAddress(FModule, 'RdpmcTx');

    FWrmsr := GetProcAddress(FModule, 'Wrmsr');
    FWrmsrPx := GetProcAddress(FModule, 'WrmsrPx');
    FWrmsrTx := GetProcAddress(FModule, 'WrmsrTx');

    FReadIoPortByte := GetProcAddress(FModule, 'ReadIoPortByte');
    FReadIoPortWord := GetProcAddress(FModule, 'ReadIoPortWord');
    FReadIoPortDword := GetProcAddress(FModule, 'ReadIoPortDword');

    FReadIoPortByteEx := GetProcAddress(FModule, 'ReadIoPortByteEx');
    FReadIoPortWordEx := GetProcAddress(FModule, 'ReadIoPortWordEx');
    FReadIoPortDwordEx := GetProcAddress(FModule, 'ReadIoPortDwordEx');

    FWriteIoPortByte := GetProcAddress(FModule, 'WriteIoPortByte');
    FWriteIoPortWord := GetProcAddress(FModule, 'WriteIoPortWord');
    FWriteIoPortDword := GetProcAddress(FModule, 'WriteIoPortDword');

    FWriteIoPortByteEx := GetProcAddress(FModule, 'WriteIoPortByteEx');
    FWriteIoPortWordEx := GetProcAddress(FModule, 'WriteIoPortWordEx');
    FWriteIoPortDwordEx := GetProcAddress(FModule, 'WriteIoPortDwordEx');

    FSetPciMaxBusIndex := GetProcAddress(FModule, 'SetPciMaxBusIndex');

    FReadPciConfigByte := GetProcAddress(FModule, 'ReadPciConfigByte');
    FReadPciConfigWord := GetProcAddress(FModule, 'ReadPciConfigWord');
    FReadPciConfigDword := GetProcAddress(FModule, 'ReadPciConfigDword');

    FReadPciConfigByteEx := GetProcAddress(FModule, 'ReadPciConfigByteEx');
    FReadPciConfigWordEx := GetProcAddress(FModule, 'ReadPciConfigWordEx');
    FReadPciConfigDwordEx := GetProcAddress(FModule, 'ReadPciConfigDwordEx');

    FWritePciConfigByte := GetProcAddress(FModule, 'WritePciConfigByte');
    FWritePciConfigWord := GetProcAddress(FModule, 'WritePciConfigWord');
    FWritePciConfigDword := GetProcAddress(FModule, 'WritePciConfigDword');

    FWritePciConfigByteEx := GetProcAddress(FModule, 'WritePciConfigByteEx');
    FWritePciConfigWordEx := GetProcAddress(FModule, 'WritePciConfigWordEx');
    FWritePciConfigDwordEx := GetProcAddress(FModule, 'WritePciConfigDwordEx');

    FFindPciDeviceById := GetProcAddress(FModule, 'FindPciDeviceById');
    FFindPciDeviceByClass := GetProcAddress(FModule, 'FindPciDeviceByClass');

    FReadDmiMemory := GetProcAddress(FModule, 'ReadDmiMemory');
    FReadPhysicalMemory := GetProcAddress(FModule, 'ReadPhysicalMemory');
    FWritePhysicalMemory := GetProcAddress(FModule, 'WritePhysicalMemory');

    // Check Functions
    if (not(Assigned(FGetDllStatus) and Assigned(FGetDllVersion) and
      Assigned(FGetDriverVersion) and Assigned(FGetDriverType) and
      Assigned(FInitializeOls) and Assigned(FDeinitializeOls) and
      Assigned(FIsMsr) and Assigned(FRdmsr) and Assigned(FRdmsrPx) and
      Assigned(FRdmsrTx) and Assigned(FWrmsr) and Assigned(FWrmsrPx) and
      Assigned(FWrmsrTx))) then
    begin
      FOlsStatus := TOlsStatus.DLL_INCORRECT_VERSION;
    end;

    if not FInitializeOls() then
    begin
      FOlsStatus := TOlsStatus.DLL_INITIALIZE_ERROR;
    end;
  end;
end;

destructor TWinRing0.Destroy;
begin
  if FModule <> 0 then
  begin
    FDeinitializeOls();
    FreeLibrary(FModule);
    FModule := 0;
  end;

  inherited;
end;

function TWinRing0.GetOlsStatus: TOlsStatus;
begin
  result := FOlsStatus;
end;

end.
