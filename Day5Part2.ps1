$puzzleInput = @'

'@

function Resolve-PageOrder($pageArr,$ruleList) {
    $replaced = $false
    for ($i=0;$i -lt $pageArr.Count-1;$i++) {
        if ("$($pageArr[$i])|$($pageArr[$i+1])" -in $ruleList) {
            Write-Verbose "Pages $($pageArr[$i]) $($pageArr[$i+1]) are in the correct order"
        }
        else {
            Write-Verbose "Pages $($pageArr[$i]) $($pageArr[$i+1]) are in the wrong order"
            if ("$($pageArr[$i+1])|$($pageArr[$i])" -in $ruleList) {
                Write-Verbose "But the reverse works"
                $temp = $pageArr[$i]
                $tempplus = $pageArr[$i+1]
                $pageArr[$i] = $tempplus
                $pageArr[$i+1] = $temp
                $replaced = $true
            }
            else {
                Write-Verbose "And so is the reverse"
            }
        }
    }
    if ($replaced) {
        Resolve-PageOrder $pageArr $ruleList
    }
    else {

        $mid = $pageArray[([math]::ceiling($pageArray.Count/2))-1]
        return $mid
    }
}

$lines = $puzzleInput.Split("`n")
$rules = @()
$pages =  @()
$correctOrder = @()
$incorrectOrder = @()
$total = 0

foreach ($line in $lines) {
    if ($line -match '\d+\|\d+') {
        $rules += $line.Trim()
    }
    else {
        if ($line -match '\d') {
            $pages += $line.Trim()
        }
    }
}


foreach ($page in $pages) {
    $pageArray = $page.Split(',')
    $correct = $true
    for ($i=0;$i -lt $pageArray.Count-1;$i++) {
        if ("$($pageArray[$i])|$($pageArray[$i+1])" -in $rules) {
            Continue
        }
        else {
            $correct  = $false
            Break
        }
    }
    if ($correct) {
        $correctOrder += $page
    }
    else {
        $incorrectOrder += $page
    }
}

$resolvedPages = @()

foreach ($page in $incorrectOrder) {
    $pageArray = $page.Split(',')
    $total += Resolve-PageOrder $pageArray $rules
}

$total