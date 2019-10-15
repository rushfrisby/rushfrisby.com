I'm currently working on [a project to quickly stand up an RPC service](https://github.com/rushfrisby/InterfaceRpc) based on an interface. It's a .NET Standard library. Here's how it works.

Let's say you have an interface,
```
public interface IEchoService
{
    string Echo(string echo);
}
```

, and you have an implementation that needs to be exposed so that others can call it. I chose HTTP for this.

On the server I use `HttpListener` to create a web server and listen for requests. When a request comes in the path maps to a method name. For example, if my web server is listening on `http://localhost:6000/` and a request for `http://localhost:6000/Echo` comes in - that maps to the `Echo` method on the interface... then I use reflection to call it on the implementation that was provided.

If `Echo` didn't map to a method on the interface then a 404 response is returned.

In my library all HTTP requests are POSTs. The content is deserialized based upon the `Content-Type` header value of the request. I am using another library I created to handle this called [SerializerDotNet](https://github.com/rushfrisby/SerializerDotNet). At the time of writing it supports JSON and Protobuf. The same serializer used for deserialization is also used to return data in the response and the response's `Content-Type` is the same as the incoming request.

Remember when I said "quickly stand up an RPC service"? This is how quickly it's done...
```
var svc = new RpcService<IEchoService>(new EchoService());
svc.Start();
```

To use this in your own project add [InterfaceRpc.Service](https://www.nuget.org/packages/InterfaceRpc.Service/) to your project using NuGet.

There is a file called `rpcsettings.json` where you can specify additional settings. Currently only the web server prefixes and number of connections.

To create a client it's just as easy...
```
var client = new RpcClient<IEchoService>.Create("http://localhost:6000/");
```

To use this in your own project add [InterfaceRpc.Client](https://www.nuget.org/packages/InterfaceRpc.Client/) to your project using NuGet.

By default it uses `JsonSerializer`. There is an optional 2nd argument where you can specify the type of `ISerializer` (like `ProtobufSerializer`)

Then you can call any method defined in your interface:

```
var echoed = client.Echo("hello");
```

#### Limitations ####
(stuff I could use help on)

* I punted on handling SSL certs so it only runs over plain HTTP right now. This seems reasonable given that it's common to setup a load balancer or proxy in front of web sites and services.

* 8 parameters in method signatures - this can expand to more in the future, if needed, but I think once you get this many it's better to create a class with properties for each and use 1 parameter in the signature.

* Because of limitations with `ValueTuple`, text based serialization reads a little funky, but I'm sure Microsoft will fix this in future versions of .NET Standard. In the meantime I'm curious to see what people think about having "Item1", "Item2", etc... map to method parameters. There could be some work done to replace these with parameter names but it would add (unnecessary?) overhead.

* A good name. Any suggestions?

* See the [issues list on github](https://github.com/rushfrisby/InterfaceRpc/issues) for more

#### Why? ####
This will help tremendously in moving off of WCF / .NET Framework and onto .NET Core. WCF clients aren't supported in .NET Core. The good thing about WCF is that it is interface-based, so swapping out a server implementation is relatively easy. Assuming a `ChannelFactory` was used for the client, it can be replaced even easier.

If you'd like to help in fleshing this idea out more please contribute through the [github repo](https://github.com/rushfrisby/InterfaceRpc)!

<table width="100%" style="border:1px solid #c0c0c0;">
<tr>
<td nowrap="nowrap"><a href="https://www.nuget.org/packages/InterfaceRpc.Service/" target="_blank">InterfaceRpc.Service</a></td>
<td width="100%"><a href="https://www.nuget.org/packages/InterfaceRpc.Service/" target="_blank"><img src="https://img.shields.io/nuget/v/InterfaceRpc.Service.svg?style=flat" alt="NuGet Status" style="display:inline;padding:0" /></a></td>
</tr>
<tr>
<td nowrap="nowrap"><a href="https://www.nuget.org/packages/InterfaceRpc.Client/" target="_blank">InterfaceRpc.Client</a></td>
<td width="100%"><a href="https://www.nuget.org/packages/InterfaceRpc.Client/" target="_blank"><img src="https://img.shields.io/nuget/v/InterfaceRpc.Client.svg?style=flat" alt="NuGet Status" style="display:inline;padding:0" /></a></td>
</tr>
</table>

