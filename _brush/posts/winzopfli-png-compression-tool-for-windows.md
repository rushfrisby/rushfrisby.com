
Zopfli is a compression algorithm developed by Google. At the moment it produces the smallest possible output on files that can be decompressed using the DEFLATE algorithm. PNG files use DEFLATE so they can be compressed using Zopfli. The one downside is that the algorithm is pretty slow. Here is a [good article with more details](http://blog.codinghorror.com/zopfli-optimization-literally-free-bandwidth/).

I created WinZopfli as a GUI tool for compressing multiple PNG files at once.

[sdm_download id=”4321″ fancy=”0″] * Requires [Microsoft .NET Framework 4.6.1](https://www.microsoft.com/en-us/download/details.aspx?id=49981)

Screenshot:  
![WinZopfli - PNG Compression](/img/post/2016-01-04-13_59_17-WinZopfli-PNG-Compression.png)

**Note:** The tool will create a thread for each logical processor on your system. This will lag your system until it’s done processing PNGs. If you want to change this behavior open the WinZopfli.exe.config file in a text editor and change the value for *NumberOfThreads*. Changing the value to 0 will revert back to the default behavior.


