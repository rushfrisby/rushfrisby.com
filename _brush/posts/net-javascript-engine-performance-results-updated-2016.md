A little over a year ago I ran some performance tests against six .NET JavaScript engines. Here are the updated results for this year. Things that have changed are:

- Upgraded engines. Not all have updates from last year though.
- Upgraded some of the javascript libraries. Again, not all have had updates since last year.
- Upgraded project to run on .NET 4.6.1 because of NiL.JS. NiL.JS project page says its supposed to run on .NET 4.5 but I got compiler errors telling me otherwise.

Due to such major changes I expected the results to change quite a bit, and they did.

### Engines

- [jint](https://github.com/sebastienros/jint) – version 2.9.1.0
- [IronJS](https://github.com/fholm/IronJS) – version 0.2.0.1
- [JavaScript.Net](https://github.com/JavascriptNet/Javascript.Net) – version 0.7.1.0
- [Jurassic](http://jurassic.codeplex.com/) – version 2.2.1.0
- [ClearScript](http://clearscript.codeplex.com/) – version 5.4.6.0
- [NiL.JS](https://github.com/nilproject/NiL.JS) – version 2.3.955.0

### Results

** All times are in milliseconds*
<iframe width="100%" height="300" src="//jsfiddle.net/rushonerok/0L9abarn/embedded/result/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

The biggest improvement came from Jint, but it's still the slowest overall.

IronJS is slow as well. It hasn't been updated in years. I think it was a "just for fun" project. Use with caution!

Javascript.NET is definitely the fastest, followed closely by ClearScript (V8).

Jurassic came in at about the middle. Not bad.

NiL.JS showed major improvements across the board and now is a little faster than Jurassic.
