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
    $ResourceActionId | Request-vRAConsumerResourceAction -ResourceName vm01

    .EXAMPLE
    Request-vRAConsumerResourceAction -Id 6a301f8c-d868-4908-8348-80ad0eb35b00 -ResourceId 20402e93-fb1d-4bd9-8a51-b809fbb946fd

    .EXAMPLE
    Request-vRAConsumerResourceAction -Id 6a301f8c-d868-4908-8348-80ad0eb35b00 -ResourceName vm01

    .EXAMPLE
    Get-vRAConsumerResource -Name vm01 | Request-vRAConsumerResourceAction -Id 6a301f8c-d868-4908-8348-80ad0eb35b00
    

#>
[CmdletBinding(DefaultParameterSetName="Standard")]

    Param (

    [parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [alias("ResourceActionId")]
    [String]$Id,
   
    [parameter(Mandatory=$true, ValueFromPipelineByPropertyName, ParameterSetName="Standard")]
    [ValidateNotNullOrEmpty()]
    [String[]]$ResourceId,         

    [parameter(Mandatory=$true, ParameterSetName="ByName")]
    [ValidateNotNullOrEmpty()]
    [String[]]$ResourceName       

    )
                
 try {

        if ($PSBoundParameters.ContainsKey("ResourceName")) {
               
            # --- Get resource by name

            foreach ($Name in $ResourceName) {

                Write-verbose -Message "Retrieving Id for resource $($Name)"
                
                $Resource = Get-vRAConsumerResource -Name $Name

                # --- Build a list of resource ids
                $ResourceId += $Resource.ResourceId
                                
            }

        }

        foreach ($Item in $ResourceId) {

            # --- Try to retrieve the resource action for each resource
            $Action = Get-vRAConsumerResourceAction -Id $Id -ResourceId $Item

            Write-Verbose "Found resourceAction $($Action.Name) for resource $($Item)"                       

            # --- Get the request template

            Write-Verbose -Message "Retrieving request template"

            $URI = "/catalog-service/api/consumer/resources/$($Item)/actions/$($Action.id)/requests/template"

            Write-Verbose -Message "Preparing GET to $($URI)"
       
            $Template = Invoke-vRARestMethod -Method GET -URI $URI

            Write-Verbose "SUCCESS"

            # --- Execute the request     
        
            if ($PSCmdlet.ShouldProcess($Item)){
                
                # --- Build the URI string for the service         
            
                $URI = "/catalog-service/api/consumer/resources/$($Item)/actions/$($Action.id)/requests"
                
                Write-Verbose -Message "Preparing POST to $($URI)"                
           
                $Response = Invoke-vRARestMethod -Method POST -URI $URI -Body ($Template | ConvertTo-Json -Depth 10 -Compress)

                Write-Verbose "SUCCESS"
                     
            }

        }

    }
    catch [Exception]{

        throw
    }

}