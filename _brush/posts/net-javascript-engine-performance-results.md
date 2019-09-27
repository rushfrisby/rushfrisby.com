
[Back in August](/which-net-javascript-engine-is-the-fastest) of last year I did some tests to determine which .NET JavaScript engine was the fastest. I wanted to get a better picture of the overall performance of each so I went back and grabbed all of the tests from [Dromaeo](http://dromaeo.com/) to run. Below are the engines I compared and how fast they ran each test.

### Engines

- [jint](https://github.com/sebastienros/jint) – version 2.5.0.0
- [IronJS](https://github.com/fholm/IronJS) – version 0.2.0.1
- [JavaScript.Net](https://github.com/JavascriptNet/Javascript.Net) – version 0.7.1.0
- [Jurassic](http://jurassic.codeplex.com/) – version 2.1.0.0
- [ClearScript](http://clearscript.codeplex.com/) – version 5.4.2.0
- [NiL.JS](https://github.com/nilproject/NiL.JS) – version 1.4.740.0

### Results

** All times are in milliseconds*
<iframe width="100%" height="300" src="//jsfiddle.net/rushonerok/xmz4m70t/embedded/result/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

If I didn’t have a timeout then NiL.JS would never have finishing loading knockout. Jurassic’s timeout on v8-earley-boyer is okay, it just runs really slow.

I’ve been thinking of adding more tests which show the performance of .NET types being used in JavaScript and JavaScript variables being retrieved by .NET after the script has run. Stay tuned.

The [source code for these tests](https://github.com/rushfrisby/jsnetperf) are on GitHub.


