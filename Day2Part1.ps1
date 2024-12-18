$puzzleInput = @"

"@

$cleanInput = ($puzzleInput -replace "`n",".").Split(".")

$safe = 0

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
            if ([int]$inp[$i] -le [int]$inp[$i-1]) {
                $isSafe = $false
                Break
            }
            elseif ([int]$inp[$i]-[int]$inp[$i-1] -gt 3) {
                $isSafe = $false
                Break
            }
        }
        else {
            if ([int]$inp[$i] -ge [int]$inp[$i-1]) {
                $isSafe = $false
                Break
            }
            elseif ([int]$inp[$i-1]-[int]$inp[$i] -gt 3) {
                $isSafe = $false
                Break
            }
        }
    }
    if ($isSafe) {
        $safe++
        Write-Output "Safe: $($inp)"
    }
    else {
        Write-Output "Not Safe: $($inp)"

    }
}

$safe