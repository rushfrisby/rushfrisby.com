
The program below will run a SQL script, convert the results to an HTML table, and email you with it. Everything is passed in via command line parameters which makes it great for running on the fly from a batch file or as a scheduled task. Here is how you use it:

Usage:

sql_emailer.exe <script> <title> <email> <conn>

Parameters:

1. **script** – Path to a SQL script which contains the query to be run.
2. **title** – will be used as the email subject and header within the body.
3. **email** – A single email address or comma delimited list of email addresses to send the query results to.
4. **conn** – A reference to an appSettings key in the config file which contains the connection string of the database to connect to. If this parameter is omitted then “DefaultConnectionString” is used.

In the config file you will need to add the appropriate appSettings keys with connection strings to your database(s). You will also need to configure the SMTP section in the config with your SMTP server settings.

[sdm_download id=”4501″ fancy=”0″]

<div></div>Here is the source code minus the table styling from the exe:  
<script src="https://gist.github.com/rushfrisby/1d0430d1335f9ce6e446.js"></script>


