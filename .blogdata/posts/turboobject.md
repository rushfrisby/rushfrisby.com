
Sometimes I want to have a dynamic variable that no matter what property I try to access, never throws an exception. ExpandoObject doesn’t do this. Here is an example:

dynamic source = new ExpandoObject(); source.Property1 = "test"; Console.WriteLine(source.Property3);

Trying to access source.Property3 throws a RuntimeBinderException which is what I am trying to avoid. What I want is for source.Property3 to return either null or some other value (like an empty string). The solution I created to solve this problem is called TurboObject. ExpandoObject is a cool name so I tried to come up with an equally, if not more, cool name. Here it is!

<script src="https://gist.github.com/rushfrisby/177e06258c3a8b9c0b46.js"></script>

Now when I try accessing source.Property3 I get back an empty string…

dynamic source = new TurboObject(string.Empty); source.Property1 = "test"; Console.WriteLine(source.Property3);

If you just create a new TurboObject() with no constructor parameters then null would have been returned; that is the default.


