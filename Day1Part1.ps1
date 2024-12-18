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

$sortedA = $columnA | Sort
$sortedB = $columnB | Sort

$answer = 0

for ($i=0;$i -lt $columnA.Length;$i++) {
    $val = $sortedA[$i] - $sortedB[$i]
    if ($val -lt 0) {$val = -$val}
    $answer += $val
}

$answer