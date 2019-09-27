
With the rise of REST APIs, and with it Web API on .NET, I am surprised that no type of code contract technology has been thought up. I’ve seen the question asked by [unfamiliar-to-rest-apis](http://stackoverflow.com/questions/16209100/asp-net-web-api-and-data-contracts) folks on stackoverflow but thatis the extent of what I’ve seen after having tried Googlea few times. Other types of services have contracts or service descriptions. Why don’t we have code contracts for REST API’s? With all of these APIs floating around and no way of guaranteeing that those APIs don’t change, it’s a little bit like the wild west inRESTland.

I’m getting quite tired of it. When you reach this point there is only two things you can do: give up or solve the problem.With my luck, my boss will tell me tomorrow that we’re integrating with a newvendor who has yet another REST API, and then what am I going to do? …I’m going to attempt to solve the problem because I can’t just give up. So far I’m half way there. I’ve got a solution for creating the contract which I’ll cover below. The second part is to add some tooling to Visual Studio, or something, that will automatically create types and a proxy.

REST API Contract Format

The format is described using JSON and is as follows:  
<script src="https://gist.github.com/rushfrisby/ae50712b8a8a21df7485.js"></script>


