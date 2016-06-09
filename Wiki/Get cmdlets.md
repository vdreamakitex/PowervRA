# Get Cmdlets

## Help
* Each function must contain descriptive help text.
* There must be enough information to help the end user use your cmdlet but not too much
* Help text must appear after the function declaration. E.g. 'function Get-Something {'
* Help text should contain the following sections:
    * SYNOPSIS
    * DESCRIPTION
    * PARAMETER (For each input parameter that your cmdlet takes)
    * INPUTS
    * OUTPUTS
    * EXAMPLE

### Example

```
<#
    .SYNOPSIS
    Get a catalog item that the user is allowed to review.
    
    .DESCRIPTION
    API for catalog items that a system administrator can interact with. It allows the user to interact 
    with catalog items that the user is permitted to review, even if they were not published or entitled to them.

    .PARAMETER Id
    The id of the catalog item
    
    .PARAMETER Name
    The name of the catalog item

    .PARAMETER Limit
    The number of entries returned per page from the API. This has a default value of 100.

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-vRACatalogItem
    
    .EXAMPLE
    Get-vRACatalogItem -Limit 9999

    .EXAMPLE
    Get-vRACatalogItem -Id dab4e578-57c5-4a30-b3b7-2a5cefa52e9e

    .EXAMPLE
    Get-vRACatalogItem -Name Centos_Template
#>
```
#Cmdlet bindings

#Output type
* Get cmdlets should always return a value. You must describle the output type with **[OutputType()]**

[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.Management.Automation.PSObject')]

#Parameters
* Input parameters should be described within a **Param ()** block
* Cmdlets shold be able to process values handed via the pipeline and arrays

```
# --- Array as parameter input
Get-Something -Id 1,2,3

# --- Array as pipeline input
$Array | Get-Something
```
* Use ParameterSets to segment your parameters. 
* A parameter can be part of one or more parameter sets. A parameterset can be initialised with the ParameterSetName property
* You may also want to set a DefaultParameterSet

```
[Parameter(Mandatory=$false, ParameterSetName="ByName")]
```

* Validate your parameters

```
[Parameter(Mandatory=$true,ParameterSetName="ById", ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
[ValidateNotNullOrEmpty()]
[String[]]$Id,

[Parameter(Mandatory=$false, ParameterSetName="ByName")]
[ValidateNotNullOrEmpty()]
[String[]]$Name,

[Parameter(Mandatory=$false, ParameterSetName="ById")]
[Parameter(Mandatory=$true, ParameterSetName="ByName")]
[ValidateNotNullOrEmpty()]
[String]$Property
```
#Code

## Pipeline support
* To support pipeline processing your code should be wrapped between **begin {}** , **process {}** and **end {}** blocks
* The parameters that you want to accept input from the pipeline should also be tagged with the appropriate properties
    * ValueFromPipeline
    * ValueFromPipelineByPropertyName
* Pipeline support for a parameter must be enabled in each ParameterSet that it is a member of

```
being {

    # --- Code here is executed once at the beginning of the execution
}

process {

    # --- Code here is executed for each item sent via the pipeline

}

end {

    # --- Code here is executed once at the end of the execution

}
```

* To support an array as an input parameter use a foreach loop within the process block

```
process {

    foreach($CustomerId in $Id){

        # --- Do something here

    }

}
```

## Error handling
* Always try to gracefully handle errors
* Use try catch blocks to deal with errors. For example, the snippet above becomes:

```
process {

    try {

        foreach($CustomerId in $Id){

            # --- Do something here

        }

    }
    catch [Exception] {

        throw "An error occured: $_.Exception.Message"

    }

}
```

## Logging
* Do not use Write-Host or Write-Output to output cmdlet activity to the console
* The prefered method of logging is to use Write-Verbose as this can be optionally enabled

```
Write-Verbose -Message "Something is happening"
```

## Aliases
* Always use fully qualified cmdlet names instead of aliases

```
# --- Do this
Get-Location

# --- Not this
gl
```

## Output

* The cmdlet output should match the type specified in **[OutputType()]**

* When returning System.Management.Automation.PSObject we tend to staticly define the type, 
mapping properties from the response payload to those in the object

```
[PSCustomObject] @{

    $Id = $Response.id
    $Name = $Response.name
    $Property = $Response.property

}
```
* Building on the above examples, if out cmdlet returns a PSCustomObject it should look something like this:

```
process {

    try {

        foreach($CustomerId in $Id){

            # --- Do something here
            $Response = Invoke-vRARestMethod -Method GET -URI $URI

            # --- Return
            [PSCustomObject] @{

                $Id = $Response.id
                $Name = $Response.name
                $Property = $Response.property

            }            

        }

    }
    catch [Exception] {

        throw "An error occured: $_.Exception.Message"

    }

}
```