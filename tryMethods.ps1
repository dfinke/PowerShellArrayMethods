. .\RubyArraylistConstructs.ps1

function Get-TargetArray { "a","b","c" }


[System.Collections.ArrayList]$list = $null

"## Pop"
$list=Get-TargetArray
$list.Pop()
"$list"

''
"## Push"
$list=Get-TargetArray
$list.Push("d")
"$list"

''
"## Pop 2"
"$($list.Pop(2))"
"$list"

''
"## Unshift"
$list.Unshift(1)
"$list"

''
"## Unshift multiple"
$list.Unshift(3,4)
"$list"

''
"## Shift"
$list.Shift()
"$list"

''
"## Shift multiple"
"$($list.Shift(2))"
"$list"

''
"## Push back to original"
$list.push('c')
"$list"
