Over the years I have developed an advanced TFS build process for automating some pretty complicated things. I would like to share with you what that build process looks like.

To start, I took the default TFS 2012 build process template and began to modify it. Today I used the same template in TFS 2015 (Update 3). These are the things I've added to it:

- Auto version assemblies
- Restore nuget packages
- Create auto versioned NuGet packages
- Run JavaScript unit tests
- Deploy database changes from a Database Project
- Allow using C# 6.0

####Assembly Versioning####

The first change made to the build process template is the BuildNumberFormat attribute. This was changed to:

```
$(BuildDefinitionName)_1.0.$(Year:yy)$(DayOfYear)$(Rev:.rr)
```
 
The major and minor numbers are *manually* incremented through the build definition. This will number should change corresponding to your application's life cycle and overall progress over time, which cannot be automatically determined by TFS.

The release and revision numbers will be automatically set by the build server. The release number is the 2 digit year plus the number representing the day of the year. This will keep the number under 65,335 which is the highest possible node value. The revision number starts at 1 and increases by 1 per build definition for every build throughout the day.
 
The next changes depend on modifications made to project files and *AssemblyInfo.cs* files within your solution. First, comment out the `AssemblyVersion` and `AssemblyFileVersion` lines from each *AssemblyInfo.cs* file in your projects.

```
//[assembly: AssemblyVersion("1.0.0.0")]
//[assembly: AssemblyFileVersion("1.0.0.0")]
```
 
These lines are dynamically added to the AssemblyInfo.cs file before the build server compiles each project you configure. To configure a project, unload it in VS by right clicking on the project name and choosing *Unload Project* in the context menu. Then right click on the project name again and select *Edit <project name>…*.  At the end, just before the </Project> element, insert this XML:

``` 
<UsingTask TaskName="Microsoft.TeamFoundation.Build.Tasks.GetBuildProperties" AssemblyFile="$(MSBuildProgramFiles32)\Microsoft Visual Studio 12.0\Common7\IDE\PrivateAssemblies\Microsoft.TeamFoundation.Build.ProcessComponents.dll" Condition="' $(BuildUri) '!='  '" />
 <Target Name="BeforeBuild" Condition="' $(BuildUri) '!='  '">
   <GetBuildProperties TeamFoundationServerUrl="$(TeamFoundationServerUrl)" BuildUri="$(BuildUri)">
     <Output TaskParameter="BuildNumber" PropertyName="BuildNumber" />
   </GetBuildProperties>
   <PropertyGroup>
     <BuildNumberSplitLocation>$([MSBuild]::Add($(BuildNumber.LastIndexOf('_')),1))</BuildNumberSplitLocation>
   </PropertyGroup>
   <ItemGroup>
     <AssemblyVersionLines Include="%0D%0A[assembly:AssemblyFileVersion(&quot;$(BuildNumber.Substring($(BuildNumberSplitLocation)))&quot;)]%0D%0A[assembly: AssemblyVersion(&quot;$(BuildNumber.Substring($(BuildNumberSplitLocation)))&quot;)]%0D%0A" />
   </ItemGroup>
   <Exec Command="attrib -r &quot;$(ProjectDir)\Properties\AssemblyInfo.cs&quot;" ContinueOnError="false" />
   <Message Text="Lines being added: @(AssemblyVersionLines)" Importance="high" />
   <WriteLinesToFile File="$(ProjectDir)\Properties\AssemblyInfo.cs" Lines="@(AssemblyVersionLines)" />
 </Target>
```
 
When your projects build locally the version number will default to 0.0.0.0 but when the build server builds your projects they will be in the form 3.5.15071.2 (The second build of version 3.5 on March 12th, 2015).

####NuGet Restore####
...
 
####Creating NuGet Packages####

