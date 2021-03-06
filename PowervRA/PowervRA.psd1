#
# Module manifest for module 'PowervRA'
#
# Generated by: Jakku Labs
#
# Generated on: 03/02/2016
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '1.2.2'

# ID used to uniquely identify this module
GUID = 'bbe31f5e-6a10-4859-8b71-2aaef94a8be5'

# Author of this module
Author = 'Jakku Labs'

# Company or vendor of this module
CompanyName = 'Jakku Labs'

# Copyright statement for this module
Copyright = '(c) 2016 Jakku Labs. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell Module for Managing VMware vRealize Automation'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '4.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = 'Functions\Add-vRAPrincipalToTenantRole.psm1',
				'Functions\Add-vRAReservationNetwork.psm1',
				'Functions\Add-vRAReservationStorage.psm1',
				'Functions\Connect-vRAServer.psm1',
				'Functions\Disconnect-vRAServer.psm1',
				'Functions\Export-vRAContentPackage.psm1',
				'Functions\Get-vRAApplianceServiceStatus.psm1',
				'Functions\Get-vRAAuthorizationRole.psm1',
				'Functions\Get-vRABlueprint.psm1',
				'Functions\Get-vRABusinessGroup.psm1',
				'Functions\Get-vRACatalogItem.psm1',
				'Functions\Get-vRACatalogPrincipal.psm1',
				'Functions\Get-vRAConsumerCatalogItem.psm1',
				'Functions\Get-vRAConsumerCatalogItemRequestTemplate.psm1',
				'Functions\Get-vRAConsumerEntitledCatalogItem.psm1',
				'Functions\Get-vRAConsumerRequest.psm1',
				'Functions\Get-vRAConsumerResource.psm1',
				'Functions\Get-vRAConsumerResourceOperation.psm1',
				'Functions\Get-vRAConsumerResourceType.psm1',
				'Functions\Get-vRAConsumerService.psm1',
				'Functions\Get-vRAContentPackage.psm1',
				'Functions\Get-vRAEntitledCatalogItem.psm1',
				'Functions\Get-vRAEntitlement.psm1',
				'Functions\Get-vRAGroupPrincipal.psm1',
				'Functions\Get-vRAReservation.psm1',
				'Functions\Get-vRAReservationComputeResource.psm1',
				'Functions\Get-vRAReservationComputeResourceMemory.psm1',
				'Functions\Get-vRAReservationComputeResourceNetwork.psm1',
				'Functions\Get-vRAReservationComputeResourceResourcePool.psm1',
				'Functions\Get-vRAReservationComputeResourceStorage.psm1',
				'Functions\Get-vRAReservationPolicy.psm1',
				'Functions\Get-vRAReservationTemplate.psm1',
				'Functions\Get-vRAReservationType.psm1',
				'Functions\Get-vRAResourceMetric.psm1',				
				'Functions\Get-vRAResourceOperation.psm1',
				'Functions\Get-vRAResourceType.psm1',
				'Functions\Get-vRAService.psm1',
				'Functions\Get-vRAServiceBlueprint.psm1',
				'Functions\Get-vRAStorageReservationPolicy.psm1',
				'Functions\Get-vRATenant.psm1',
				'Functions\Get-vRATenantDirectory.psm1',
				'Functions\Get-vRATenantDirectoryStatus.psm1',
				'Functions\Get-vRATenantRole.psm1',
				'Functions\Get-vRAUserPrincipal.psm1',
				'Functions\Get-vRAVersion.psm1',
				'Functions\Invoke-vRARestMethod.psm1',
				'Functions\New-vRABusinessGroup.psm1',
				'Functions\New-vRAContentPackage.psm1',
				'Functions\New-vRAEntitlement.psm1',
				'Functions\New-vRAGroupPrincipal.psm1',				
				'Functions\New-vRAReservation.psm1',
				'Functions\New-vRAReservationNetworkDefinition.psm1',
				'Functions\New-vRAReservationPolicy.psm1',
				'Functions\New-vRAReservationStorageDefinition.psm1',
				'Functions\New-vRAService.psm1',
				'Functions\New-vRAStorageReservationPolicy.psm1',
				'Functions\New-vRATenant.psm1',
				'Functions\New-vRATenantDirectory.psm1',
				'Functions\New-vRAUserPrincipal.psm1',
				'Functions\Remove-vRABusinessGroup.psm1',
				'Functions\Remove-vRAContentPackage.psm1',
				'Functions\Remove-vRAGroupPrincipal.psm1',				
				'Functions\Remove-vRAPrincipalFromTenantRole.psm1',
				'Functions\Remove-vRAReservation.psm1',
				'Functions\Remove-vRAReservationPolicy.psm1',
				'Functions\Remove-vRAService.psm1',
				'Functions\Remove-vRAStorageReservationPolicy.psm1',
				'Functions\Remove-vRATenant.psm1',
				'Functions\Remove-vRATenantDirectory.psm1',
				'Functions\Remove-vRAUserPrincipal.psm1',
				'Functions\Request-vRAConsumerCatalogItem.psm1',
				'Functions\Set-vRABusinessGroup.psm1',
				'Functions\Set-vRACatalogItem.psm1',
				'Functions\Set-vRAEntitlement.psm1',			
				'Functions\Set-vRAReservation.psm1',
				'Functions\Set-vRAReservationNetwork.psm1',
				'Functions\Set-vRAReservationPolicy.psm1',
				'Functions\Set-vRAReservationStorage.psm1',
				'Functions\Set-vRAService.psm1',
				'Functions\Set-vRAStorageReservationPolicy.psm1',
				'Functions\Set-vRATenant.psm1',
				'Functions\Set-vRATenantDirectory.psm1',
				'Functions\Set-vRAUserPrincipal.psm1'			

