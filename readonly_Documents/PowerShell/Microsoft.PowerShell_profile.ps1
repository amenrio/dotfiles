Import-Module -Name Terminal-Icons
Import-Module -Name PSReadline

# Set-PSReadLineOption -PredictionSource HistoryAndPlugin
# Set-PSReadLineOption -PredictionViewStyle InlineView
# Set-PSReadLineOption -EditMode Windows
Set-PSReadLineKeyHandler -Key Tab -Function Complete

#Environments

$env:PATH="$env:PATH;$env:USERPROFILE/bin;$env:USERPROFILE/.local/bin"
$env:PATH="$env:PATH;$env:USERPROFILE/AppData/Local/bob/nvim-bin"
[System.Environment]::SetEnvironmentVariable('VISUAL',"nvim")

# Third Party modules
Import-Module -Name PSFzf

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                -PSReadlineChordReverseHistory 'Ctrl+r'

Set-PSReadLineOption -Colors @{ Parameter = 'DarkMagenta' }

New-Alias -Name glog -Value 'git log --oneline --graph' -Force
New-Alias -Name vim -Value nvim -Force

function clockIn {
    pxnrm new timelog -p 1 -t 0 -c "Inicio Jornada"
}

function clockOut {
    pxnrm new timelog -p 1 -t 0 -c "Final Jornada"
}

function vw {
    & cdw
    vim .
}

function cdw {
    $root = "$env:USERPROFILE\work"
    & Deactivate-Venv
    $location = fd . $root --max-depth 2 --type dir | fzf --layout=reverse
    Set-Location $location
    & Activate-Venv

}
function cdc {
    # param (
    #     [Parameter(Mandatory=$false)]
    #     [string]$path
    # )

    $location = fd . $env:USERPROFILE\.config $env:USERPROFILE\AppData\Local --maxdepth=1 --type=dir --full-path | fzf --layout=reverse
    Set-Location $location

}

function cdt {
    $location = fd . $env:USERPROFILE\Documents\tests --maxdepth=1 --type=dir --full-path | fzf --layout=reverse
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

