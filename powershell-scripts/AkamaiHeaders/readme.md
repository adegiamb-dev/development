# Akamai Headers Powershell Module

## Description

Akamai Header Powershell Module shows you the common Akamai headers that is used to determine if the request is cached or not.


## Installation 
Copy the AkamaiHeaders folder to one of paths that is listed in PSModulePath environment.

```$ENV:PSModulePath```

## Usage
```Show-AkamaiHeaders https://www.microsoft.com```

### Sample Output

```
Name                           Value
----                           -----
Cache                          TCP_MISS from a104-123-196-148.deploy.akamaitechnologies.com (AkamaiGHost/10.0.0.1-29304580) (-)
Cache Description              TCP_MISS Object was not in cache, server fetched object from the forward server.
Cache Key                      /L/marketingsites-prod.microsoft.com/en-ca/ vcd=3547
Cache Length                   1h - hour(s)
Cacheable                      NO
Response Status Code           200 (OK)

```