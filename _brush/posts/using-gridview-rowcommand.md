
I haven’t used this in 6 months and had to lookup how to do it. For some reason the built-in GridView “delete” feature does not work for me (have tried it on multiple setups). Fortunately it is not hard to replicate.

First your GridView has a property called DataKeyNames. Set this to the primary key of your data source. Now in your GridView create a ButtonField. Give it some text and specify the CommandName. CommandName can be any string but keep it simple.

![](/img/post/RowCommand_01.jpg)

Next create a RowCommand event for your GridView.

![](/img/post/RowCommand_02.jpg)

Next fill in the functionality for your command. In the event method you just have to test for which command was fired. Take a look at my example, it also shows how to get the GridView row index and the primary key so that I can delete the record from my sql table.

```csharp
protected void gridServers_RowCommand(object sender, GridViewCommandEventArgs e)
{
  if (e.CommandName.ToLower().Equals("deleteserver"))
  {
    int index = Convert.ToInt32(e.CommandArgument); int ServerID = Convert.ToInt32(gridServers.DataKeys[index].Value);
    clsServer server = new clsServer("mediadb");
    server.ServerID = ServerID; server.DeleteRecord();
    gridServers.DataBind();
  }
}
```
You can come up with other commands, just be creative.


