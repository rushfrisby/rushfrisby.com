
I am little old school in that I’ve used Winamp since the 90’s. At the beginning of last year it was bought by Radionomy from AOL. I thought that meant they would finally update it, but it’s been over a year and I haven’t heard any news of this ever happening. I decided to switch to AIMP as my audio player instead. It looks a lot like Winamp but the it’s much more usable.

Anyways, back in the day when I used to use AIM (I still use AIM but on Pidgin now, occasionally) there was a Winamp plugin that would update your AIM profile with what you were listening to in Winamp. There are more modern plugins that do basically the same thing but post to Twitter instead.

I use Lync at work. I thought it would be neat to create something that would update Lync’s “Personal Note” with what I am listening to in AIMP. Lync, for some reason doesn’t allow plugins, I read that somewhere so I gave up quickly. That’s when I looked into how to create AIMP plugins… again, didn’t find much. AIMP was developed by some Russians and it’s in C which I don’t know well enough to be writing plugins in. So what I did was create my own app. It starts when I log into Windows and runs in the background. It takes about 2MB of memory and 0% CPU. All it does is monitor if a file has changed and then calls the Lync API to update my note. Monitor a file? Yes… there is a plugin you need to install in AIMP called “Current Track info to file v3.1”. It writes the currently playing track info to a file.

<iframe allowfullscreen="" frameborder="0" height="480" src="https://www.youtube.com/embed/QxPrYwtFej4?rel=0" width="640"></iframe>

Here is what you need to do in order to get this working on your Windows machine.

1. Install [AIMP 3](http://www.aimp.ru/) if you haven’t already.
2. Install the “[Current Track info to file v3.1](http://www.aimp.ru/index.php?do=catalog&rec_id=358)” plugin for AIMP
3. In the Current track info plugin settings… the path should be to your user account’s “My Documents” folder and the file name be called “CurrentTrackInfo.txt” (ex. *C:\Users\rfrisby\Documents\CurrentTrackInfo.txt*)
4. For the plugin’s template use this: %IF(%R,%R - %T,%Replace(%F,.mp3,))
5. The setting for “Remember list of, files” should be **1**. None of the other options should be checked.
6. Download the [LyncAimpUpdater](http://rushfrisby.com/wp-content/uploads/2015/05/LyncAimpUpdater.zip) zip file and extract it to your hard drive
7. In Windows Explorer go to the startup folder for your user account. (ex. *C:\Users\rfrisby\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup*) In this folder right click and choose New > Shortcut.
8. Where it says “Type the location of this item” paste this line: C:\Windows\System32\cmd.exe /c start /min C:\Apps\LyncAimpUpdater\LyncAimpUpdater.exe ^& exit

 Then change the path to LyncAimpUpdater.exe so that it points to where you extracted the zip on your hard drive.

That’s it. You can open that shortcut to run the app right away but if not it will start the next time you log into your computer.

.NET 4.5 is required to run the app.

[sdm_download id=”4461″ fancy=”0″]

**UPDATE:**  
 This also works for “Skype for Business”.


