
> **UPDATE 6/17/2015:** Added NiL.JS, updated to the latest version of ClearScript and Jint, fixed ClearScript “compiled” test, and updated results for all.

> **UPDATE 6/18/2015:**[Reran with more tests](/net-javascript-engine-performance-results)

In [RulePlex](https://ruleplex.com) users are allowed to write rules in JavaScript, make an API call which passes in data, and execute those rules in the cloud. RulePlex is written in .NET. So how do we execute JavaScript in .NET? It turns out there are a bunch of JavaScript engines that can do this, but which one is the fastest?

I took an inventory of the more popular .NET JavaScript engines:

- [jint](https://github.com/sebastienros/jint) – version 2.5.0.0
- [IronJS](https://github.com/fholm/IronJS) – version 0.2.0.1
- [JavaScript.Net](https://github.com/JavascriptNet/Javascript.Net) – version 0.7.1.0
- [Jurassic](http://jurassic.codeplex.com/) – version 2.1.0.0
- [ClearScript](http://clearscript.codeplex.com/) – version 5.4.2.0
- [NiL.JS](https://github.com/nilproject/NiL.JS) – version 1.4.740.0

My initial thoughts were that JavaScript.Net would be fast since it is just a wrapper for [Google’s V8 engine](https://code.google.com/p/v8/) which is the fastest JavaScript engine currently. I also thought IronJS would be fast since it uses Microsoft’s Dynamic Language Runtime. jint and Jurassic I was skeptical about.

### The Tests

I created a project and referenced each engine by using [NuGet](https://www.nuget.org/). I called each engine 5 times to execute a snippet of code and took the average. The snippet of code I executed came from a suite of array tests I found at [Dromaeo](http://dromaeo.com/). You can view the tests in [this gist](https://gist.github.com/rushfrisby/5491f25a82a979c5b15e).

I also did another test where I loaded the [linq.js library](http://linqjs.codeplex.com/) (one of my favorite, lesser known, JavaScript libraries) but I ran it 50 times.

### The Results

Array test results:

<table style="width:auto"><tr><td>jint</td><td>14,028 ms</td></tr><tr><td>IronJS</td><td>1,622 ms</td></tr><tr><td>JavaScript.Net</td><td>20 ms</td></tr><tr><td>Jurassic</td><td>237 ms</td></tr><tr><td>ClearScript</td><td>263 ms</td></tr><tr><td>ClearScript (compiled)</td><td>111 ms</td></tr><tr><td>NiL.JS</td><td>1,680 ms</td></tr></table>Linq.js load results:

<table style="width:auto"><tr><td>jint</td><td>17 ms</td></tr><tr><td>IronJS</td><td>176 ms</td></tr><tr><td>JavaScript.Net</td><td>13 ms</td></tr><tr><td>Jurassic</td><td>114 ms</td></tr><tr><td>ClearScript</td><td>37 ms</td></tr><tr><td>ClearScript (compiled)</td><td>22 ms</td></tr><tr><td>NiL.JS</td><td>17 ms</td></tr></table>If you come across any other .NET JavaScript engines feel free to let me know and I’ll add them to my comparison.

### One More Test

I wasn’t entirely happy with the tests I had done so I added one more. The script I executed only does one small thing – set a variable to true. This shows more or less the overhead of each engine. I ran this this test 5000 times each and took the average.

One variable results:

<table style="width:auto"><tr><td>jint</td><td><1 ms</td></tr><tr><td>IronJS</td><td><1 ms</td></tr><tr><td>JavaScript.Net</td><td>9 ms</td></tr><tr><td>Jurassic</td><td>3 ms</td></tr><tr><td>ClearScript</td><td>31 ms</td></tr><tr><td>ClearScript (compiled)</td><td>22 ms</td></tr><tr><td>NiL.JS</td><td><1 ms</td></tr></table>Here is the complete script I used. I swapped out currentScript and changed N as needed.

<script src="https://gist.github.com/rushfrisby/59b2d7f91fd15cfe64ff.js"></script>

Target Framework was .NET 4.5.1, Target Platform was x86. Run on a quad score i7 CPU @ 2.40 GHz.

**Updated Results 6/17/2015:**

- Jint does well with small scripts. Has become faster since last August.
- IronJS did okay
- JavaScript.Net looks like it is the overall fastest
- Jurassic did pretty good
- ClearScript is fast but has a lot of overhead. Might want to try [ClearScript.Manager](https://github.com/eswann/ClearScript.Manager) to help with this. (Even so, I’ve had problems getting it to scale.)
- NiL.JS did okay


