# $numbers = 1..10

# $numbers | ForEach-Object -Parallel {
#     Start-Sleep -Milliseconds 500
#     $_ * 2
# } -ThrottleLimit 3

# Throttle Limit 5 (default)
# Controls how many paralle operations can be run simultaneously.


$websites = @(
    'google.in',
    'duckduckgo.com',
    'github.com'
)

$results = $websites | ForEach-Object -Parallel {
    $result = Test-Connection -TargetName $_ -Count 1 -ErrorAction SilentlyContinue

    [PSCustomObject]@{
        Website = $_
        Status = if ($result) { "SUCCESS" } else { "FAILURE" }
        ResponseTime = if ($result) { $result.Latency} else { 0 }
        TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }
} -ThrottleLimit 3

$results | Format-Table -AutoSize