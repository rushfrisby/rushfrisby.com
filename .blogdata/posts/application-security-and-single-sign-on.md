In 2017 I will be developing [a new, open source, application security and single sign on solution](https://github.com/rushfrisby/AppSecSSO). It will compete directly with [OneLogin](https://www.onelogin.com/) and [Okta](https://www.okta.com/). Since 2000 I have built four solutions just like this.

In 2000 I took my first stab at this for [EVLogix](https://www.google.com/?q=EVLogix). My solution consisted of a few classes and a few web pages that secured our main web app, using classic ASP. I'm sure it was completely insecure. I hope it's not still being used.

In 2008 I had a grand idea to create an "application framework" which provided a dashboard for users to launch their web applications and gave developers a way of managing apps and accounts. I was building user-management-type-stuff into every app I wrote and this would allow me to skip that and just get to the point of what each app was meant to do. I created a LLC and developed the source under it. Eventually I abandoned the project when I realized what I had built could be done better. It was .NET based but was using ASP.NET web forms and the API requests were parsed and constructed in a non-standard way.

In 2010 I built a new solution for the company I was working for at the time, [Digital Risk](http://www.digitalrisk.com/). The web portion was built using ASP.NET MVC and the API moved to a WCF service. This was much improved, however, some design choices were poor and I started securing other WCF services with it. This resulted in security overload and made it frustrating for other developers to use.

In 2014 I built another solution for [Derive Systems](http://derivesystems.com/) (who I currently work for). The web portion and API are again written in ASP.NET MVC and WCF, but I didn't make any mistakes I had made previously. It's secure and easy for developers to use with web, mobile, and desktop apps.

**So why am I developing yet another solution?**

My primary reason is to use this as a way of learning [.NET Core](https://www.microsoft.com/net/core/platform). .NET Core is cross-platform so it can be hosted on **Windows *and* Linux**. I also want the solution to be open-source to promote broader use and gain input from different people. I am a big fan of [GitHub](https://github.com/) so I am hosting the source on there.

I haven't decided on one thing yet - whether the solution will be simultaneously used for profit or not. [Exceptionless](https://exceptionless.com/) currently works on this model and they do a good job of it. I recently listened to a podcast on [Andreessen Horowitz](https://a16z.com/) in which they said this model is gaining popularity. Using the solution for profit will affect the type of open-source community members that choose to contribute so I am taking that into consideration as well.

I am looking for community members who want to get involved early. If so, [shoot me an email](mailto:rush@rushfrisby.com?subject=Your AppSecSSO project), [hit me up on twitter](https://twitter.com/rushonerok/), or [create some issues](https://github.com/rushfrisby/AppSecSSO/issues) on GitHub!