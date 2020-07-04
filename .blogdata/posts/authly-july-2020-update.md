[//]: # (Authly July 2020 Update)

Development on Authly is going well. My first task was setting up the architecture and the Azure resources I needed. When I first created the solution I had brought in Identity Server 3.x but since then they've come out with 4.0, so I upgraded to that a few days ago. Doing so immediately affected what I was working on because the persisted grant models changed. I am in the middle of writing my own storage libraries currently. Grants will be stored both in Redis and SQL Azure: Redis for quick read access and SQL Azure for historical and billing purposes... which brings me to the billing model I've been thinking of.

Most identity services are charging around $2 per active user a month. This cost is based on a _constantly_ active user. If you have a user who logs in once a month they are considered active and you're paying $2 for them. It's essentially free money for the identity service. Conversely, you could have multiple users share the same account only be charged $2 total. Neither case accurately reflects the costs associated for the services rendered.

I am thinking of charging on a per-login or per-token basis. Doing so would reflect actual usage more closely than what other companies are doing. I'm still working on the cost model but it will involve multiple tiers.

One struggle I am having is using a dynamic list of Identity Providers. All usage I've seen expects IdPs to be defined in the app Startup. I'm still digging into this.

I will try to blog about my progress once a month.