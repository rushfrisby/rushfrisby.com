[//]: # (InterfaceRpc 2.0)

This past week my Interface RPC library hit version 2.0 and I want to take a minute to go over how I got there.

I used the first version for a few services that my company depends.  It was running in production just fine, for a while. After a couple months I found an issue however. The issue was with how exceptions were handled by my code which in-turn caused an additional exception. The result of this caused threads to hang and eventually starve the system. It was a simple fix and services continued to run fine.

I ran into a second problem a few months later. This one however, was much more serious and caused a service to hang until restarted. I knew what method was being called to cause it but that's about it. I didn't do much digging other that than because I knew that I didn't want to maintain the HttpListener implementation of this library any more. I was a stop-gap for how I really wanted it to work...

Ideally I wanted to host services on ASP.NET Core and plug into that ecosystem of things, like; depenency injection, configuration, and security.

So that's what I did. Instead of fixing a bug I chucked most of my code, refactored what was left (A LOT), and made a 2.0 I felt a whole lot better about.

I've had 2.0 running in production for months now with no issues whatsoever. This past week a co-worker tidy'd up one last thing which pushed me over the edge in removing the pre-release moniker and published the official 2.0 nuget package! Let's take a look.

## Service Setup ##

This is done during Startup within the `Configure` method. The RPC service is essentially now middleware in the ASP.NET pipeline.

```cs
public void Configure(IApplicationBuilder app)
{
    app.UseRpcService<IDemoService>(options => {...});
}
```

The options you can configure are

- **Prefix** - hosts the service under a virtual subdirectory. This is useful for hosting multiple services in the same app.
- **AuthorizationScope** - either `None`, `Required`, or `AdHoc` (default). If AdHoc then authorization will only be checked when your method is decorated with `AuthorizeAttribute`.
- **ServiceFactory** - a function that returns the instance of the interface. You can grab this from ASP.NET's DI container by calling `app.ApplicationServices.GetService<IDemoService>()`
- **AuthorizationHandler** - a function that returns true for authorized. See below for an example.

Here we are looking for a security token in the Authorization header to determine if a user is authorized to access the service.

```cs
options.AuthorizationHandler = (methodName, instance, context) =>
{
    if(!context.Request.Headers.ContainsKey("Authorization"))
    {
        return false;
    }
    if(!context.Request.Headers.TryGetValue("Authorization", out StringValues authHeader))
    {
        return false;
    }
    var bearerCredentials = authHeader.ToString().Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries)[1];
    var tokenHandler = new JwtSecurityTokenHandler();

    var validationParameters = new TokenValidationParameters
    {
        IssuerSigningKey = _signingCredentialStore.GetSigningCredentialsAsync().GetAwaiter().GetResult().Key,
        ValidAudience = "demo-service",
        ValidIssuer = "https://sso.domain.com"
    };

    var user = tokenHandler.ValidateToken(bearerCredentials, validationParameters, out SecurityToken securityToken);
    var token = securityToken as JwtSecurityToken;
    return token != null && token.ValidTo >= DateTime.Now;
};
```

`_signingCredentialStore` is defined in the Startup class as `private static ISigningCredentialStore _signingCredentialStore;` and is set in the `ConfigureServices` method by calling `serviceProvider.GetService<ISigningCredentialStore>()`

`IDemoService` is also configured in `ConfigureServices` just like any other implementation would.

```cs
services.AddTransient<IDemoService, DemoService>();
```

## Creating a Client ##

The client code hasn't changed much.

```cs
var client = RpcClient<IDemoService>.Create(new RpcClientOptions
{
    BaseAddress = "https://demo.domain.com",
    SetAuthorizationHeaderAction = () =>
    {
        return new RpcClientAuthorizationHeader
        {
            Credentials = "access token",
            Type = "Bearer"
        };
    }
});
```

`SetAuthorizationHeaderAction` will be called before every request.

## Wrapping Up ##

Everything else pretty much works the same as before. The service responds to POST requests where the method name in the URL translates to a method on the interface. Serialization can be any type defined in the [SerializerDotNet](https://www.nuget.org/packages/SerializerDotNet/) library (JSON and Protobuf currently).

One thing that is not apparent is that the service and client both handle async methods.

I hope you find this useful and choose to use it for your next project! If you'd like to contribute you can find the source on [GitHub](https://github.com/rushfrisby/InterfaceRpc).
