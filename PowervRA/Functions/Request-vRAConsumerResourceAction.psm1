function Request-vRAConsumerResourceAction {
<#
    .SYNOPSIS
    Request an available resourceAction for a catalog resource
    
    .DESCRIPTION
    A resourceAction is a specific type of ResourceOperation that is performed by submitting a request. 
    Unlike ResourceExtensions, resource actions can be invoked via the Service Catalog service and subject to approvals.
    
    .PARAMETER Id
    The Id for the resource action
    
    .PARAMETER ResourceId
    The id of the resource that the resourceAction will execute against

    .PARAMETER ResourceName
    The name of the resource that the resourceAction will execute against

    .INPUTS
    System.String

    .EXAMPLE
    $ResourceActionId = (Get-vRAConsumerResource -Name vm01 | Get-vRAConsumerResourceAction "Reboot").id
    Request-vRAConsumerResourceAction -Id $ResourceActionId -ResourceName vm01

    .EXAMPLE
    Request-vRAConsumerResourceAction -Id 6a301f8c-d868-4908-8348-80ad0eb35b00 -ResourceId 20402e93-fb1d-4bd9-8a51-b809fbb946fd

    .EXAMPLE
    Request-vRAConsumerResourceAction -Id 6a301f8c-d868-4908-8348-80ad0eb35b00 -ResourceName vm01

    .EXAMPLE

    $JSON = @"
        {
            "type":  "com.vmware.vcac.catalog.domain.request.CatalogResourceRequest",
            "resourceId":  "448fcd09-b8c0-482c-abbc-b3ab818c2e31",
            "actionId":  "fae08c75-3506-40f6-9c9b-35966fe9125c",
            "description":  null,
            "data":  {
                         "description":  null,
                         "reasons":  null
                     }
        }        
    "@

    $JSON | Request-vRAConsumerResourceAction

#>
[CmdletBinding(DefaultParameterSetName="Standard")]

    Param (

    [parameter(Mandatory=$true, ParameterSetName="Standard")]
    [parameter(ParameterSetName="ByResourceName")]
    [ValidateNotNullOrEmpty()]
    [String]$Id,
   
    [parameter(Mandatory=$true, ParameterSetName="Standard")]
    [ValidateNotNullOrEmpty()]
    [String]$ResourceId,         

    [parameter(Mandatory=$true, ParameterSetName="ByResourceName")]
    [ValidateNotNullOrEmpty()]
    [String]$ResourceName,
    
    [parameter(Mandatory=$true, ValueFromPipeline=$true, ParameterSetName="JSON")]
    [ValidateNotNullOrEmpty()]
    [String]$JSON
           
    )

    begin {

    }

    process {
                
         try {

            switch ($PsCmdlet.ParameterSetName) {

                'JSON' {

                    # --- Extract id's from json payload
                    $Body = $JSON | ConvertFrom-Json
                    $ResourceId = $Body.resourceId
                    $ActionId = $Body.actionId

                    break

                }

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

            # --- Try to retrieve the resource action for the resource

            $Action = Get-vRAConsumerResourceAction -Id $ActionId -ResourceId $ResourceId

            Write-Verbose "Found resourceAction $($Action.Name) for resource $($ResourceId)" 

            if (!$PSBoundParameters.ContainsKey("JSON")) {

                # --- Get the request template

                Write-Verbose -Message "Retrieving request template"

                $JSON = Get-vRAConsumerResourceActionRequestTemplate -Id $ActionId -ResourceId $ResourceId         

            }

            Write-Verbose "SUCCESS"

            # --- Execute the request     
        
            if ($PSCmdlet.ShouldProcess($ResourceId)){
                
                # --- Build the URI string for the service         
            
                $URI = "/catalog-service/api/consumer/resources/$($ResourceId)/actions/$($ActionId)/requests"
                
                Write-Verbose -Message "Preparing POST to $($URI)"                
           
                $Response = Invoke-vRARestMethod -Method POST -URI $URI -Body ($JSON)

                Write-Verbose "SUCCESS"
                     
            }

        }
        catch [Exception]{

            throw
    
        }

    }       

}