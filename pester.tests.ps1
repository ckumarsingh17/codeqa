# pester.tests.ps1

# Import the Pester module
Import-Module Pester
Import-Module PSScriptAnalyzer

Describe "Code Syntax and Best Practices Tests" {
    It "Should pass ScriptAnalyzer checks" {
        # Replace 'YourScript.ps1' with the path to your PowerShell script
        $results = Invoke-ScriptAnalyzer -Path "pester.tests.ps1"
        $results.Count | Should Be 0
    }
}
Describe "Secrets and Passwords Tests" {
    It "Should not contain sensitive information" {
        $scriptContent = Get-Content -Path "*.ps1" -Raw

        # Define patterns to check for secrets, passwords, and tokens
        $sensitivePatterns = @(
            "password\s*=\s*'[^']*'",
            "token\s*=\s*'[^']*'",
            "secret\s*=\s*'[^']*'"
            # Add more patterns as needed
        )

        # Check if the script content matches any of the sensitive patterns
        $matches = $sensitivePatterns | ForEach-Object { $scriptContent | Select-String -Pattern $_ }

        $matches | Should BeNullOrEmpty
    }
}
# Run the tests
$result = Invoke-Pester -Path "pester.tests.ps1"

# Exit with an appropriate exit code (0 for success, 1 for failure)
if ($result.FailedCount -gt 0) {
    Write-Host "Tests failed!" -ForegroundColor Red
    exit 1
} else {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
}
