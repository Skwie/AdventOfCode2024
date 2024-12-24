$puzzleInput = @'

'@

$lines = $puzzleInput.Split("`n").Trim()

$map = [System.Collections.ArrayList]@()
$symbols = @()
$antiNodes = @()
$antennae = @()

for ($h=0;$h-lt$lines.Count;$h++) {
    for ($i=0;$i-lt$lines[$h].Length;$i++) {
        # check for any symbol that's not a period marker
        if ($lines[$h][$i] -notmatch '\.') {
            # check if the symbol found is new
            if ($lines[$h][$i] -cin $symbols) {
                # Powershell has no case-sensitive version of notin, so we need to use the else here
            }
            else {
                # add symbol to array of used symbols
                $symbols += $lines[$h][$i]
            }
            # add symbol and coords to arraylist which we use to map coords to the symbols
            # null to avoid unnecessary output
            $null = $map.Add(@{"$($lines[$h][$i])" = "$($i),$($h)"})
            $antennae += "$($i),$($h)"
        }
    }
}

# loop through symbols
foreach ($symbol in $symbols) {
    # loop through coordinates and handle them separately
    foreach ($coord in ($map | Where-Object {$_.Keys -cmatch $symbol})) {
        [int]$sourceX,[int]$sourceY = $coord.Values.Split(",")
        # loop through coords again to compare one coord with the rest
        foreach ($comparecoord in ($map | Where-Object {$_.Keys -cmatch $symbol})) {
            if ($coord.Values -eq $comparecoord.Values) {
                # skip the coord we're comparing
                Continue
            }
            else {
                [int]$compareX,[int]$compareY = $comparecoord.Values.Split(",")
                $xDiff = $sourceX - $compareX
                $yDiff = $sourceY - $compareY

                # all node pairs are assessed twice, which is very convenient as this allows us to check in both directions easily
                $antiX = $sourceX + $xDiff
                $antiY = $sourceY + $yDiff

                # repeat until edge of map is reached
                while ($antiX -ge 0 -and $antiY -ge 0 -and $antiX -lt $lines[0].Length -and $antiY -lt $lines.Count) {
                    $antiNode = "$antiX,$antiY"
                    if ($antiNode -notin $antiNodes) {
                        $antiNodes += $antiNode
                    }
                    $antiX = $antiX + $xDiff
                    $antiY = $antiY + $yDiff
                }
            }
        }
    }
}

# add antennae to antinodes
foreach ($antenna in $antennae) {
    if ($antenna -notin $antiNodes) {
        $antiNodes += $antenna
    }
}

# draw map
$newmap = @()
for ($h=0;$h-lt$lines.Count;$h++) {
    $line = ""
    for ($i=0;$i-lt$lines[$h].Length;$i++) {
        if ("$i,$h" -in $antiNodes) {
            $line += "#"
        }
        elseif ("$i,$h" -in $map.Values) {
            $line += ($map | Where-Object {$_.Values -eq "$i,$h"}).Keys
        }
        else {
            $line += "."
        }
    }
    $newmap += $line
}

$antiNodes.Count