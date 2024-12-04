# File path to append data
$FilePath = "output.txt"

# Clear or create the file
Set-Content -Path $FilePath -Value ""

# Thread names
$Threads = @("Thread1", "Thread2", "Thread3")

# Parallel operation
$Threads | ForEach-Object -Parallel {
    param ($FilePath) # File path passed from parent scope
    for ($i = 1; $i -le 10; $i++) {
        $content = "[${using:$_}][Item${i}]"
        Add-Content -Path $using:FilePath -Value $content
        Start-Sleep -Milliseconds (Get-Random -Minimum 100 -Maximum 500)
    }
} -ThrottleLimit 3 -ArgumentList $FilePath

# Display the content of the file
Get-Content -Path $FilePath
