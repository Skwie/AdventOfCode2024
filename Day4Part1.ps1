$puzzleInput = @'

'@

$lines = $puzzleInput.Split("`n")

[int]$counter = 0

function Find-Xmas($start,$xpos,$ypos) {
    $count = 0
    if ($start -match "X") {
        if ($xpos -ge 1 -and $lines[$xpos-1][$ypos] -match "M") {
            if ($xpos -ge 2 -and $lines[$xpos-2][$ypos] -match "A") {
                if ($xpos -ge 3 -and $lines[$xpos-3][$ypos] -match "S") {
                    $count++
                }
            }
        }
        if ($xpos -ge 1 -and $ypos -ge 1 -and $lines[$xpos-1][$ypos-1] -match "M") {
            if ($xpos -ge 2 -and $ypos -ge 2 -and $lines[$xpos-2][$ypos-2] -match "A") {
                if ($xpos -ge 3 -and $ypos -ge 3 -and $lines[$xpos-3][$ypos-3] -match "S") {
                    $count++
                }
            }
        }
        if ($xpos -ge 1 -and $ypos -lt $lines[0].Length-1 -and $lines[$xpos-1][$ypos+1] -match "M") {
            if ($xpos -ge 2 -and $ypos -lt $lines[0].Length-2 -and $lines[$xpos-2][$ypos+2] -match "A") {
                if ($xpos -ge 3 -and $ypos -lt $lines[0].Length-3 -and $lines[$xpos-3][$ypos+3] -match "S") {
                    $count++
                }
            }
        }
        if ($xpos -lt $lines.Count-1 -and $lines[$xpos+1][$ypos] -match "M") {
            if ($xpos -lt $lines.Count-2 -and $lines[$xpos+2][$ypos] -match "A") {
                if ($xpos -lt $lines.Count-3 -and $lines[$xpos+3][$ypos] -match "S") {
                    $count++
                }
            }
        }
        if ($xpos -lt $lines.Count-1 -and $ypos -ge 1 -and $lines[$xpos+1][$ypos-1] -match "M") {
            if ($xpos -lt $lines.Count-2 -and $ypos -ge 2 -and $lines[$xpos+2][$ypos-2] -match "A") {
                if ($xpos -lt $lines.Count-3 -and $ypos -ge 3 -and $lines[$xpos+3][$ypos-3] -match "S") {
                    $count++
                }
            }
        }
        if ($xpos -lt $lines.Count-1 -and $ypos -lt $lines[0].Length-1 -and $lines[$xpos+1][$ypos+1] -match "M") {
            if ($xpos -lt $lines.Count-2 -and $ypos -lt $lines[0].Length-2 -and $lines[$xpos+2][$ypos+2] -match "A") {
                if ($xpos -lt $lines.Count-3 -and $ypos -lt $lines[0].Length-3 -and $lines[$xpos+3][$ypos+3] -match "S") {
                    $count++
                }
            }
        }
        if ($ypos -ge 1 -and $lines[$xpos][$ypos-1] -match "M") {
            if ($ypos -ge 2 -and $lines[$xpos][$ypos-2] -match "A") {
                if ($ypos -ge 3 -and $lines[$xpos][$ypos-3] -match "S") {
                    $count++
                }
            }
        }
        if ($ypos -lt $lines[0].Length-1 -and $lines[$xpos][$ypos+1] -match "M") {
            if ($ypos -lt $lines[0].Length-2 -and $lines[$xpos][$ypos+2] -match "A") {
                if ($ypos -lt $lines[0].Length-3 -and $lines[$xpos][$ypos+3] -match "S") {
                    $count++
                }
            }
        }
    }
    $count
}

for ($i=0;$i -lt $lines.Count;$i++) {
    for ($j=0;$j -lt $lines[$i].Length;$j++) {
        $counter += [int](Find-Xmas $lines[$i][$j] $i $j)
    }
}

$counter