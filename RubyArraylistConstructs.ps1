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

    if($targetIndex -gt $this.count) {
        $this
        $this.Clear()
    } else {
        $targetIndex--

        if ($this.count -gt 0) {
            return 0..$targetIndex |
                ForEach {
                    $this[0]
                    $this.RemoveAt(0)
                }
        }
    }
}

Update-TypeData -Force -Typename System.Collections.ArrayList -MemberType ScriptMethod -MemberName Unshift -Value {
    for($i = $args.count -1; $i -ge 0; $i--) {
        $this.insert(0,$args[$i])
    }
}

Update-TypeData -Force -TypeName System.String -MemberType ScriptMethod -MemberName Translate -Value {
    
    $InputTable  = $args[0]
    $OutputTable = $args[1]
    
    $TranslationTable = @{}
    
    $result = $null

    for($idx=0; $idx -lt $InputTable.Length; $idx+=1) {
        $TranslationTable[$InputTable[$idx]]=$OutputTable[$idx]
    }    

    for($idx=0; $idx -lt $this.Length; $idx+=1) {

        $char = $this[$idx]
        $found = $TranslationTable[$char]

        if($found) { $result+=$found } 
              else { $result+=$char  }
    }

    return $result    
}