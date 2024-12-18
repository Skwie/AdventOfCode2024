$puzzleInput = @'

'@

$puzzleInput = $puzzleInput -replace "don't\(\)(.|\n)*?do\(\)",""

$regex = [regex] 'mul\(\d{1,3},\d{1,3}\)'

$allMatches = $regex.Matches($puzzleInput)

$total = 0

foreach ($match in $allMatches) {
    $tempStr = $match.Value
    $values = $tempStr.Replace("mul(","").Replace(")","")
    $thisSum = [int]$values.Split(",")[0] * [int]$values.Split(",")[1]
    $total += $thisSum
}

$total