function Find-Duplicates
{
  <#
  .SYNOPSIS
  Helper function that calculates file hash values to find duplicate files recursively
  .EXAMPLE
  Find-Duplicates <path to folder>
  .EXAMPLE
  pwd | Find-Duplicates
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string] $Name
  )
  Get-Item $Name | Get-ChildItem -Recurse | Get-FileHash | Group-Object -Property Hash | Where-Object Count -GT 1 | ForEach-Object {$_.Group | Select-Object Path, Hash} | Write-Output
}
function New-File
{
  <#
  .SYNOPSIS
  Powershell equivalent of linux "touch" command
  .EXAMPLE
  New-File <file name>
  #>
  [CmdletBinding(SupportsShouldProcess=$true)]
  param (
    [Parameter(Mandatory=$true)]
    [string] $Name
  )
  if (Test-Path $Name) {
    (Get-ChildItem $Name).LastWriteTime = Get-Date
  } else {
    New-Item -Path . -Name $Name -ItemType "file" -Value ""
  }
}
function New-SshKey
{
  [CmdletBinding()]
  param(
    [Parameter()]
    [string] $Name="id_rsa")
  Write-Verbose "==> Generating SSH key pair"
  $Path = "~/.ssh/$Name"
  ssh-keygen --% -q -b 4096 -t rsa -N "" -f TEMPORARY_FILE_NAME
  Move-Item -Path TEMPORARY_FILE_NAME -Destination $Path
  Move-Item -Path TEMPORARY_FILE_NAME.pub -Destination "$Path.pub"
  if (Test-Path "$Path.pub") {
    Write-Verbose "==> $Name SSH private key saved to $Path"
    Write-Verbose "==> Saving SSH public key to clipboard"
    Get-Content "$Path.pub" | Set-Clipboard
    Write-Output "==> Public key saved to clipboard"
  } else {
    Write-Error "==> Failed to create SSH key"
  }
}
function Remove-DirectoryForce
{
  <#
  .SYNOPSIS
  Powershell equivalent of linux "rm -frd"
  .EXAMPLE
  rf <folder name>
  #>
  [CmdletBinding(SupportsShouldProcess=$true)]
  param (
    [Parameter(Mandatory=$true)]
    [string] $Name
  )
  $Path = Join-Path (Get-Location) $Name
  if (Test-Path $Path) {
    $Cleaned = Resolve-Path $Path
    Write-Verbose "=> Deleting $Cleaned"
    Remove-Item -Path $Cleaned -Recurse
    Write-Verbose "=> Deleted $Cleaned"
  } else {
    Write-Error 'Bad input. No folders/files were deleted'
  }
}
function Take
{
  <#
  .SYNOPSIS
  Powershell equivalent of oh-my-zsh take function
  .DESCRIPTION
  Using take will create a new directory and then enter the driectory
  .EXAMPLE
  take <folder name>
  #>
  [CmdletBinding(SupportsShouldProcess=$true)]
  param (
    [Parameter(Mandatory=$true)]
    [string] $Name
  )
  $Path = Join-Path (Get-Location) $Name
  if (Test-Path $Path) {
    Write-Verbose "=> $Path exists"
    Write-Verbose "=> Entering $Path"
    Set-Location $Path
  } else {
    Write-Verbose "=> Creating $Path"
    mkdir $Path
    if (Test-Path $Path) {
      Write-Verbose "=> Entering $Path"
      Set-Location $Path
    }
  }
  Write-Verbose "=> pwd is $(Get-Location)"
}
function Test-Admin
{
  <#
  .SYNOPSIS
  Helper function that returns true if user is in the "built-in" "admin" group, false otherwise
  .EXAMPLE
  Test-Admin
  #>
  [CmdletBinding()]
  [OutputType([bool])]
  param ()
  ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) | Write-Output
}
function Test-Empty
{
  <#
  .SYNOPSIS
  Helper function that returns true if directory is empty, false otherwise
  .EXAMPLE
  echo <folder name> | Test-Empty
  .EXAMPLE
  dir . | %{Test-Empty $_.FullName}
  #>
  [CmdletBinding()]
  [ValidateNotNullorEmpty()]
  [OutputType([bool])]
  param (
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string] $Name
  )
  Get-Item $Name | ForEach-Object {$_.psiscontainer -AND $_.GetFileSystemInfos().Count -EQ 0} | Write-Output
}
function Test-Installed
{
  $Name = $args[0]
  Get-Module -ListAvailable -Name $Name
}
function Install-SshServer
{
  <#
  .SYNOPSIS
  Install OpenSSH server
  https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
  #>
  [CmdletBinding(SupportsShouldProcess=$true)]
  param()
  Write-Verbose '=> Enabling OpenSSH server'
  Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
  Write-Verbose '=> Starting sshd service'
  Start-Service sshd
  Write-Verbose '=> Setting sshd service to start automatically'
  Set-Service -Name sshd -StartupType 'Automatic'
  Write-Verbose '=> Adding firewall rule for sshd'
  New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}
