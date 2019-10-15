
I’ve been working on a project that saves and reads blobs from Azure. I created a unit test for this functionality. Instead of making calls to Azure proper, I am running the Azure Storage Emulator so that I don’t incur any cost. “It works on my machine!” …but when I check my code into TFS and do a build on the server, the unit test fails because the Storage Emulator is not running. If I remote desktop into the server and start the Storage Emulator then the unit test passes. Starting the emulator manually is a problem because if the server reboots then I have to remember to start that up again and I won’t know about it until the test fails. Other developers might not know to do this either.

To combat this problem I tried starting the emulator with a scheduled task that runs when the server starts. This did not work. I’m not sure why but it just didn’t. Task Scheduler says the task is running but I don’t see it in Task Manager and my unit test fails. I can only assume that the Task Manager status is wrong and *something* that it doesn’t know about isn’t working. It would be nice if Microsoft created the emulator so that it runs as a Windows Service instead.

I Googled for a solution and came up empty except for one article that mentioned starting the emulator from within code. In order to detect if the emulator is running or not, first you need to access a storage container. If you get a StorageException then the emulator isn’t running and you know to start it. This seems like a hacky solution but I tried it and it works. Here is what I ended up with:

<script src="https://gist.github.com/rushfrisby/43344de7882b53ae0d77.js"></script>

The first line of that method checks a config setting that will let me turn the hack on/off. You won’t need it when you move to production because Azure is always on.

One thing to note is that your build controller must be using a user account and not a built-in account. This is because the storage emulator stores it’s settings in the user’s directory. I created a local administrator account on my build server to run the build controller as.


