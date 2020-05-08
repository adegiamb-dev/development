function Code-Coverage{
    $requiredTools = @{
        "coverlet.console" = "1.7.1";
        "dotnet-reportgenerator-globaltool" = "4.5.6";
    }
    
    
    
    $installedTools = (dotnet tool list -g | Select -Skip 2  | Out-String)
    
    foreach ($requiredTool in $requiredTools.Keys){
        if (! $installedTools.Contains($requiredTool)){
            Write-Error "Required tool missing  $($requiredTool) >= $($requiredTools[$requiredTool])"
        }
     
    }
    
    $testResultsPath = Join-Path  $PWD  "TestResults/"
     
    $testResultsFile = Join-Path  $testResultsPath  "coverage.opencover.xml"
    
    $testReportPath = Join-Path  $testResultsPath  "report"
    
    
    dotnet test  /p:CollectCoverage=true /p:CoverletOutput=$testResultsPath /p:CoverletOutputFormat="opencover"
    
    
    reportgenerator -reports:$testResultsFile -targetdir:$testReportPath
}