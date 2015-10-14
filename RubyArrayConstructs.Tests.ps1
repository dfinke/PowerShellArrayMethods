$scriptRoot = Split-Path $MyInvocation.MyCommand.Path
. "$scriptRoot\RubyArraylistConstructs.ps1"

Describe "Ruby array constructs are available on an ArrayList" {

    BeforeEach {
        [system.collections.arraylist]$al = 2,4,8
    }

    It "Can push a new value in the right place" {
        $al.Push(16)
        $al[-1] | Should be 16
    }

    It "Can push new values to the end of the list" {
        $al.Push(32,64)
        $al[-1] | should be 64
        $al[-2] | Should be 32
        $al[-3] | should be 8
    }

    It "Can push a new value to the beginning of the list" {
        $al.Unshift(1)
        $al[0] | should be 1
        $al.Count | should be 4
    }

    It "Can push new values to the beginning of the list" {
        $al.Unshift(0,1)
        $al.Count | should be 5
        $al[0] | should be 0
        $al[1] | should be 1
        $al[2] | should be 2
    }

    It "Shift returns the right value and adjusts the array" {
        $v = $al.Shift()
        $v | Should be 2
        $al.count | should be 2
        $al[0] | should be 4
    }

    It "Shift more than one item" {
        $v = $al.Shift(2)
        $v.count | Should be 2
        $v[0] | Should be 2
        $v[1] | Should be 4
        $al.count | should be 1
        $al[0] | should be 8
    }

    It "Pop returns the right value and adjusts the array" {
        $v = $al.Pop()
        $v | Should be 8
        $al.count | should be 2
        $al[0] | should be 2
    }

    It "Pop returns more than one value and adjusts the array" {
        $v = $al.Pop(2)

        $v.count | should be 2

        $v[0] | should be 8
        $v[1] | should be 4

        $al.count | should be 1
        $al[0] | should be 2
    }

    It "Shift should work when requesting more items than remain" {
        [system.collections.arraylist]$a = 1..10

        $count=1
        $h=@{}
        while($a) {
            $h."grp$($count)" = $a.shift(4)
            $count++
        }

        $a | Should be $null
        $h.keys.count| should be 3

        $h.grp1.count | should be 4
        $h.grp2.count | should be 4
        $h.grp3.count | should be 2
    }
}