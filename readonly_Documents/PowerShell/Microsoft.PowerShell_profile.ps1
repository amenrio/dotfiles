Import-Module -Name Terminal-Icons
Import-Module -Name PSReadline

Set-PSReadLineKeyHandler -Key Tab -Function Complete
#Environments
# Third Party modules
Import-Module -Name PSFzf

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                -PSReadlineChordReverseHistory 'Ctrl+r'

Set-PSReadLineOption -Colors @{ Parameter = 'DarkMagenta' }

$env:PATH="$env:PATH;$env:USERPROFILE/bin;$env:USERPROFILE/.local/bin"
$env:PATH="$env:PATH;$env:USERPROFILE/AppData/Local/bob/nvim-bin"
[System.Environment]::SetEnvironmentVariable('VISUAL',"nvim")

if (!(Get-Alias -Name v -ErrorAction SilentlyContinue)){New-Alias -Name v -Value vim}
if (!(Get-Alias -Name vim -ErrorAction SilentlyContinue)){New-Alias -Name vim -Value nvim}
if (!(Get-Alias -Name glog -ErrorAction SilentlyContinue)){New-Alias -Name glog -Value 'git log --oneline --graph'}
if (!(Get-Alias -Name lg -ErrorAction SilentlyContinue)){New-Alias -Name lg -Value lazygit}

function clockIn {
    uv run pxnrm new timelog -p 1 -t 0 -c "Inicio Jornada"
}

function clockOut {
    uv run pxnrm new timelog -p 1 -t 0 -c "Final Jornada"
}

function vw {
    & cdw
    vim .
}

function Change-Workspace {
    param (
        [Parameter(Mandatory=$false)]
        [string]$project
    )
    $work_dir = "$env:USERPROFILE\work"
    Set-Location (Get-ChildItem -Path "$work_dir\pxn","$work_dir\lux","$work_dir\ff","$work_dir\notes" -Directory | Where-Object { $_.Name -match '^[^_|^.]' } | Invoke-Fzf -Layout reverse)
}

function cdw {
    param (
        [Parameter(Mandatory=$false)]
        [string]$project
    )
    $work_dir = "$env:USERPROFILE\work"

    $dirs = @( "$work_dir\ff", "$work_dir\pxn", "$work_dir\lux", "$work_dir\test", "$work_dir\notes")
    if ($project) {
        $dirs = @( "$work_dir\$project" )
    }
    $location = fd "^[^\_]" @dirs --type=dir --max-depth=1 | fzf --layout=reverse
    Set-Location $location
    & Activate-Venv
}

function cdc {
    # param (
    #     [Parameter(Mandatory=$false)]
    #     [string]$path
    # )
    $dirs = @(
    "$env:USERPROFILE\.config",
    "$env:USERPROFILE\AppData\Local"
    )

    $location = fd . @dirs --maxdepth=1 --type=dir --full-path | fzf --layout=reverse
    Set-Location $location

}


function Deactivate-Venv {
    if (Get-Command "deactivate" -ErrorAction SilentlyContinue) {
        Write-Host "[cdw] Switching venv..."
        deactivate
    } 
}

function Activate-Venv {
    # Get standard python venv folders
    $venv_folder = Get-ChildItem -Directory -Force | Where-Object {
        $_.Name -match '^(\.?)(env|venv)$'
    } | Select-Object -First 1
    if ($venv_folder) { 
        $activate_script = Join-Path $venv_folder.FullName "Scripts\Activate.ps1"
        if (Test-Path $activate_script) {
            Write-Host "[cdw] Activating virtual environment..."
            & $activate_script
        }
    } else {
        Write-Host "[cdw] Directory has no virtual environment"
    }
}

$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}
[System.Environment]::SetEnvironmentVariable('PYTHONDONTWRITEBYTECODE',1)
Invoke-Expression (&starship init powershell)

$env:FZF_DEFAULT_OPTS='
  --height=10%
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9'
