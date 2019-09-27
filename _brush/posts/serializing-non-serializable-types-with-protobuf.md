
[protobuf-net](https://code.google.com/p/protobuf-net/) cannot serialize everything you throw at it. It’s picky about what it does because it wants to be **fast**. If it were to accommodate every type of object it would have to sacrifice speed. The author did however create a hook so that things it can’t serialize can be turned into something it can serialize. This is done with what it calls *Surrogates*. As you can tell from the name, we tell protobuf-net that for a given type (that it can’t serialize) we want to use a surrogate type (that it can serialize).

Take this class for example:

<script src="https://gist.github.com/rushfrisby/bd5ab77ae92e92d122ad.js"></script>

MyNameValueInfo can’t be serialized because it doesn’t know how to serialize the Value property (typeof object). It will throw an exception: “No Serializer defined for type: System.Object”

To get around this we need to provide a surrogate for MyNameValueInfo that protobuf-net can serialize. First register the surrogate type (only needs to be done once):

`RuntimeTypeModel.Default.Add(typeof(MyNameValueInfo), false).SetSurrogate(typeof(MyNameValueInfoSurrogate));`

Then implement MyNameValueInfoSurrogate so that it can be transformed from/to MyNameValueInfo and is serializable by protobuf-net:

<script src="https://gist.github.com/rushfrisby/8d96986798a6fa43c3b4.js"></script>

**WARNING**  
 Doing binary serialization like this will include Type information in the serialized byte array. This is only useful if the receiving system is also in .NET. For a more universal approach you could use JSON serialization.


