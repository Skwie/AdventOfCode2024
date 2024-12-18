$puzzleInput = @"

"@

$cleanInput = ($puzzleInput -replace "`n",".").Split(".")

$safe = 0
$unsafe = 0
$skipped = $false
$safeArray = @()

foreach ($tempInp in $cleanInput) {
    $inp = $tempInp.Split(" ")
    $isSafe = $true
    if ([int]$inp[1] -gt [int]$inp[0]) {
        $asc = $true
    }
    else {
        $asc = $false
    }
    for ($i=0;$i -lt $inp.Length;$i++) {
        if ($i -eq 0) {
            Continue
        }
        if ($asc) {
            if (!$skipped) {
                if ([int]$inp[$i] -le [int]$inp[$i-1]) {
                    #Write-Output "$($inp[$i]) is unsafe"
                    $unsafe++
                    $skipped = $true
                }
                elseif ([int]$inp[$i]-[int]$inp[$i-1] -gt 3) {
                    #Write-Output "$($inp[$i]) is unsafe"
                    $unsafe++
                    $skipped = $true
                }
                else {
                    $skipped = $false
                }
            }
            else {
                if ([int]$inp[$i] -le [int]$inp[$i-2]) {
                    #Write-Output "$($inp[$i]) is unsafe"
                    $unsafe++
                    $skipped = $true
                }
                elseif ([int]$inp[$i]-[int]$inp[$i-2] -gt 3) {
                    #Write-Output "$($inp[$i]) is unsafe"
                    $unsafe++
                    $skipped = $true
                }
                else {
                    $skipped = $false
                }
            }
            if ($unsafe -gt 1) {
                $isSafe = $false
                $fault = $inp[$i]
                Break
            }
        }
        else {
            if (!$skipped) {
                if ([int]$inp[$i] -ge [int]$inp[$i-1]) {
                    $unsafe++
                    $skipped = $true
                }
                elseif ([int]$inp[$i-1]-[int]$inp[$i] -gt 3) {
                    $unsafe++
                    $skipped = $true
                }
                else {
                    $skipped = $false
                }
            }
            else {
                if ([int]$inp[$i] -ge [int]$inp[$i-2]) {
                    $unsafe++
                    $skipped = $true
                }
                elseif ([int]$inp[$i-2]-[int]$inp[$i] -gt 3) {
                    $unsafe++
                    $skipped = $true
                }
                else {
                    $skipped = $false
                }
            }
            if ($unsafe -gt 1) {
                $isSafe = $false
                $fault = $inp[$i]
                Break
            }
        }
    }
    if ($isSafe) {
        $safe++
        #Write-Output "Safe: $($inp)"
    }
    else {
        # check if it's safe when we skip any one of the levels
        for ($h=0;$h -lt $inp.Length;$h++) {
            $tempInput = @()
            for ($i=0;$i -lt $inp.Length;$i++) {
                if ($i -ne $h) {
                    $tempInput += $inp[$i]
                }
            }
            #$tempInput
            $isSafe = $true
            for ($i=0;$i -lt $tempInput.Length;$i++) {
                if ([int]$tempInput[1] -gt [int]$tempInput[0]) {
                    $asc = $true
                }
                else {
                    $asc = $false
                }
                if ($i -eq 0) {
                    Continue
                }
                if ($asc) {
                    if ([int]$tempInput[$i] -le [int]$tempInput[$i-1]) {
                        #Write-Output "$($inp[$i]) is unsafe"
                        $isSafe = $false
                        $fault = $tempInput[$i]
                        Break
                    }
                    elseif ([int]$tempInput[$i]-[int]$tempInput[$i-1] -gt 3) {
                        #Write-Output "$($inp[$i]) is unsafe"
                        $isSafe = $false
                        $fault = $tempInput[$i]
                        Break
                    }
                }
                else {
                    if ([int]$tempInput[$i] -ge [int]$tempInput[$i-1]) {
                        $isSafe = $false
                        $fault = $tempInput[$i]
                        Break
                    }
                    elseif ([int]$tempInput[$i-1]-[int]$tempInput[$i] -gt 3) {
                        $isSafe = $false
                        $fault = $tempInput[$i]
                        Break
                    }
                }
            }
            if ($isSafe) {
                Break
            }
        }

        if ($isSafe) {
            $safe++
            $safeArray += $tempInp
            #Write-Output "Safe: $($inp)"
        }
        else {
            Write-Output "Not Safe: $($inp) | Fault: $fault"
        }
    }
    $unsafe = 0
    $skipped = $false
}

$safe