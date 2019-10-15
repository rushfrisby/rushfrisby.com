
When I created this blog I built in a method that would catch every “Page Not Found” (404) error and track the number of times it was requested. This is great because I can now see requests to pages that don’t exist any more and redirect them to a page that may be related to what the person was looking for.

A few days ago I noticed about 10 requests for .zip and .rar files. The files sought after were named things like wwwroot.zip, rushfrisby.com.rar, etc. Sometimes website owners will make a backup of their website as a .zip or .rar archive – and – sometimes they do it in the web site’s root directory (the IIS default folder is called wwwroot by the way). So the requests for these files came from someone who is checking if I have backed up my website in this manner and was lazy enough to leave it there.

That’s interesting I thought to myself… So I devised an app to do the same thing. I wanted to see what kind of success rate hackers were having and what kind of ill managed websites are out there. Is this a social pattern that is happening frequently and needs to be brought to the public’s attention? I think so, let’s see what we can find.

My app does two things. First I gave it a starting URL. I picked on a blogger who’s website I read regularly. I scanned his website picking out all of the links. Then I crawled all of those links and picked out the links from each of them… and so on. Essentially it’s a web crawler. All I am looking to get here are the domain names from those links.

The second thing my app does is create a list of potential file names based on a domain name (eg: wwwroot.zip, rushfrisby.com.rar, etc.) Then I make a request for each file. If I get an OK (200) response back and the Content-Type header matches an archive then we’ve got something. I purposely did not download all of the OK files because that would be morally wrong and I am doing this for research only.

At present time I’ve found almost 300,000 domain names, inspected about 15,000 of them for files, and found 20 files. I did download a few of them to confirm my suspicion and what I discovered is just what I thought.

When you backup a website, it probably includes configuration files which are normally not accessible over the web, but are used by a web server so that it knows what to do. Configuration files can include private information such as SMTP credentials, database names and credentials, API credentials, service locations, etc. This is stuff no one should ever know.

I found a few files that had configuration settings in their backups – with all of the sensitive information in plain text!

To some sites credit they weren’t all bad. For example one was a software company who’s software was distributed as a file name that matched their domain name.

There are a few things you can do to protect yourself from this social reverse engineering disaster. First, **do not backup your website and leave the backup in the root folder**. Second, **do not store credentials in your configuration files in plain text**! Many web servers allow you to encrypt sections of your config files so that they cannot be read by the human eye. For example this is a [guide on how to encrypt ASP.NET Web.config files](http://msdn.microsoft.com/en-us/library/zhhddkxy(v=vs.100).aspx).

My last point is, why are people even making backups in the first place? Real software developers are using source control and branching when they make releases. Builds are compiled from the branch/source code and deployed from a package. If you need to restore a “backup” you can recompile the branch and deploy it. I realize not everyone knows how or has the capability to do this so until then we need to inform developers and ITadministratorsof this problem.


