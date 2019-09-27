
One of my favorite JavaScript libraries is [Linq.js](https://linqjs.codeplex.com/) (LINQ for JavaScript). Unfortunately the author is not responding to pull requests so I’m going to post my update here.

I’ve added CRUD methods to the library so that you can Add, Delete, and Update items easily. I’ve found this very useful pattern where I load a lot of data when the page loads, convert it to an Enumerable using Linq.js, then as the user modifies data update it locally and send updates back to the server asynchronously.

Here are examples of each method I’ve added:

var data = Enumerable.From([ { "id": 1, "url": "http://amazon.com", "title": "Amazon" }, { "id": 2, "url": "http://google.com", "title" : "Google" }, { "id": 3, "url": "http://yahoo.com", "title" : "Wrong" } ]); data.Add({ "id": 4, "url": "http://msn.com", "title" : "MSN" }); data.Delete(function(x) { return x.id == 1; }); data.Update(function(x) { return x.id == 3 }, { "id": 3, "url": "http://yahoo.com", "title" : "Yahoo!" });

You can [download my linq.js file here](https://gist.github.com/rushfrisby/6ee0e4ce3268bf87270c). You can also [play with a fiddle I created using the example above](http://jsfiddle.net/99eu7/).

Alternatively you can pass a function to Update instead of an object (makes sense if you are updating more than one item at a time):

data.Update(function(x) { return x; }, function(x) { x.title = "updated " + x.id; return x; });


