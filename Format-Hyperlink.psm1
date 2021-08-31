<#
.Synopsis
 Returns a hyperlink for display in an ANSI-escape-capable Terminal emulator

.Description
 Returns a hyperlink for display in an ANSI-escape-capable Terminal emulator. The URI will be hidden behind the link label via ANSI escape sequences making a more aesthetically-pleasing view. Supported terminal emulators include Windows Terminal, VTK-based Linux terminal emulators, the macOS Terminal, and iTerm.

.Parameter Uri
 The hyperlink destination.

.Parameter Label
 The hyperlink text for display in the terminal emulator.

.Example
 # Use the pipeline to input the Uri
 "https://example.com" | Format-Hyperlink -Label "Example website" | Write-Output

.Example
 # Specify the Uri on the invokation
 Format-Hyperlink -Uri "https://example.com" -Label "Example website" | Write-Output

.Example
 # Output the Uri from the pipeline without a Label
 "https://example.com" | Format-Hyperlink | Write-Output

.Example
 # Output the Uri without a Label
 Format-Hyperlink -Uri "https://example.com" | Write-Output
#>
function Format-Hyperlink {
    param(
        [Parameter(ValueFromPipeline = $true, Position = 0)]
        [Uri] $Uri,

        [Parameter(Mandatory=$false, Position = 1)]
        [string] $Label
    )

    process {
        if (-not $Uri -or $Uri -eq "") {
            if ($Label -and $Label -ne "") {
                return "$Label"
            }
            return ""
        }

        if (($PSVersionTable.PSVersion.Major -lt 6 -or $IsWindows) -and -not $Env:WT_SESSION) {
            # Fallback for Windows users not inside Windows Terminal
            if ($Label -and $Label -ne "") {
                return "$Label ($Uri)"
            }
            return "$Uri"
        }

        if ($Label -and $Label -ne "") {
            return "$([char]0x1b)]8;;$Uri$([char]0x1b)\$Label$([char]0x1b)]8;;$([char]0x1b)\"
        }

        return "$Uri"
    }
}

Export-ModuleMember -Function Format-Hyperlink