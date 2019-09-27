
Here is one way to expire a link/web page after a certain amount of time has passed. Instead of keeping track of whether a link is valid or not through a database look-up, this is done by verifying that the expiration date in the url generates the same token that is also passed in through the url. If the user tries to change the date value it will invalidate the token. Users cannot generate the token without the secret key you keep on your server. Here is how it’s done.

First we need to create a model for our expiration date and token:

public class ExpiresModel { public DateTime ExpiresOn { get; set; } public string Token { get; set; } }

Next we need a utility for generating and checking tokens:

public class TokenHelper { private const string HashKey = "secret"; public static string GetToken(ExpiresModel model) { if(model == null) throw new ArgumentNullException("model"); return Crypto.HashSHA512(String.Format("{0}_{1}", HashKey, model.ExpiresOn.Ticks)); } public static bool IsValidToken(ExpiresModel model) { if (model == null) throw new ArgumentNullException("model"); return model.Token == GetToken(model); } }

Notice that in the TokenHelper class is where the secret key lives. The Crypto class I used can be found [here](/c-cryptography-library-md5-sha1-sha2-aes-3des/).

For the front end I have one page which creates the link and another to check the status. Here is the controller for that:

public class HomeController : Controller { public ActionResult Index() { var model = new ExpiresModel(); model.ExpiresOn = DateTime.Now.AddSeconds(30); model.Token = TokenHelper.GetToken(model); return View(model); } public ActionResult Check(long dateData, string token) { var model = new ExpiresModel(); model.ExpiresOn = DateTime.FromBinary(dateData); model.Token = token; if (!TokenHelper.IsValidToken(model)) ViewBag.Message = "Invalid!"; else if (model.ExpiresOn >= DateTime.Now) ViewBag.Message = "Still good: Expires in " + (model.ExpiresOn - DateTime.Now); else ViewBag.Message = "Not good: Expired on " + model.ExpiresOn; return View(); } }

And the Views for those controller methods…  
 Index:

@model WebApplication4.Models.ExpiresModel @{ ViewBag.Title = "Home"; Layout = "~/Views/Shared/_Layout.cshtml"; } <h3>Home</h3> <p>A new link has been generated that expires in 30 seconds. Use the link below to check the status:</p> <p><a href="@Url.Action("Check", new { dateData = Model.ExpiresOn.ToBinary(), token = Model.Token })">Check Now</a></p>

Check:

@{ ViewBag.Title = "Check"; Layout = "~/Views/Shared/_Layout.cshtml"; } <h3>Check</h3> <p>@ViewBag.Message</p> <p>@Html.ActionLink("Gernate another link", "Index", "Home", new { area = "" }, null)</p>

The entire solution can be downloaded [here](http://rushfrisby.com/wp-content/uploads/2014/09/ExpiringLinksExampleSln.zip).

**Update 12/30/2015:**[Webucator.com](https://www.webucator.com) asked me if they could create a video on this blog post which I agreed to. You can [check out the video on youtube here](https://www.youtube.com/watch?v=rRBkQUnXrTM). It turned out great! Webucator has more good [C# training material](https://www.webucator.com/microsoft-training/csharp.cfm) on their website as well. The video on this blog post is part of their “[C# Solutions from the Web](https://www.webucator.com/self-paced-courses/course/c-sharp-solutions-from-the-web.cfm)” course, which is free!


