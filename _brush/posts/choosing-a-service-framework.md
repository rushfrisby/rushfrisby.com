
The release of Web API marks what I count as the 4th service framework Microsoft has released for .NET. In this post I will discuss my reasoning behind which one to use. Here are the 4 in order of when they were released:

1. ASMX Web Services
2. WCF Services
3. OData
4. Web API

These aren’t all upgrades from one to the other despite what popular culture may dictate. There are actually good cases for using each one of these.

…except ASMX Web Services. You should never create anything using this. When I see vendors who still use this technology I cringe and will not use them at all. It’s a sign that they haven’t kept up with technology. It’s not just old products using this. It can be new products too – ones that have old developers who aren’t up to speed. Old does not necessarily mean “mature” or “weathered”. Actually in the cases I’ve seen it means those services are full of bugs and the developers are slow to fix them.

### WCF Services

This is the one technology that was meant to handle all web service scenarios. It completely replaces ASMX. The pros of using WCF are that you get a contract to code against, it’s fast and flexible, and it works over all kinds of protocols. The downside is that it takes more work to setup and the configuration choices can be confusing. It’s been out for a while and so I think it’s lost that “new hotness” appeal, but overall WCF is the best option for creating a serious service. I choose to create WCF services when I am building an internal Service Oriented Architecture. The reason for this is because I can use special protocols which make communication faster. For example I use net.tcp for internal client to server or server to server communication. net.tcp does binary serialization which is fast. For services that are talking to each other on the same machine it gets even better because you can use net.pipe. In this case nothing is serialized at all – the communication happens in-memory which is the fastest way possible. It’s like hooking up your brain to another person’s brain and just *thinking* to each other. WCF Services can be hosted by any .NET application type. Most typically that means through IIS or as a Windows Service. I prefer to host through a Windows Service so that the service is readily available whereas IIS application pools can shut down and will take a while to start back up when a new request is made of it. OData and Web API can’t do any of these things.

### OData

This was meant to be used for broad access to shared data. OData hooks up a database directly to a web service. It makes the data query-able through manipulating the query string. A good example for OData would be for the US Census Bureau to share yearly survey results with the public over the internet. Or for a library to share it’s catalog of books and media over the internet. This type of web service is less common. It should never be used with a transactional database.

### Web API

I’m not exactly sure why this technology was created other than to say Microsoft has a REST based API solution. It has evolved into a useful solution over time though. It’s is a good choice for public services being accessed over the internet. The two most prominent features are: 1) Content coming from the client is deserialized based on the Content-Type (header value) and serialized back to the client in the same format. The most common content types are [XML](http://www.w3.org/XML/), [JSON](http://www.json.org/), and [BSON (binary JSON)](http://bsonspec.org/) 2) It follows the same pattern as [ASP.NET MVC](http://www.asp.net/mvc) so it’s easy to pick up for developers familiar with that technology. Because Web API is the “new hotness” a lot of folks have been creating these types of services instead of WCF, even when WCF is more appropriate. It’s not an upgrade. Web API and WCF are useful for different scenarios. Usually when I create a Web API service I put a WCF service layer behind it because you normally don’t just have a standalone API. Most of the time you have an accompanying application which uses the same functionality as the API.