#
# Aliases
#
function home { Set-Location ~ }
function Invoke-DockerInspectAddress { docker inspect --format '{{ .NetworkSettings.IPAddress }}' $args[0] }
function Invoke-DockerRemoveAll { docker stop $(docker ps -a -q); docker rm $(docker ps -a -q) }
function Invoke-DockerRemoveAllImages { docker rmi $(docker images -a -q) }
function Invoke-GitCommand { git $args }
function Invoke-GitCommit { git commit -vam $args }
function Invoke-GitDiff { git diff $args }
function Invoke-GitPushMaster { git push origin master }
function Invoke-GitStatus { git status -sb }
function Invoke-GitRebase { git rebase -i $args }
function Invoke-GitLog { git log --oneline --decorate }
Set-Alias -Name ~ -Value home -Option AllScope
Set-Alias -Name la -Value Get-ChildItem -Option AllScope
Set-Alias -Name ls -Value Get-ChildItemColorFormatWide -Option AllScope
Set-Alias -Name rf -Value Remove-DirectoryForce -Option AllScope
Set-Alias -Name dip -Value Invoke-DockerInspectAddress -Option AllScope
Set-Alias -Name dra -Value Invoke-DockerRemoveAll -Option AllScope
Set-Alias -Name drai -Value Invoke-DockerRemoveAllImages -Option AllScope
Set-Alias -Name g -Value Invoke-GitCommand -Option AllScope
Set-Alias -Name gcam -Value Invoke-GitCommit -Option AllScope
Set-Alias -Name gd -Value Invoke-GitDiff -Option AllScope
Set-Alias -Name glo -Value Invoke-GitLog -Option AllScope
Set-Alias -Name gpom -Value Invoke-GitPushMaster -Option AllScope
Set-Alias -Name grbi -Value Invoke-GitRebase -Option AllScope
Set-Alias -Name gsb -Value Invoke-GitStatus -Option AllScope
Set-Alias -Name touch -Value New-File -Option AllScope
#
# Install Powershell modules, if not already installed
#
if (Test-Installed posh-git) {
  Import-Module posh-git
}
if (Test-Installed oh-my-posh) {
  Import-Module oh-my-posh
}
if (Test-Installed Get-ChildItemColor) {
  Import-Module Get-ChildItemColor
}
#
# Set Oh-my-posh theme
#
Set-Theme Agnoster
#
# Import Chocolatey profile
#
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $ChocolateyProfile) {
  Import-Module "$ChocolateyProfile"
}
#
# Directory traversal shortcuts
#
for($i = 1; $i -le 5; $i++) {
  $u =  "".PadLeft($i,"u")
  $d =  $u.Replace("u","../")
  Invoke-Expression "function $u { push-location $d }"
}