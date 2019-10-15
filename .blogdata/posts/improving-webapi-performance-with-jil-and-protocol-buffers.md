
One of the reasons I don’t use WebAPI for internal services is because of the performance hit incurred when serializing and deserializing JSON and XML messages. Even for public API’s this is somewhat of a pain. After digging around I’ve found ways to improve the performance of WebAPI serialization.

In .NET there are lots of serializers. The most popular being [Json.NET](http://james.newtonking.com/json) which was chosen by Microsoft to be the default JSON serializer for WebAPI. Json.NET is great because it is fast, robust, and configurable. There are serializers that are **faster** than Json.NET though. Take a look at [these benchmarks](http://theburningmonk.com/2014/02/json-serializers-benchmarks-updated/):

![Source: theburningmonk.com](/img/post/serializer_benchmarks.png)

![Source: theburningmonk.com](/img/post/serializer_benchmarks2.png)

</div>ServiceStack.Text, Jil, and Protobuf-Net are all faster than Json.NET. Protobuf-Net is not a JSON serializer but I’ll get to that in a minute. ServiceStack.Text slightly edges out Json.NET in terms of speed and from what I can tell is as robust as Json.NET. I frown upon using it however because it’s not entirely free. There is a free version but it will only deserialize 10 object types and serialize 20. I will never use it because of this. Json.NET is free and the performance gain in using ServiceStack isn’t enough for me to pay.

There is one more option we need to look at though – [Jil](https://github.com/kevin-montrose/Jil). Jil is optimized for speed over memory. The author of Jil goes into detail on [his blog](http://kevinmontrose.com/) on the optimizations he’s made to get the best performance. It is interesting reading if you have time. Jil is also used on the [Stack Exchange API](https://api.stackexchange.com/) which is used by many people. I almost forgot to mention – it’s free!

[Protocol Buffers](https://code.google.com/p/protobuf/), or Protobuf for short, is Google’s official serializer. They use it for all of their internal services. Instead of JSON this is a binary serializer. I was interested to see the payload size of binary serialization versus JSON so I did a quick test. Json.NET produced a payload of 728 bytes while the same object serialized by Protobuf was 444 bytes (39% smaller). The act of serialization is also faster as you can see in the benchmarks above. The combination of the two means you can receive and send WebAPI messages faster than the default serializer. But how can we use this in WebAPI?

The great thing about WebAPI is that swapping out serializers and adding support for new ones is a breeze. In my projects I am now swapping out Json.NET for Jil and adding support for protobuf. WebAPI will return the correct result to the caller based on the content-type they wish to receive. Here are some articles on how you can do this too!

- [Implementing protocol-buffers in WebAPI](http://www.strathweb.com/2013/02/asp-net-web-api-and-protocol-buffers/)
- [Consuming protobuf services](http://damienbod.wordpress.com/2014/01/11/using-protobuf-net-media-formatter-with-web-api-2/)
- [Protobuf-net project](https://code.google.com/p/protobuf-net/)

