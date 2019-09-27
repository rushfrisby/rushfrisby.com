
I have a lookup table in SQL Server and a corresponding enum in my code – two different sources that represent the same thing. The problem I was having was that one would become out of sync with the other. To solve this I created a T4 template that will generate an enum based on database values. The database becomes the master source and I just have to run the T4 template to update my code… easy!

Here is the T4 template I created if you would like to use it as well. It generates the enum in C#. The enum name is determined by the name of the .tt file so if you want an enum named LanguageType then rename the .tt file to “LanguageType.tt”. Customize the variables at the top of the script with your connection string, table name, and the columns used for the enum member name and value.

<script src="https://gist.github.com/rushfrisby/b7439f56c14d2b702fcd.js"></script>


