Update-TypeData -Force -TypeName System.Collections.ArrayList -MemberType ScriptMethod -MemberName Push -Value {
    foreach($v in $args) {
        [void]$this.Add($v)
    }
}

Update-TypeData -Force -Typename System.Collections.ArrayList -MemberType ScriptMethod -MemberName Pop -Value {

    $targetIndex = 1
    if($args.Count -gt 0) { $targetIndex = $args[0] }
    $targetIndex--

    [System.Collections.ArrayList]$val=@()
    0..$targetIndex | %{
        if ( $this.count -gt 0 ) {
            $val += $this[$this.count-1]
            $this.RemoveAt(($this.count - 1))
        }
    }

    return $val
}

Update-TypeData -Force -Typename System.Collections.ArrayList -MemberType ScriptMethod -MemberName Shift -Value {

    $targetIndex = 1

    if($args.Count -gt 0) { $targetIndex = $args[0] }

    $targetIndex--

    if ($this.count -gt 0) {
        return 0..$targetIndex |
            ForEach {
                $this[0]
                $this.RemoveAt(0)
            }
    }
}

Update-TypeData -Force -Typename System.Collections.ArrayList -MemberType ScriptMethod -MemberName Unshift -Value {
    for($i = $args.count -1; $i -ge 0; $i--) {
        $this.insert(0,$args[$i])
    }
}