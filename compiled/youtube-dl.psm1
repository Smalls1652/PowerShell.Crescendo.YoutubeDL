# Module created by Microsoft.PowerShell.Crescendo
Function Invoke-YoutubeDlCommand
{
[CmdletBinding()]

param(
[Parameter(Position=0)]
[Parameter(ParameterSetName="VideoDownload")]
[Parameter(ParameterSetName="VideoDownloadAdditionalParams")]
[Parameter(ParameterSetName="VideoGetInfo")]
[string]$Url,
[Parameter(Position=0,ParameterSetName='GetHelp')]
[switch]$Help,
[Parameter(Position=0,ParameterSetName='GetVersionInfo')]
[switch]$Version,
[Parameter(Position=0,ParameterSetName='ListSupportedExtractors')]
[switch]$ListExtractors,
[Parameter(Position=1,ParameterSetName='VideoGetInfo')]
[switch]$ListFormats,
[Parameter(Position=1,ParameterSetName='VideoDownloadAdditionalParams')]
[string]$Format,
[Parameter(Position=2,ParameterSetName='VideoDownloadAdditionalParams')]
[switch]$AddMetadata
    )

BEGIN {
    $__PARAMETERMAP = @{
        Url = @{ OriginalName = ''; OriginalPosition = '0'; Position = '0'; ParameterType = [string]; NoGap = $False }
        Help = @{ OriginalName = '--help'; OriginalPosition = '0'; Position = '0'; ParameterType = [switch]; NoGap = $False }
        Version = @{ OriginalName = '--version'; OriginalPosition = '0'; Position = '0'; ParameterType = [switch]; NoGap = $False }
        ListExtractors = @{ OriginalName = '--list-extractors'; OriginalPosition = '0'; Position = '0'; ParameterType = [switch]; NoGap = $False }
        ListFormats = @{ OriginalName = '--list-formats'; OriginalPosition = '0'; Position = '1'; ParameterType = [switch]; NoGap = $False }
        Format = @{ OriginalName = '--format'; OriginalPosition = '0'; Position = '1'; ParameterType = [string]; NoGap = $False }
        AddMetadata = @{ OriginalName = '--add-metadata'; OriginalPosition = '0'; Position = '2'; ParameterType = [switch]; NoGap = $False }
    }

    $__outputHandlers = @{ Default = @{ StreamOutput = $true; Handler = { $input } } }
}
PROCESS {
    $__commandArgs = @()
    $__boundparms = $PSBoundParameters
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $PSBoundParameters[$_.Name]}).ForEach({$PSBoundParameters[$_.Name] = [switch]::new($false)})
    if ($PSBoundParameters["Debug"]){wait-debugger}
    foreach ($paramName in $PSBoundParameters.Keys|Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $PSBoundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ( $value -is [switch] ) { $__commandArgs += if ( $value.IsPresent ) { $param.OriginalName } else { $param.DefaultMissingValue } }
            elseif ( $param.NoGap ) { $__commandArgs += "{0}""{1}""" -f $param.OriginalName, $value }
            else { $__commandArgs += $param.OriginalName; $__commandArgs += $value |Foreach-Object {$_}}
        }
    }
    $__commandArgs = $__commandArgs|Where-Object {$_}
    if ($PSBoundParameters["Debug"]){wait-debugger}
    if ( $PSBoundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message youtube-dl
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("youtube-dl")) {
        if ( $__handlerInfo.StreamOutput ) {
            & "youtube-dl" $__commandArgs | & $__handler
        }
        else {
            $result = & "youtube-dl" $__commandArgs
            & $__handler $result
        }
    }
  } # end PROCESS

<#
.SYNOPSIS
error running youtube-dl -?.

.DESCRIPTION See help for youtube-dl

.PARAMETER Url



.PARAMETER Help



.PARAMETER Version



.PARAMETER ListExtractors



.PARAMETER ListFormats



.PARAMETER Format



.PARAMETER AddMetadata




#>
}

Export-ModuleMember -Function Invoke-YoutubeDlCommand
