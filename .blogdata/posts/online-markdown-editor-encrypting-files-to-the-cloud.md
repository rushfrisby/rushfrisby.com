
I use text editors a lot. I use them for taking notes, writing code, writing long emails before I send them out, and much more. For a long time I’ve used [Notepad++](http://notepad-plus-plus.org/) because it can handle all kinds of text-based files. Quite often the files I create in Notepad++ I also encrypt. I use a plugin called [SecurePad](http://sourceforge.net/projects/npp-plugins/files/SecurePad/) for this.

Lately I have been using [MarkdownPad](http://markdownpad.com/) to replace a lot of the things I do in Notepad++. [Markdown (the syntax)](http://daringfireball.net/projects/markdown/syntax) is great because it gives you guidelines on how your text should be formatted. It’s used all over the place: [reddit](https://www.reddit.com/), [github](https://github.com/), and [stackoverflow](http://stackoverflow.com/) to name a few. Because of the guidelines markdown provides it can be easily transformed into HTML and rendered in an eye-appealing fashion. MarkdownPad splits it’s window into 2 panes: the left pane is a text editor and the right pane is the HTML formatted view. MarkdownPad is very basic as is markdown in general – because it was intended to be simplistic and only used for basic formatting of text. MarkdownPad has no way of encrypting files.

So I got to thinking… Why is MarkdownPad a Windows application? It’s so basic that it could easily be browser based. It would also be nice if it encrypted files. In today’s landscape you can never be too careful when it comes to protecting your personal data, thoughts, and daily habits. I also thought, if you could make a browser based markdown editor where would you open and save files from? …the cloud!

After doing a quick search on Google I couldn’t find anything that remotely resembled the online tool I wanted, so I made it myself.

It’s called **[Secure Markdown](https://securemarkdown.azurewebsites.net/)** – *https://securemarkdown.azurewebsites.net*

![](/img/post/secure_markdown_screenshot.png)

It’s a work in progress but the basics are there:

- Text editor (left pane)
- Markdown syntax is shown in HTML format as you type (right pane)
- Files are read and written to Dropbox
- Files are encrypted (in the browser) before being saved to Dropbox

In the future I would like to add:

- Buttons for markdown-formatting text, like MarkdownPad.
- Option for saving unencrypted.
- Overwriting files (when you save a file with the same name as an existing file in dropbox now it appends a number to the file name)
- Seperate save / save as options.
- Option for viewing HTML source and downloading the HTML version.
- Option for saving HTML view as a PDF
- Move to own domain name if warranted

If you have any suggestions please leave a comment.


