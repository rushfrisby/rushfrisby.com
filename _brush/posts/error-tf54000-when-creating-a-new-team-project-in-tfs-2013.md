
I setup a brand new TFS 2013 server and was in the process of creating my first team project when I received this error:

> TF54000: Cannot update data because the server clock may have been set incorrectly. Contact your Team Foundation Server Administrator.

I had changed the time zone on the server after installing TFS so I figured this error was because of that. In TFS there is a table called tbl_Changeset. If you check it there is a CreationDate column which is the date at which you checked in something to TFS. When installing TFS it creates the first changeset automatically. The date for that first record was now 3 hours after the current time. I couldn’t create a team project because changeset 2 would have occurred before changeset 1. The changeset numbers and CreationDate both need to be chronologically in the same order for things to work.

To fix this I ran an update statement to set the first record back a day (it could have been 3 hours but 1 day works just as well). This is the query I used:

`UPDATE tbl_Changeset SET CreationDate=CreationDate-1 WHERE ChangeSetId=1`

I went back to Visual Studio and was then able to create my team project without issues.


