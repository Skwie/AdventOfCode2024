$puzzleInput = @'

'@

$lines = $puzzleInput.Split("`n")

function Switch-Direction($direction) {
    if ($direction -eq "up") {
        $direction = "right"
    }
    elseif ($direction -eq "right") {
        $direction = "down"
    }
    elseif ($direction -eq "down") {
        $direction = "left"
    }
    elseif ($direction -eq "left") {
        $direction = "up"
    }
    return $direction
}

function Check-Ahead($currentPos,$direction) {
    [int]$yToCheck,[int]$xToCheck = $currentPos.Split("|")
    if ($direction -eq "up") {
        $yToCheck = $yToCheck - 1
    }
    elseif ($direction -eq "right") {
        $xToCheck = $xToCheck + 1
    }
    elseif ($direction -eq "down") {
        $yToCheck = $yToCheck + 1
    }
    elseif ($direction -eq "left") {
        $xToCheck = $xToCheck - 1
    }

    return "$yToCheck|$xToCheck"
}

function Place-Obstacle($pos,$lines) {
    $tempLine = ""
    for ($i=0;$i -lt $lines[0].Length;$i++) {
        if ($i -eq [int]$pos.Split("|")[1]) {
            $tempLine += "#"
        }
        else {
            $tempLine += $lines[[int]$pos.Split("|")[0]][$i]
        }
    }
    return $tempLine
}

$loopCount = 0

for ($g=0;$g -lt $lines.Count;$g++) {
    for ($f=0;$f -lt $lines[$g].Length;$f++) {
        if ($lines[$g][$f] -notmatch "#" -and $lines[$g][$f] -notmatch "\^") {
            $pos = "$($g)|$($f)"
            $tempLine = Place-Obstacle $pos $lines
            $lines[$g] = $tempLine
        }


        $obstacleList = @()
        $visitedList = @()

        for ($v=0;$v -lt $lines.Count;$v++) {
            for ($h=0;$h -lt $lines[$v].Length;$h++) {
                if ($lines[$v][$h] -match "#") {
                    $obstacleList += "$v|$h"
                }
                elseif ($lines[$v][$h] -match "\^") {
                    $startPos = "$v|$h"
                }
            }
        }

        $direction = "up"
        $currentPos = $startPos
        $visitedList += $currentPos
        $ended = $false

        while (!$ended -and $visitedList.Count -lt 10000) {
            $checkPos = Check-Ahead $currentPos $direction

            if ([int]$checkPos.Split("|")[0] -lt 0 -or [int]$checkPos.Split("|")[0] -ge $lines.Count -or [int]$checkPos.Split("|")[1] -lt 0 -or [int]$checkPos.Split("|")[1] -ge $lines[0].Length) {
                #Write-Output "Moving off the map at $($checkPos)"
                $ended = $true
                Break
            }

            if ($checkPos -in $obstacleList) {
                $direction = Switch-Direction $direction
                #Write-Output "Switching direction - blocked at $($checkpos)"
            }
            else {
                $currentPos = $checkPos
                $visitedList += $currentPos
                #Write-Output "Moving to $($checkPos)"
            }
        }

        $lines = $puzzleInput.Split("`n")

        Write-Output "Ended patrol after $($visitedList.Count) steps"

        if ($visitedList.Count -ge 10000) {
            $loopCount++
        }

    }
}


$loopCount