######NuGet Server / Repository######
A web application was created which implements the NuGet Server (a NuGet package). It has been deployed to http://pinto.sctflash.local:637. There is a Packages folder within this web application that holds all of the packages. This is the drop location when a package is created by the build server. The UNC path for this is
\\pinto.sctflash.local\d$\Websites\NuGetServer\Packages. There is a custom app running on the build server that cleans up “old” nugget packages. It will put the old packages in the OldPackages folder. The reason for this is that Nuget Server reads ever package in the Packages folder when the website starts up and if there are a lot of packages in there it will take a long time. Moving older versioned packages out of the folder speeds up startup time.
Creating Packages from the Build Process
Within the build process template we have defined a variable called NugetScriptPath.  This variable points to D:\Builds\nuget\create_nuget_packages.ps1 on pinto.sctflash.local. The script will take in variables for the project path, bin path, and version number. Then it finds all *.nuspec files in a project and runs each through Nuget.exe (which is in the same folder as the script) and creates a NuGet package. It excludes packages in the “packages” folder because those are packages you’ve included in your project - you don’t need to author those. The package is output to the NuGet Server’s drop location.  The version number from the build is used as the package’s version number. The build process template was modified so that the script is run for every project in the solution. A symbols package accompanies each nuget package for debugging.
Creating a Nuspec File
For ease of locating nuspec files the best place to put them is at the solution root but putting them several subfolders deep is okay. The nuspec file will package DLLs, related resources, references, and config transforms so that other projects can reference them. For more information on creating nuspec files see http://docs.nuget.org/docs/reference/nuspec-reference. Below is an example for the Derive.Shared package. Remember that the version number will be set by the build server.

```
<?xml version="1.0"?>
<package xmlns="http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd">
  <metadata>
    <id>My Package Name</id>
    <version>0.0.0.0</version>
    <authors>Your Name</authors>
    <owners>You or your Company's Name</owners>
    <licenseUrl>https://website.com/license.txt</licenseUrl>
    <projectUrl>https://website.com/mypackageurl</projectUrl>
    <iconUrl>https://website.com/icons/mypackage.png</iconUrl>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <description>A description of your package goes here.</description>
    <releaseNotes>Release notes go here.</releaseNotes>
    <language>en-US</language>
    <tags>space separated tags go here</tags>
  </metadata>
  <files>
    <file src="MyPackage.dll" target="lib\Net45" />
  </files>
</package>
```
 
To verify that your packages were built you can look in the build log:

NuGet Repository
To add our NuGet repository in Vusual Studio (you need to have NuGet extension installed infirst) go to Tools > Library Package Manager > Package Manager Settings. Click on the Package Sources node then on the “+” button. Change the Name field to “Derive Packages” or another name that your prefer. Change the Source field to http://pinto.sctflash.local:637/nuget. Click the Update button. Now when you open up NuGet to include packages in your solution you will see a menu item for the feed you just added and all of our packages.

Run JavaScript Unit Tests
For JavaScript unit testing in Visual Studio there is an open source test runner called Chutzpah that can also be integrated with TFS. It runs tests from QUnit, Jasmine, and Mocha frameworks. Just like Unit Test projects you can get results for tests in the build summary.
 
To include javascript tests to be run on the server name your javascript file *test*.js. You’ll have to reference the script framework you are targeting and any needed references at the top of the test file. For examples using each framework look at the sample project under $/Sandbox/Rush/JavascriptUnitTests

Here is the sample project test results showing up in a build summary:

Database Deployments
To deploy a database project first create a publish profile for it. Right click on the project and select Publish. Enter your server information in the Target Database section.
 
Next click the Save Profile As button and save the file somewhere in your solution. Make sure you name the file something that is appropriate for the environment it is being deployed to. You can then click cancel since you don’t want to publish the database right now. View the properties for the saved file and change the Copy to Output Directory value to Copy if newer. Check that file in with your project.
Next, open up your build definition and go to the Process tab. Under the Misc section there is a setting called SqlPackageParams. Edit that value so that it reads as follows:
 
```
/Action:Publish /SourceFile:ProjectName.dacpac /Profile:PublishProfile.xml
```
 
Change ProjectName.dacpac to reflect your database project’s name + ".dacpac" file extension. Update PublishProfile.xml to the name of the publish profile file you just created.
The next time a build is perform you will see that database changes get deploy as part of the build process:

Build Definitions
In order to use this functionality you need to have your build definition use Rush’s Ultimate Build Process template located under $/Library/BuildProcessTemplates. You can change this on the Process tab when editing your definition.

When you have made significant progress in your solution you can manually update the version number in your build definition – the “1.0” part of the Build Number Format.