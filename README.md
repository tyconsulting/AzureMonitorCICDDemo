# Demo - Deploying Azure Monitor Alert Rules Using Azure Pipeline

## Speakers

| Name | Twitter Handler | Comment
|:--- | :--- | :---
|**Alexandre Verkinderen**|[@AlexVerkinderen](https://twitter.com/alexverkinderen)| Microsoft MVP: Azure |
|**Tao Yang**|[@MrTaoYang](https://twitter.com/mrtaoyang)| Microsoft MVP: Azure |

## Introduction

This repository contains demo for the Tao Yang and Alex Verkinderen's presentation titled "Azure Monitor - Design and Implement a Monitoring Solution for Your Azure Environment using ARM Templates and CI/CD Pipelines." This session is presented at the following conferences:

| Date | Name | Location
|:--- | :--- | :---:
| 13th-14th Feb 2020 | Microsoft Ignite The Tour | Sydney |
| 23rd July 2020 | Inside Azure Management The Virtual Summit | Online |

## ARM Templates

The project contains 2 ARM templates:

1. Management Group Monitoring
2. Workload (Application) monitoring

## Management Subscription Monitoring Template

The following resources are deployed by the ARM template:

| Type | Name | Target
|:--- | :--- | :---
|Resource Group | rg-mgmt-monitoring  |Management Subscription
|Service Health Alert | ServiceHealthActivityLogAlert | rg-mgmt-monitoring

### Alert Rules

| No. | Name | Description | Type | Condition | Frequency | Severity | Action Groups | Dependencies
|:---: |:--- | :---: | :--- | :--- | :---: | :---: | :--- | :---
01 | Service Health Alert | Alert for Azure Service Health | Native: Activity Log Service Health | n/a | n/a | n/a|action-group-servicehealth | n/a
02 | Express Route Alert | Alert for express routes | Log Analytics Search Query | Query ```NetworkMonitoring | where (SubType == "ExpressRouteCircuitUtilization") and (UtilizationHealthState == "Unhealthy")``` result greater than 0| 5 minutes| 0|action-group-networkalerts | Network Performance Monitor (NPM) must be setup on On-Prem servers
03 | Security Alert | Security Center alerts | Log Analytics Search Query | Query ```SecurityAlert``` result greater than 0 | 5 minutes | 0 | action-group-securityalerts | For each subscription, Azure Security Center (ASC) must be configured and Log Analytics workspace is configured to collect Azure Activity logs
04 | Missing Update Alert | Azure VMs with missing update and has not been updated for over 7 days | Log Analytics Search Query | Query ```UpdateSummary | where TotalUpdatesMissing >0 and OldestMissingSecurityUpdateInDays >=7 and ComputerEnvironment == 'Azure'``` result greater than 0 | 5 minutes | 0 | action-group-securityalerts | VMs must have the Microsoft Monitoring Agent installed and point to the correct Log Analytics workspace, and Update Management must be configured in the Automation account linked to the Log Analytics workspace.

## References

* [Azure DevOps Yaml Pipeline Schema](https://docs.microsoft.com/en-us/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema)
* [ARM Toolkit (arm-ttk) module](https://github.com/Azure/arm-ttk)
* [PSScriptAnalyzer module](https://www.powershellgallery.com/packages/PSScriptAnalyzer/)
* [PSPesterTest module](https://www.powershellgallery.com/packages/PSPesterTest)
* [GitHub Super Linter](https://github.com/github/super-linter)
* Azure DevOps Security Code Analysis Extension
  * [Introduction](https://github.com/starkfell/100DaysOfIaC/blob/master/articles/day.77.azdo.security.code.analysis.extension.md)
  * [Official Site](https://secdevtools.azurewebsites.net/)
* [Azure Repos Branch Policy](https://docs.microsoft.com/en-us/azure/devops/repos/git/branch-policies?view=azure-devops)
* [Azure Monitor Alert blog series by MVP Stanislav Zhelyazkov](https://cloudadministrator.net/tag/azure-monitor-alert-series/)
* [Use GitHub Super Linter in Azure Pipelines](https://blog.tyang.org/2020/06/27/use-github-super-linter-in-azure-pipelines/)
* [Tao's blog](https://blog.tyang.org)
* [Alex's blog](https://mscloud.be/)
