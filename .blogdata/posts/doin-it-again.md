[//]: # (Doin it again)

Like LL Cool J said back in '96; I'm doin it, and doin it, and doin it again!

![LL Cool J Doin It](/img/post/llcoolj_doin_it.jpg)

At the end of 2016 [I said I was doin it again](application-security-and-single-sign-on) too, but never did (follow the link in that post to an empty github repo), and I've already learned .NET Core by now. I've also learned Identity Server and have integrated one of my previous attempts at a SSO with IS4. I've learned a lot of other things since then too. My need now is mostly due to freedom. I want to be free of working for someone else, to do what I please, whenever I want. In order to get there I have to start making money on my own. This will allow me to do that.

I know I can compete with the major players in the Identity Management space. I've built this solution so many times already that I can do it in my sleep. I may not be able to beat them on number of features right away but I can beat them on price. The other guys are expensive at $2/active user/month. It's why a lot of companies choose to roll their own instead of use a provider. I'm hoping to change that by charging per-login (and refresh tokens). It will be cheap - like pennies per login cheap. I'm a single developer using my own free time to do this so I can do that. I have some other tricks up my sleeve but this is the plan at it most basic.

As far as the tech I have already started working on it. It's on .NET Core 3.1 using SQL Azure and hosted as an App Service in Azure. I'm also using the latest version of Identity Server for the OpenId Connect and OAuth stuff. It will auth against local users, social media, and other Identity Providers. The solution is mostly about user, client, authN, authZ, and access control management. It's not just a hosted version of Identity Server.

I'm calling in [Authly](https://authly.io). Not 100% sold on the name yet. It could be memorable with some witty tie-ins to the word _awfully_. We'll see. More to come soon!

