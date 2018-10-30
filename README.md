# HLS Central West Site Governance Sample

## Description

This sample solution shows how various aspects of SharePoint Online site creation can be controlled via [Site Designs][sitedesign-overview].

## Components

### Themes

SharePoint Themes allow you to customize the color palette to match your specifications. This is useful when you want a site to have your brand-specific palette. **Tip:** you can use the [theme generator tool][theme-generator] to create new color palattes for your custom themes.

The solution includes two sample themes:

* SmartterHealth Default - A light gray background with SmartterHealth blue accents.
* SmartterHealth Dark - A darker variant of the SmartterHealth Default theme.

### Site Scripts

SharePoint Site Scripts allow you to run "actions" on a site after it has been created. Useful commands include 

* Blocking External Sharing. 

> **Important:** SharePoint Online [controls for external sharing][spo-sharing] do not give you granular controls for controlling external sharing in SharePoint Online -- It's "all or none" for SharePoint sites. This site script capability enables you to make external sharing the exception, not the norm.

* Creating Custom Lists/Libraries.
* [Calling a Flow][flow-callflow].
* Applying a logo.

### Site Designs

## Installation

You can install everyting by running the *install.ps1* script in the project root, or you can install seperately by running *install.ps1* in the *themes*, *site-scripts*, or *site-designs* folders. For your convienince, each *install.ps1* has an accompanying *uninstall.ps1* script.

[SharePoint site design and site script overview][sitedesign-overview]

[Customize the Default Site Design][sitedesign-default]

[Scoping access to site designs][scoping]

[sitedesign-default]: https://docs.microsoft.com/en-us/sharepoint/dev/declarative-customization/customize-default-site-design
[sitedesign-overview]: https://docs.microsoft.com/en-us/sharepoint/dev/declarative-customization/site-design-overview
[scoping]: https://docs.microsoft.com/en-us/sharepoint/dev/declarative-customization/site-design-scoping
[flow-callflow]: https://docs.microsoft.com/en-us/sharepoint/dev/declarative-customization/site-design-trigger-flow-tutorial
[theme-generator]: https://developer.microsoft.com/en-us/fabric#/styles/themegenerator
[spo-sharing]: https://docs.microsoft.com/en-us/sharepoint/external-sharing-overview