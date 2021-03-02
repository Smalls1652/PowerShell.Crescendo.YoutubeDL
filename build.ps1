[CmdletBinding(SupportsShouldProcess)]
param(

)

$scriptRoot = $PSScriptRoot

$srcPath = Join-Path -Path $scriptRoot -ChildPath "src\"
$compiledPath = Join-Path -Path $scriptRoot -ChildPath "compiled\"

$crescendoConfig = Join-Path -Path $srcPath -ChildPath "youtube-dl.json"
Write-Verbose "Crescendo config file located at: '$($crescendoConfig)'"

if ($PSCmdlet.ShouldProcess("PowerShell.Crescendo.YoutubeDL", "Export Crescendo config")) {
    Push-Location -Path $compiledPath -StackName "CrescendoYoutubeDLCompiledPath"
    try {
        Export-CrescendoModule -ConfigurationFile $crescendoConfig -ModuleName "youtube-dl" -Force -ErrorAction "Stop"
    }
    finally {
        Pop-Location -StackName "CrescendoYoutubeDLCompiledPath"
    }
}