# Code Coverage Powershell Module

## Description
The code coverage module generate a code coverage report using coverlet and ReportGenerator .NET Core global tools.


## Requirements 

### Required Tools
To use the module you will need to have the following .NET Core Global tools:

- https://www.nuget.org/packages/dotnet-reportgenerator-globaltool/
- https://www.nuget.org/packages/coverlet.console/


### Unit Test Project

You will need to install __coverlet.msbuild__ nuget package into your unit test project.

#### Installation
``` dotnet add package coverlet.msbuild```

# Usage
To execute __code-coverage__ you need to browse to where your solution (.sln) is located and run

```code-coverage```

Once the module is done you will have a new folder called __TestResults__ that will contain:

- a file called __coverage.opencover.xml__ that coverlet command generated and then used with reprotgenerator command as in the input file.
- a new folder called report that will contain the code coverage report that you can view in your favorite Brower.


# Installation
Copy the CodeCoverage folder to one of path that is listed in PSModulePath environment.

```$ENV:PSModulePath```

Once copied you may need to restart the command prompt before the module is available. 