# Functions to export from this module
FunctionsToExport = 'Add-vRAPrincipalToTenantRole','Add-vRAReservationNetwork','Add-vRAReservationStorage','Connect-vRAServer','Disconnect-vRAServer','Export-vRAContentPackage','Get-vRAApplianceServiceStatus','Get-vRAAuthorizationRole','Get-vRABlueprint','Get-vRABusinessGroup','Get-vRACatalogItem','Get-vRACatalogPrincipal','Get-vRAConsumerCatalogItem','Get-vRAConsumerCatalogItemRequestTemplate','Get-vRAConsumerEntitledCatalogItem','Get-vRAConsumerRequest','Get-vRAConsumerResource','Get-vRAConsumerResourceOperation','Get-vRAConsumerResourceType','Get-vRAConsumerService','Get-vRAContentPackage','Get-vRAEntitledCatalogItem','Get-vRAEntitlement','New-vRAGroupPrincipal','Get-vRAGroupPrincipal','Get-vRAReservation','Get-vRAReservationComputeResource','Get-vRAReservationComputeResourceMemory','Get-vRAReservationComputeResourceNetwork','Get-vRAReservationComputeResourceResourcePool','Get-vRAReservationComputeResourceStorage','Get-vRAReservationPolicy','Get-vRAReservationTemplate','Get-vRAReservationType', 'Get-vRAResourceMetric', 'Get-vRAResourceOperation','Get-vRAResourceType','Get-vRAService','Get-vRAServiceBlueprint','Get-vRAStorageReservationPolicy','Get-vRATenant','Get-vRATenantDirectory','Get-vRATenantDirectoryStatus','Get-vRATenantRole','Get-vRAUserPrincipal','Get-vRAVersion','Invoke-vRARestMethod','New-vRABusinessGroup','New-vRAContentPackage','New-vRAEntitlement','New-vRAReservation','New-vRAReservationNetworkDefinition','New-vRAReservationPolicy','New-vRAReservationStorageDefinition','New-vRAService','New-vRAStorageReservationPolicy','New-vRATenant','New-vRATenantDirectory','New-vRAUserPrincipal','Remove-vRABusinessGroup','Remove-vRAContentPackage', 'Remove-vRAGroupPrincipal','Remove-vRAPrincipalFromTenantRole','Remove-vRAReservation','Remove-vRAReservationPolicy','Remove-vRAService','Remove-vRAStorageReservationPolicy','Remove-vRATenant','Remove-vRATenantDirectory','Remove-vRAUserPrincipal','Request-vRAConsumerCatalogItem','Set-vRABusinessGroup','Set-vRACatalogItem','Set-vRAEntitlement','Set-vRAReservation','Set-vRAReservationNetwork','Set-vRAReservationPolicy','Set-vRAReservationStorage','Set-vRAService','Set-vRAStorageReservationPolicy','Set-vRATenant','Set-vRATenantDirectory','Set-vRAUserPrincipal'

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

