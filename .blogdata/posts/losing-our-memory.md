
I read [this post by Scott Hanselman](http://www.hanselman.com/blog/WhenDidWeStopCaringAboutMemoryManagement.aspx) a while back and agree with him in that memory management in .NET is not a concern for developers. I have not thought directly about any of the items he listed within the last 10 years. I learned low level programming early on but once I moved into higher level languages, memory management became something I thought about less and less. There are three factors that contribute to this: Memory capacity, cost, and management.

Memory capacity took a huge jump in the late 2000s. It became common for run-of-the-mill servers to have 16GB+ of RAM. The amount of memory available now is so excessive that database servers can run entirely in memory. In the unlikely event that memory runs out, the emergence of the cloud and auto-scaling saves us - which brings me to my next point.

Memory costs nothing! It's so cheap that maxing out a server with the most RAM possible is expected. If your server is running in the cloud it's not even worth mentioning "memory". The cost of cloud servers is cheap and auto-scaling means you're only paying for what you need anyways. If you need more memory the cloud will give it to you automatically and for the most part without you even knowing!

The third reason why, and most specifically for .NET developers, is that the garbage collector does a darn good job of memory management. This was one of the original selling features of the framework! Let the GC handle what it was meant to do and let developers solve the problem at hand.

Recently I've thought a lot memory management. That's because my company develops firmware in C on handheld devices with a low amount of memory. Hardware specs aren't something companies change regularly and we have a good sourcing cost for the chips we get. Let's just say that there is no incentive to add more memory so developers have to make-do with what they've got.

I'm not writing C, so I'm not thinking about memory directly, but I'm writing web services that are consumed by these devices. Here are some things I have to keep in mind during development:

* The serialization format must be compatible and performant on our device.
* The data types returned must be platform agnostic.
* The data structures must adhere to a strict contract.
* The size of each piece of data could be an issue.
* The overall size of requests and responses must be as small as possible.

If all of these criteria are met then I have a _pretty good_ chance of the device being able to work well with the service.

As far as the technologies I chose, I went with Protobuf for serialization. It's fast and produces small output. It's supported on all of the systems & languages my company is working with. Both the software and firmware teams can utilize .proto definitions as contracts and generate structures/classes from them. Protobuf isn't a silver bullet though. I still need to be mindful of the data I am working with...

For example, before our device can communicate with the service it must obtain a security token (a `string`). I found bug in the the way the security token was generated, so I fixed it, and pushed a new version of the service out. Suddenly our devices stopped working! What happened?

It turns out that the token, before my fix, was 1000 characters long. The firmware team allocated 1000 characters for that field in their code. When I made my fix the token generated was 1200 characters long. The device was truncating the string and subsequent requests to the service couldn't be validated because the token wasn't correct. I hadn't given one thought to the size of token value because a `string` type in .NET can hold a variable length (fairly large) string no problem. On our devices though, that 1000 characters was critical!

In conclusion, I don't expect .NET developers will actively pay attention to memory management. They should keep it in the back of their mind at all times though. It's important to know how the framework you are working with deals with memory. It would be a good investment to dig deep into it when beginning to learn a new framework. Once .NET Core becomes more prevalent I expect memory management will garner some attention, but ultimately it will end up in the state that .NET Framework developers are in now - ignorance.