dotnet /c/dev/github/RushBlog/RushBlog.StaticSiteGenerator/bin/Debug/netcoreapp2.1/RushBlog.StaticSiteGenerator.dll /c/dev/github/rushfrisby.com/
cd /c/dev/github/rushfrisby.com/
SqlCmd -E -S "(localdb)\mssqllocaldb" -Q "BACKUP DATABASE [RushBlog] TO DISK='c:\dev\github\rushfrisby.com\_db.bak'"
rm _db.zip
zip -9 _db.zip _db.bak
rm _db.bak
git add -A
git commit -m "publish"
git push