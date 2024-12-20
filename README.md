# WinRing0.pas
WinRing0.DLL and WinRing0x64.DLL are a component of OpenLibSys from CrystalDewWorld.

This unit provides a header translation for the WinRing0.DLL and WinRing0x64.DLL libraries. These libraries are used to access internal system addresses, counters, ports, and registers by providing low-level access to hardware components like CPU, memory, and PCI devices.

The original author of WinRing0 is hiyohiyo
WinRing0 license: The modified BSD license
WinRing0 is a copyright of OpenLibSys.org. All rights reserved.

Pascal header conversion by Jason McClain (ThisOldCPU 2023)

There are 54 exported functions, 3 hidden functions, and 4 helper functions.

![Screenshot 2023-07-20 130824](https://github.com/JasonMcClain/WinRing0.pas/assets/99989297/fd4a85a7-0a71-493a-b52b-9db8fbf5c2ac)

https://github.com/thisoldcpu/WinRing0.pas

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
