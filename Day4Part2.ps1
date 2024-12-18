$puzzleInput = @'

'@

$lines = $puzzleInput.Split("`n")

[int]$counter = 0

function Find-X-Mas($start,$x,$y) {
    $count = 0
    if ($start -match "A" -and $x -gt 0 -and $y -gt 0 -and $x -lt $lines.Count-1 -and $y -lt $lines[0].Length-1) {
        if ($lines[$x-1][$y-1] -match "M") {
            if ($lines[$x+1][$y+1] -match "S") {
                if ($lines[$x-1][$y+1] -match "M") {
                    if ($lines[$x+1][$y-1] -match "S") {
                        $count++
                    }
                }
                if ($lines[$x-1][$y+1] -match "S") {
                    if ($lines[$x+1][$y-1] -match "M") {
                        $count++
                    }
                }
            }
        }
        if ($lines[$x-1][$y-1] -match "S") {
            if ($lines[$x+1][$y+1] -match "M") {
                if ($lines[$x-1][$y+1] -match "S") {
                    if ($lines[$x+1][$y-1] -match "M") {
                        $count++
                    }
                }
                if ($lines[$x-1][$y+1] -match "M") {
                    if ($lines[$x+1][$y-1] -match "S") {
                        $count++
                    }
                }
            }
        }
    }
    $count
}

for ($i=0;$i -lt $lines.Count;$i++) {
    for ($j=0;$j -lt $lines[$i].Length;$j++) {
        $counter += [int](Find-X-Mas $lines[$i][$j] $i $j)
    }
}

$counter