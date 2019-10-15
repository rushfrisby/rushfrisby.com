
There have been a couple of times recently where I wanted to implement double-checked locking so that I could pull data from cache and fall back on a database lookup. This is a simple technique if I just had one thread but I am doing this in the context of a multi-threaded application (a RESTful API). If I place a lock on an object it would block all other threads. Because requests include a key (think int Id property, Guid, or unique string name) I would like to put a lock on the **key** so that other threads can continue being processed unless they pertain to the same key. This way I am only doing one database lookup per key. I didn’t find anything baked into .NET that would allow me to do this. I also wanted it to look as much like the typical lock(object){} syntax as possible so that it could be easily understood by other developers. Here is the solution I came up with:

<script src="https://gist.github.com/rushfrisby/3c9847d1fd92cfa9a0ad.js"></script>

You can combine this with a using statement to achieve the desired feel of the lock syntax:

```
using (new KeyLocker("mykey"))<br></br>
{<br></br>
	//only one thread per key will execute code in this block<br></br>
}```

Here is an example:

<script src="https://gist.github.com/rushfrisby/fbf20351986b2d553e9e.js"></script>


