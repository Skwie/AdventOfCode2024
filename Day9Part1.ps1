$puzzleInput = @'

'@

[array]$lines = $puzzleInput.Split("`n").Trim().ToCharArray()

$fileList = [System.Collections.ArrayList]@()
$fileIndex = 0
$counter = 0
foreach ($number in $lines) {
    [int]$num = [convert]::ToInt32($number, 10)
    if ($counter % 2 -eq 0 -or $counter -eq 0) {
        for ($i = 0; $i -lt $num; $i++) {
            $null = $fileList.Add("$fileIndex")
        }
        $fileIndex++
    }
    else {
        for ($i = 0; $i -lt $num; $i++) {
            $null = $fileList.Add(".")
        }
    }
    $counter++
}

for ($i = $fileList.Count - 1; $i -ge 0; $i--) {
    if ($fileList[$i] -match '\d') {
        for ($j = 0; $j -lt $fileList.Count; $j++) {
            if ($fileList[$j] -match '\.' -and $j -lt $i) {
                $fileList[$j] = $fileList[$i]
                $fileList[$i] = '.'
                Break
            }
        }
    }
}

[int64]$sum = 0

for ($i = 0; $i -lt $fileList.Count; $i++) {
    if ($fileList[$i] -match '\d') {
        $sum += [int]$fileList[$i] * $i
    }
}

$sum