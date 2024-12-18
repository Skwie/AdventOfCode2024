$puzzleInput = @'

'@

$lines = $puzzleInput.Split("`n")
$rules = @()
$pages =  @()
$correctOrder = @()
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
}

foreach ($page in $correctOrder) {
    $pageArray = $page.Split(',')
    $mid = $pageArray[([math]::ceiling($pageArray.Count/2))-1]
    $total += $mid
}

$total