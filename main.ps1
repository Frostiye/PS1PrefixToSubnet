Function ConvertFromPrefixToSubnet {
    Param (
        [Int]$PreffixLength
    )

    If ($($PreffixLength -GT 32) -OR $($PreffixLength -LT 0)) { Write-Host "Preffix Length must be between 0-32" }

    $SubnetMask_ = New-Object System.Collections.Generic.List[System.Object]

    $Bytes, $Bits = ([String]($PreffixLength/8)).Split(".")
    $Bits = [float]("0."+$Bits)
    $Bits = 8*$Bits

    $BitValues = 128, 64, 32, 16, 8, 4, 2, 1

    If ($Bytes -GT 0) {ForEach ($index In 1..$Bytes) { $SubnetMask_.Add(255) }}

    If ($Bits -GT 0) {
        $sTotal = 0
        ForEach ($index In 0..$($Bits-1)) {
            $sTotal = $BitValues[$index] + $sTotal
        }
        $SubnetMask_.Add($sTotal)
    }
    
    While ($SubnetMask_.ToArray().Length -NE 4) {
        $SubnetMask_.Add(0)
    }

    Return $($SubnetMask_.ToArray() -Join ".")
}
