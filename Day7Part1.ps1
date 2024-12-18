$puzzleInput = @'

'@

$lines = $puzzleInput.Split("`n")

$result = 0

foreach ($line in $lines) {
    [int64]$sum = $line.Split(":")[0]
    $equation = $line.Split(":")[1].Trim()
    $parts = $equation.Split(" ")

    $options = @()
    $replacer = @()

    for ($i=0;$i -lt $parts.Count;$i++) {
        if ($i -eq 0) {
            $options += [int]$parts[0]
        }
        else {
            foreach ($opt in $options) {
                $replacer += $opt + $parts[$i]
                $replacer += $opt * $parts[$i]
            }
            $options = $replacer
            $replacer = @()
        }
    }

    if ($sum -in $options) {
        $result += $sum
    }
}

$result