
Everyone gets hacked. Even the best websites. Hackers find a way. But if they get you, why make it easy on them? Store your passwords in best way possible so that they are hard to crack! Password storage involves two steps: salting and hashing.

One thing to keep in mind is that passwords are not cracked in the traditional sense any more. That takes too long. Most “cracks” happen by using a [rainbow table](http://en.wikipedia.org/wiki/Rainbow_table) and generating hashes to compare to what you have stored.

### Salting

The purpose of salting is to make every password as close to 100% unique as possible. This can be done by generating random bytes and adding them to a users’ password. This way if two users are created with the exact same password, the same value will not get stored in the database. It mitigates the use of a rainbow table. Make your salt a reasonable length and give it a wide range of possible values. Your website may only allow ASCII characters for the users’ password but don’t limit yourself to these characters when generating the salt. Make sure your salt is randomly generated for every user. I’ve seen applications that use a static salt for every password – don’t do that!

The salt should be stored in your database along with the hashed password+salt. When storing the salt make sure to encrypt it. When a user logs in your goal is to be able to pull out the salt, decrypt it, add it to the attempted password, hash it, and compare that value to the stored hash. Again, encrypt your salt! Keep your encryption key as safe as possible.

### Hashing

Hashing is one-way encryption, meaning you cannot decrypt the value. Some hashing algorithms are better suited for passwords than others. [Here’s why](http://www.troyhunt.com/2012/06/our-password-hashing-has-no-clothes.html)… Did you know on a moderately priced GPU you can generate over 4.7 billion MD5 hashes per second? Or how about over 2.2 billion SHA1 hashes per second? SHA2 variants aren’t far behind either. The problem with these algorithms is that they are meant to be fast. Fast is not good for password hashing.

So what is a good hashing algorithm? BCrypt is a hashing algorithm that is meant to be slow. It takes a certain amount of processing power to generate a BCrypt hash. It will take a hacker a long time to generate lots of them and they won’t be able to crack your passwords as fast. Either that or it means they will need more/faster hardware which drives up the cost. BCrypt is configurable so that you determine how fast or slow it runs. This, of course, means that your new user/login/change password functions will take longer. What is a little more added time to your login process though? Most users won’t be able to tell or care. The amount of protection added far outweighs the cost of time to real users.

Is there something better than BCrypt? Yep. SCrypt does every BCrypt does but requires a certain amount of memory. This drives the time/hardware cost up even more. The amount of memory required to generate a hash is configurable.

### Sample Application

Below is a sample MVC3 solution that incorporates hashing a salting properly. I named the solution “ParanoidNerd” thus the reason for the post title.

[Download ParanoidNerd](http://rushfrisby.com/wp-content/uploads/2013/03/ParanoidNerd.zip) [3.2 MB]


