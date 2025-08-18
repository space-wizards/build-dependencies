#!/usr/bin/env pwsh

Set-Location (Split-Path ($MyInvocation.MyCommand.Path))

Remove-Item Packages/*/bin -Recurse

New-Item -Force -ItemType "directory" packages_build

Get-ChildItem -Recurse Packages/*.nupkg | Remove-Item
Get-ChildItem -Directory Packages | ForEach-Object -Parallel { dotnet pack "$_/$($_.Name).csproj" }
Get-ChildItem -Recurse Packages/*.nupkg | Copy-Item -Destination packages_build 
