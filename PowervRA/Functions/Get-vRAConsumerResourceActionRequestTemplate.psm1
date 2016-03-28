function Get-vRAConsumerResourceActionRequestTemplate {
<#
    .SYNOPSIS
    Get the request template of a resource action that the user is entitled to see
    
    .DESCRIPTION
    Get the request template of a resource action that the user is entitled to see
    
    .PARAMETER Id
    The id of the resource action

    .PARAMETER Name
    The name of the resource action

    .INPUTS
    System.String

    .OUTPUTS
    System.String

    .EXAMPLE
    Get-vRAConsumerResourceActionRequestTemplate -Id "fae08c75-3506-40f6-9c9b-35966fe9125c" -ResourceName vm01
    
    .EXAMPLE
    Get-vRAConsumerResourceActionRequestTemplate -Id "fae08c75-3506-40f6-9c9b-35966fe9125c" -ResourceId 20402e93-fb1d-4bd9-8a51-b809fbb946fd

    .EXAMPLE
    Get-vRAConsumerResource -Name vm21 | Get-vRAConsumerResourceActionRequestTemplate -Id fae08c75-3506-40f6-9c9b-35966fe9125c
    
#>
[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.String')]

    Param (

    [parameter(Mandatory=$true, ParameterSetName="Standard")]
    [parameter(ParameterSetName="ByResourceName")]
    [ValidateNotNullOrEmpty()]
    [String]$Id,
   
    [parameter(Mandatory=$true, ValueFromPipelineByPropertyName, ParameterSetName="Standard")]
    [ValidateNotNullOrEmpty()]
    [String]$ResourceId,         

    [parameter(Mandatory=$true, ParameterSetName="ByResourceName")]
    [ValidateNotNullOrEmpty()]
    [String]$ResourceName
           
    )
    
    Begin {
                      
    }    
 
    Process {

        try {

            switch ($PsCmdlet.ParameterSetName) {

                'ByResourceName' {

                    # --- Get the resource id
                    Write-verbose -Message "Retrieving Id for resource $($Name)"
                    $Resource = Get-vRAConsumerResource -Name $ResourceName
                    $ResourceId = $Resource.ResourceId
                    $ActionId = $Id

                    break

                }

                'Standard' {

                    # --- Set Id param to ActionId
                    $ActionId = $Id

                    break
                }

            }
                              
            $URI = "/catalog-service/api/consumer/resources/$($ResourceId)/actions/$($ActionId)/requests/template"

            Write-Verbose -Message "Preparing GET to $($URI)"
       
            $Response = Invoke-vRARestMethod -Method GET -URI $URI   

            Write-Verbose "SUCCESS"
                        
            $Response | ConvertTo-Json -Depth 100                        
                                        
        }
        catch [Exception]{
            
            throw

        }
        
    }           
     
}