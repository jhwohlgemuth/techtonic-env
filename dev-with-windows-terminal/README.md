Development with Windows Terminal
=================================
> `#cantBelieveItsNotLinux`

<div align="center">
    <a href="https://gyazo.com/c299ded42555b2fccdbddd78527cceb9"><img alt="Windows Terminal in action!" src="https://i.gyazo.com/c299ded42555b2fccdbddd78527cceb9.gif" alt="Image from Gyazo" width="1280"/></a>
</div>

Requirements
------------
- [Windows Terminal](https://www.microsoft.com/store/productId/9N0DX20HK701)

Quick Start
-----------
1. Open a Powershell terminal in a location, `C:/path/to/folder`, where you can save some files

> While holding <kbd>shift</kbd>, right-click `C:/path/to/folder` directory and select "Open PowerShell window here"

2. Clone this repository:

```bash
git clone https://github.com/jhwohlgemuth/env
```

3. Navigate to the `dev-with-windows-terminal` directory:

```bash
cd /path/to/env/dev-with-windows-terminal
```

4. Run setup PowerShell script:
> You are encouraged to read the content of [Invoke-Setup.ps1](./Invoke-Setup.ps1)

**Install applications with [Chocolatey](https://chocolatey.org/)**:
```powershell
./Invoke-Setup.ps1
```

**Install applications with [Scoop](https://scoop.sh/)**:
```powershell
./Invoke-Setup.ps1 -PackageManager scoop

# Read help to understand all options
Get-Help ./Invoke-Setup.ps1
```

> Not sure which package manager to use? [Here is a comparison](https://github.com/lukesampson/scoop/wiki/Chocolatey-Comparison) provided by the maker of Scoop.

5. Copy content of [Microsoft.Powershell_profile.ps1](./Microsoft.Powershell_profile.ps1) into Windows Terminal settings:

```powershell
Set-Content -Path $PROFILE -Value (Get-Content -Path .\Microsoft.Powershell_profile.ps1)
```

6. Open the Windows terminal `settings.json` file by pressing <kbd>CTRL</kbd>+<kbd>,</kbd> and replace contents with content of [settings.json](./settings.json) from this repository

> Enjoy your awesome new ***Windows*** terminal. `#cantBelieveItsNotLinux`

What Next?!
===========
Now that you have an amazing terminal, [install Neovim](../dev-with-neovim), and/or [give Docker a try!](../dev-with-docker)