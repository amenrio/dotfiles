if (!(Verify-Elevated)) {
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "pwsh";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas"
    [System.Diagnostics.Process]::Start($newProcess)

    exit
}

winget install 7zip.7zip                             --silent --accept-package-agreements --accept-source-greements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""
winget install Git.Git                               --silent --accept-package-agreements --accept-source-greements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""
winget install Python.Python.3.12                    --silent --accept-package-agreements --accept-source-greements

winget install Microsoft.Powershell.Preview          --silent --accept-package-agreements --accept-source-greements
winget install Google.Chrome                         --silent --accept-package-agreements --accept-source-greements
winget install LibreWolf.LibreWolf                   --silent --accept-package-agreements --accept-source-greements
winget install Flameshot.Flameshot                   --silent --accept-package-agreements --accept-source-greements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""

winget install WinSCP.WinSCP                         --silent --accept-package-agreements --accept-source-greements
winget install Valve.Steam                           --silent --accept-package-agreements --accept-source-greements
winget install Discord.Discord                       --silent --accept-package-agreements --accept-source-greements
winget install BlenderFoundation.Blender             --silent --accept-package-agreements --accept-source-greements

winget install wez.wezterm                           --silent --accept-package-agreements --accept-source-greements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""
winget install Starship.Starship                     --silent --accept-package-agreements --accept-source-greements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""

winget install SpanishGovernment.Autofirma           --silent --accept-package-agreements --accept-source-greements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""
