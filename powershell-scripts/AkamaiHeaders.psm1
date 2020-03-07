function Show-AkamaiHeaders{
    param(
        [string] $uri
    )

    $cacheResponseDescriptions = @{
        "TCP_HIT" = "Object was fresh in cache and object from disk cache."
        "TCP_MISS" = "Object was not in cache, server fetched object from the forward server."
        "TCP_REFRESH_HIT" = "Object was stale in cache and was successfully refreshed with the origin on an If-Modified-Since request."
        "TCP_REFRESH_MISS" = "Object was stale in cache and refresh obtained a new object from forward server in response to our IF-Modified-Since request."
        "TCP_REFRESH_FAIL_HIT" = "Object was stale in cache and failed on refresh (couldn't reach origin) so the stale object was served ."
        "TCP_IMS_HIT" = "IF-Modified-Since request from client and object was fresh in cache and served."
        "TCP_NEGATIVE_HIT" = "Object previously returned a 'not found' (or any other negatively cacheable response) and that cached response was a hit for this new request."
        "TCP_MEM_HIT" = "Object was on disk and in the memory cache. Server served it without hitting the disk. "
     }
    
     $cacheSettingDescriptions = @{
        "0s" = "0 second cache meaning serve from cache but revalidate on every request, e.g. check origin but don't re-download unless changed"
        "000" = "Non-cacheable...a key code to recognise"
        "s" = "second(s)"
        "m" = "minute(s)"
        "h" = "hour(s)"
     }    
     
     $headers = @{
        "pragma" = "akamai-x-cache-on, akamai-x-cache-remote-on, akamai-x-check-cacheable, akamai-x-get-cache-key, akamai-x-get-true-cache-key, akamai-x-get-extracted-values, akamai-x-get-ssl-client-session-id, akamai-x-serial-no, akamai-x-get-request-id"
     }

     function AddCacheDetails($headers,[hashtable]$hash){
        if ( $headers && $hash){
            
            $cacheHeader = $headers["x-cache"];
    
            if ($cacheHeader){
    
                $hash["Cache"] = $($cacheHeader)
                $key = $cacheHeader.Split(" ")[0]
                $hash["Cache Description"] = "$key $($cacheResponseDescriptions[$key])"
            }
        }
    }
    
    function AddCacheKeyDetails($headers,[hashtable]$hash){
        if ( $headers && $hash)
        {
            $internalKey= $headers["x-cache-key-extended-internal-use-only"]
    
            if ($internalKey)
            {
                if ($internalKey.StartsWith('S'))
                {
                    $internalKey = $internalKey.SubString(2);
                }
                
                $internalKeySections = $internalKey.Split("/");
        
               $cacheLength =  $internalKeySections[3]
            }
    
            $cacheLengthDescription = "N/A"
            
            if ($cacheLength -eq "0s" -or $cacheLength -eq "000")
            {
                $cacheLengthDescription = $cacheSettingDescriptions[$cacheLength]
            }else
            {
               $timeUnit = $cacheLength.SubString($cacheLength.Length -1);
               $cacheLengthDescription = $cacheSettingDescriptions[$timeUnit]
            }
    
            $hash["Cache Length"] = "$cacheLength - $cacheLengthDescription"
        }
    }


     
    
     try{
        $response = Invoke-WebRequest   `
            -Headers  $headers `
            -URI  $uri `
            -ErrorAction Stop
        
        $response.StatusCode
    
        $display = @{}
        
     
        AddCacheDetails $response.Headers $display
        AddCacheKeyDetails $response.Headers $display
       
        $display["Response Status Code"] = "$($response.StatusCode) ($($response.StatusDescription))"
        $display["Cache Key"] = "$($response.Headers["x-true-cache-key"])"
        $display["Cacheable"] = "$($response.Headers["x-check-cacheable"])"
        
    
        $display.GetEnumerator() | Sort-Object -Property key |  Format-Table -Wrap
     }
     catch{
        Write-Error $_.Exception
     }

}