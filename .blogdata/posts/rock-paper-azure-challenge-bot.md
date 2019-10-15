
In early January I caught a tweet on my twitter stream about a programming challenge called Rock, Paper, Azure. It was sponsored by Microsoft in order to promote their [Windows Azure](http://www.windowsazure.com) service. The challenge was to create a bot that would play “Rock, Paper, Azure” (RPA) which is a modified version of Rock, Paper, Scissors (RPS).

### In RPA there are two new options

Dynamite and Water Balloon. Dynamite beats Rock, Paper, and Scissors. You have a limit of 100 Dynamite you can use per match. Water Balloon beats Dynamite but loses to Rock, Paper, and Scissors. You have an unlimited supply of Water Balloons.

### How the game is played

Your bot will play every other bot that was submitted. Each match is played until one player has 1000 points. If you win a round you get a point, so you are playing at least 1000 rounds against each bot. If you tie (ex: both of you throw Rock) then no player gets a point for that round and the point carries over to the next round. If you win the next round you now get 2 points. A maximum of 5000 rounds are played. If no one reaches 1000 points by that time the winner is the player with the most points or a tie if equal.

### Creating a bot

Microsoft was kind enough to put together a sample solution which included 3 bot implementations: Cycle, Random, and “Big Bang”. You can guess what the first two do, right? Big Bang started off with 5 Dynamite moves and then switched to choosing random moves. From the samples it was easy to see how to build a bot. Implement IRockPaperScissorsBot which has one method called MakeMove – that’s it.

### Results

At one point I was in the top 25 and a few days after the competition had ended I slid down into the 30’s. There were over 150 submissions so I thought I had decent logic. Throughout the competition you could submit your bot and have it run against every other bot. Doing this was very useful because the challenge website provided logs for every match and you can reverse engineer your opponents logic based on that. I only did this for the top ranked bots who were beating me.

### Prizes!

Every week there were 5 random winners (the competition ran for 6 weeks). Random weekly winners got a $50 BestBuy gift certificate. I was a random winner in the last week. Woohoo! The top 3 overall got some nicer prizes so that could have been a motivating factor for some submissions. I entered just because it sounded like fun… and I had never used Windows Azure before.

I thought I would release my bot code here in case it was of interest to anyone. I added comments throughout as to why I put certain logic in.

<script src="https://gist.github.com/rushfrisby/a481b1be08cdc036c61c.js"></script>


