# WinRing0.pas
Pascal header translation for WinRing0.dll and WinRing0x64.dll

WinRing0.DLL and WinRing0x64.DLL, part of OpenLibSys from CrystalDewWorld, are linked library files used to access internal system addresses, counters, ports, and registers.

There are 54 exported functions, each is supported and documented in the unit.

![Screenshot 2023-07-20 130824](https://github.com/JasonMcClain/WinRing0.pas/assets/99989297/fd4a85a7-0a71-493a-b52b-9db8fbf5c2ac)

The original author of WinRing0 is hiyohiyo (https://openlibsys.org/)

Original WinRing0 license: The modified BSD license

WinRing0 is a copyright of OpenLibSys.org 2007. All rights reserved.

Pascal header conversion by Jason McClain (ThisOldCPU)

https://github.com/JasonMcClain/WinRing0.pas

## Usage

### Initilization

```
  // Initialize WinRing0
  try
    Ring0 := TWinRing0.Create;
  except
    on E: Exception do
      ShowMessage(E.ClassName + ': ' + E.Message);
  end;

  // GetDllStatus
  reLog.Lines.Add(Format('OLS DLL Status: %s', [Ring0.GetDLLStatusString]));
  reLog.Lines.Add(Format('OLS Status: %s', [Ring0.GetOlsStatusString]));
  reLog.Lines.Add(Format('OLS Driver Type: %s', [Ring0.GetOlsDriverTypeString]));

  // GetDllVersion
  res := Ring0.GetDllVersion(major, minor, revision, release);
  if res <> 0 then
    reLog.Lines.Add(Format('DLL Version %d.%d.%d.%d', [major, minor, revision, release]));

  // GetDriverVersion
  res := Ring0.GetDriverVersion(major, minor, revision, release);
  if res <> 0 then
    reLog.Lines.Add(Format('Driver Version %d.%d.%d.%d', [major, minor, revision, release]));
```

### Shutdown

```
  try
    Ring0.Free;
  except
    on E: Exception do
      ShowMessage(E.ClassName + ': ' + E.Message);
  end;
  ```
