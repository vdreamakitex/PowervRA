function Get-vRAConsumerResourceAction {
<#
    .SYNOPSIS
    Retrieve available resourceActions for a resource
    
    .DESCRIPTION
    A resourceAction is a specific type of ResourceOperation that is performed by submitting a request. 
    Unlike ResourceExtensions, resource actions can be invoked via the Service Catalog service and subject to approvals.

    .PARAMETER Id
    The id of the resource action

    .PARAMETER Name
    The name of the resource action

    .PARAMETER BindingId
    The bindingId of the resource action

    .PARAMETER ResourceId
    The id of the catalog resource
    
    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject.

    .EXAMPLE
    Get-vRAConsumerResource -Name vm01 | Get-vRAConsumerResourceAction 
    
    .EXAMPLE
    Get-vRAConsumerResource -Name vm01 | Get-vRAConsumerResourceAction -Id "a4d57b16-9706-471b-9960-d0855fe544bb"

    .EXAMPLE
    Get-vRAConsumerResource -Name vm01 | Get-vRAConsumerResourceAction -Name "Reboot"

    .EXAMPLE
    Get-vRAConsumerResourceAction -ResourceId 20402e93-fb1d-4bd9-8a51-b809fbb946fd -BindingId "Infrastructure.Machine.Action.Reboot"

#>
[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.Management.Automation.PSObject')]

    Param (

    [parameter(Mandatory=$false,ParameterSetName="ById")]
    [ValidateNotNullOrEmpty()]
    [String[]]$Id,

    [parameter(Mandatory=$false,ParameterSetName="ByName")]
    [ValidateNotNullOrEmpty()]
    [String[]]$Name,

    [parameter(Mandatory=$false,ParameterSetName="ByBindingId")]
    [ValidateNotNullOrEmpty()]
    [String[]]$BindingId,

    [parameter(Mandatory=$true,ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [String]$ResourceId

    )
                
    try {

        if ($PSBoundParameters.ContainsKey("ResourceName")){

            Write-verbose -Message "Retrieving Id for resource $($Name)"
                
            $Resource = Get-vRAConsumerResource -Name $Name

            # --- Build a list of resource ids
            $ResourceId += $Resource.ResourceId

        }

        # --- Set the uri
        $URI = "/catalog-service/api/consumer/resources/$($ResourceId)/actions"

        switch ($PsCmdlet.ParameterSetName) {

            'ById' {

                foreach ($ResourceActionId in $Id) {

                    # --- Get available resource actions and filter by id

                    Write-Verbose -Message "Preparing GET to $($URI)"                

                    $Response = Invoke-vRARestMethod -Method GET -URI $URI

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.content.Count -lt 1) {

                        throw "There are no resourceActions available for this resource"

                    }

                    $Action = $Response.content | Where-Object {$_.id -eq $ResourceActionId}

                    if (!$Action) {

                        throw "Could not find resource action with id $($ResourceActionId)"

                    }


                    [pscustomobject] @{

                        Name = $Action.name
                        Description = $Action.description
                        IconId = $Action.iconId
                        Type = $Action.type
                        Id = $Action.id
                        ExtensionId = $Action.extensionId
                        ProviderTypeId = $Action.providerTypeId
                        BindingId = $Action.bindingId
                        HasForm = $Action.hasForm
                        FormScale = $Action.formScale
                
                    }

                }


                break

            }

            'ByName' {

                foreach ($ResourceActionName in $Name) {

                    # --- Get available resource actions and filter by name

                    Write-Verbose -Message "Preparing GET to $($URI)"                

                    $Response = Invoke-vRARestMethod -Method GET -URI $URI

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.content.Count -lt 1) {

                        throw "There are no resourceActions available for this resource"

                    }

                    $Action = $Response.content | Where-Object {$_.name -eq $ResourceActionName}

                    if (!$Action) {

                        throw "Could not find resource action with name $($ResourceActionName)"

                    }

                    if ($Action.Count -gt 1) {


                        Write-Warning -Message "More than one resource action matching name $($ResourceActionName) has been returned"

                    }

                    [pscustomobject] @{

                        Name = $Action.name
                        Description = $Action.description
                        IconId = $Action.iconId
                        Type = $Action.type
                        Id = $Action.id
                        ExtensionId = $Action.extensionId
                        ProviderTypeId = $Action.providerTypeId
                        BindingId = $Action.bindingId
                        HasForm = $Action.hasForm
                        FormScale = $Action.formScale
                
                    }

                }

                break

            }

            'ByBindingId'{

                foreach ($ResourceActionBindingId in $BindingId) {
                                                 
                    # --- Get available resource actions and filter by bindingId

                    Write-Verbose -Message "Preparing GET to $($URI)"                

                    $Response = Invoke-vRARestMethod -Method GET -URI $URI

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.content.Count -lt 1) {

                        throw "There are no resourceActions available for this resource"

                    }

                    $Action = $Response.content | Where-Object {$_.bindingId -eq $ResourceActionBindingId}

                    if (!$Action) {

                        throw "Could not find resource action with bindingId $($ResourceActionBindingId)"

                    }

                    [pscustomobject] @{

                        Name = $Action.name
                        Description = $Action.description
                        IconId = $Action.iconId
                        Type = $Action.type
                        Id = $Action.id
                        ExtensionId = $Action.extensionId
                        ProviderTypeId = $Action.providerTypeId
                        BindingId = $Action.bindingId
                        HasForm = $Action.hasForm
                        FormScale = $Action.formScale
                
                    }

                }


                break

            }

            'Standard'{

                foreach ($Id in $ResourceId) {
             
                    # --- Get all available resource actions

                    Write-Verbose -Message "Preparing GET to $($URI)"                

                    $Response = Invoke-vRARestMethod -Method GET -URI $URI

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.content.Count -lt 1){

                        throw "There are no resourceActions available for this resource"

                    }

                    Write-Verbose -Message "Resource $($Id) has $($Response.content.Count) resourceAction(s) available"

                    foreach ($Action in $Response.content) {

                        [pscustomobject] @{

                            Name = $Action.name
                            Description = $Action.description
                            IconId = $Action.iconId
                            Type = $Action.type
                            Id = $Action.id
                            ExtensionId = $Action.extensionId
                            ProviderTypeId = $Action.providerTypeId
                            BindingId = $Action.bindingId
                            HasForm = $Action.hasForm
                            FormScale = $Action.formScale
                
                        }

                    }

                }




            }

        }

    }
    catch [Exception]{

        throw
    }

}