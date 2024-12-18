$puzzleInput = @"

"@

$cleanInput = ($puzzleInput -replace "`n"," ").Split("   ")
$inputArray = @()
foreach ($char in $cleanInput) {
    if ([int]$char -gt 0) {
        $inputArray += [int]$char
    }
}

$columnA = @()
$columnB = @()

for ($i=0;$i -lt $inputArray.Length;$i++) {
    if ($i % 2 -eq 0) {
        $columnA += $inputArray[$i]
    }
    else {
        $columnB += $inputArray[$i]
    }
}

$answer = 0

foreach ($value in $columnA) {
    $counter = 0
    foreach ($val in $columnB) {
        if ($val -eq $value) {
            $counter++
        }
    }
    $answer += $value*$counter
}

$answer