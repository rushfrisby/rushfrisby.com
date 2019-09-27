
I wanted to run .NET on linux since I’ve seen people talking about it so much recently. I couldn’t find a start-to-finish tutorial though so I am attempting to do that here.

1. In VMWare Workstation (you can use VirtualBox just the same) create a VM and install the latest version of [Ubuntu desktop](http://www.ubuntu.com/download/desktop).
2. Once installed and you login, update everything that needs updating in the Ubutntu Software Center and reboot
3. Type everything in the sub-lists below as commands in a terminal…
4. Install Mono: 1. `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF`
2. `echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list`
3. `sudo apt-get update`
4. `sudo apt-get install mono-complete`
5. Install libuv: 1. `sudo apt-get install automake libtool curl`
2. `curl -sSL https://github.com/libuv/libuv/archive/v1.4.2.tar.gz | sudo tar zxfv - -C /usr/local/src`
3. `cd /usr/local/src/libuv-1.4.2`
4. `sudo sh autogen.sh`
5. `sudo ./configure`
6. `sudo make`
7. `sudo make install`
8. `sudo rm -rf /usr/local/src/libuv-1.4.2 && cd ~/`
9. `sudo ldconfig`
6. Install the .NET Version Manager (DNVM): 1. `curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh | DNX_BRANCH=dev sh && source ~/.dnx/dnvm/dnvm.sh`
7. Install the .NET Execution Environment (DNX): 1. `dnvm upgrade`
8. More installs for the next part: 1. `sudo apt-get update`
2. `sudo apt-get upgrade`
3. `sudo apt-get install build-essential openssl libssl-dev curl git`
9. Install NVM: 1. `git clone git://github.com/creationix/nvm.git ~/.nvm`
10. To load NVM whenever a terminal is opened: 1. `echo '[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"' >> ~/.bash_profile`
11. Start NVM in the current terminal: 1. `. ~/.nvm/nvm.sh`
12. Install Node.js (0.12.6 is the latest version as of this post, you should replace this with whatever the current version is when you install it): 1. `nvm install v0.12.6`
2. `nvm alias default 0.12.6`
13. Install Yeoman (Yo) and the scaffolding template for ASP.NET projects: 1. `npm install -g yo generator-aspnet`
14. Generate an empty ASP.NET project. A wizard will come up and ask you what type of project you want to create. I created a *Simple* website and named it “MyFirstDotNetAppOnLinux”: 1. `yo aspnet`
15. Switch to the new directory/template that was created: 1. `cd MyFirstDotNetAppOnLinux`
2. `dnu restore`
16. Start Web Server: 1. `dnx . kestrel`
17. Open Firefox and go to **http://localhost:5000**
18. To kill the web server hit *Ctrl+Z* then enter `kill %1`

Here are the articles I referenced when putting together this start-to-finish guide:

- [http://docs.asp.net/en/latest/getting-started/installing-on-linux.html#installing-on-debian-ubuntu-and-derivatives](http://docs.asp.net/en/latest/getting-started/installing-on-linux.html#installing-on-debian-ubuntu-and-derivatives)
- [http://mariehogebrandt.se/articles/installing-yeoman-grunt-bower-and-yo-on-ubuntu/](http://mariehogebrandt.se/articles/installing-yeoman-grunt-bower-and-yo-on-ubuntu/)
- [https://ovaismehboob.wordpress.com/2015/05/02/creating-asp-net-5-web-application-using-yeoman-generator/](https://ovaismehboob.wordpress.com/2015/05/02/creating-asp-net-5-web-application-using-yeoman-generator/)
- [http://stackoverflow.com/questions/25712814/how-to-quit-asp-net-kestrel-web-server-on-a-mac](http://stackoverflow.com/questions/25712814/how-to-quit-asp-net-kestrel-web-server-on-a-mac)

**Don’t forget to install [Visual Studio Code](https://code.visualstudio.com/) so you can edit your project in Ubuntu!**


