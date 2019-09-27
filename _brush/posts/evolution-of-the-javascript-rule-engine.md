
I was working on RulePlex this week and came across a couple of things I wanted to share. First is a change in the way that rules are “compiled”. You can’t really compile JavaScript per se but this is the process of how things came about working the way they do…

In the first iteration, JavaScript rules were executed individually. If there were 100 rules in a Policy I would execute 100 little JavaScript snippets for an incoming request. The snippets were “compiled” when the call to the API was made. I soon realized that this might be okay if a Policy had a few rules but for large Policies it was *slow* – even if I executed all of the snippets in parallel.

For the next iteration I took all of the rules and compiled them into one big script. In order to do this I had to wrap the rules with some advanced JavaScript techniques. Because this big script contains the results of every rule I had to append something unique to each result’s variable name – the rule’s **Id**. This makes the script look horrifying but I am okay with it for now (it’s not hurting performance). Executing one big script increased performance tremendously. Here is an example of what a Policy with 1 rule that simply returns **true** looks like compiled:

<script src="https://gist.github.com/rushfrisby/ac4aedf49ec4b1270c9e.js"></script>

At the same time I had extended this technique to the C# rule engine. I took it a step further though and actually compiled C# rules into a DLL. I took the binary code for the DLL and stored it along with the Policy. I did the compilation whenever a rule in the Policy changed – not when the API was called like I had been doing with the JavaScript engine. When the API *was* called, I got the DLL’s binary data and loaded it into memory to be executed against the incoming data.

I mimicked the binary compilation and loading of the C# rules into the JavaScript engine as well. The thing is, I never really liked doing it in the JavaScript engine because I had to convert the compiled script (text) to binary, so I could store it in the same database field, and then from binary back to text when it was time to be executed. In C# it made sense but not in JavaScript. Now that the C# engine is gone I had a chance to go back and change this.

Presently, when rules are changed (or added/deleted/etc), RulePlex will compile it’s big script during the save of the rule. I saves it to the Policy as text. When the API is called the script is retrieved and executed.

I haven’t thought about tweaking this process any more but I may in the future. Instead I have been thinking about how this affects the workflow from a business perspective. The more I think about it the more I like the changes that I’ve made. If I ever change how I “compile” the big script it won’t affect policies that are currently *working* (a certain way). What if I’ve got a bug in the script that you’ve accounted for in you’re rules, knowingly or unknowingly. If I change how the script is compiled and it’s being compiled during the API request then it could be different day-by-day without any actions by you. This is bad because I may have fixed or introduced a bug that changes the results. Now the application you’ve integrated with RulePlex is broken!

The ideal workflow is that there are two copies of the same Policy, maybe even three, or N. One copy would be designated as a Production copy, while the others are for Dev/Staging/whatever. When the engine changes, you want to test those changes in a non-Production environment first. When you’ve verified that the changes do not affect your application then that non-Production copy can be promoted to Production. This also applies to the workflow of building out a Policy too, not just back-end changes to the engine. The concept of environments will be included in the next version of RulePlex.


