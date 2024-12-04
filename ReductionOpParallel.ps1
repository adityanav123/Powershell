$numbers = 1..100

# Create thread-safe dictionary
$sum = [System.Collections.Concurrent.ConcurrentDictionary[string, int]]::new()
$sum["total"] = 0

$numbers | ForEach-Object -Parallel {
    # Get the shared dictionary using $using scope
    $sharedSum = $using:sum
    $currentValue = $_
    
    # Update the value atomically
    $sharedSum.AddOrUpdate("total", 
        $currentValue,
        {param($key, $oldValue) $oldValue + $currentValue}
    )
} -ThrottleLimit 5

$sum["total"]
