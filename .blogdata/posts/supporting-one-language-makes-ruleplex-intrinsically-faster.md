
In my previous post I wrote that one of the decisions I made about RulePlex was to only support one rule language. This will make the engine intrinsically faster and I’ll show you why.

When you create a Policy (a set of rules) one of the options you are given is to chose a rule language. When it’s time to run your rules you provide the data and the Name or Id of the policy. From that Name/Id the Policy is found which will tell us the rule language. Once we know the language we can begin processing the rules.

At first you might think of writing code for this that fits into a switch pattern. I might look something like this:

<script src="https://gist.github.com/rushfrisby/46e42ade6fbe1ef5e179.js"></script>

Some things to note here – I am using enums and I left out the implementation of how the rules are processed. That’s because I just want to talk about the switch pattern. It’s not the cleanest way of writing this. My example only has 3 cases but the worst switch I’ve ever seen had over 80 cases, used strings for the case values, and had an average of 12 lines per case – over 1000 lines in total! This is an amplification of my point which makes it very clear, that, switches can become unreadable and hard to maintain. Whenever you have a switch statement you should ask yourself if [using a Strategy pattern](http://blogs.microsoft.co.il/gilf/2009/11/22/applying-strategy-pattern-instead-of-using-switch-statements/) makes more sense.

In RulePlex I used the Strategy Pattern, something to the effect of this:  
<script src="https://gist.github.com/rushfrisby/8368c0393accbee4cd97.js"></script>

The downside to this pattern is that a dictionary lookup is slower than a switch statement. The upside is that it cleans up code very nicely. I could have added support for 10 new rule languages and the lookup code would have stayed the same. It’s up to you to decide between these trade-offs. My original goal was to support as many languages as possible in RulePlex so using the Strategy Pattern would have saved me headache down the road.

That all changes now that RulePlex is only using JavaScript rules. I don’t need the strategy pattern and I don’t even need a switch statement. Instead I can new-up a JavaScriptRuleEngine and call Execute() on it. Faster and cleaner!

On a side note (back to my comment on using enums): You should [never use “magic strings”](http://stackoverflow.com/a/9501967/266804). Your world will be a much better place without them.


