Name: Candidate
Organisation: Which?


Prerequisites:

1. Operating system :  Mac OS version 10.11.6 and above
                      Windows 10 and above
2. Ruby version: 2.2 or above
   Help link: Installation path: https://www.ruby-lang.org/en/documentation/installation/

3. Install chrome driver installed and binary location should be available in PATH. 
   This will be used by automation to launch chrome browser
Help link: https://brewinstall.org/install-chromedriver-on-mac-with-brew/    

4. Install bundler gem if not available in your machine 
   Help link: https://rubygems.org/gems/bundler/versions/1.11.2

How to run:

1) Please down load the project or clone on your working directory
2) Go to the project folder which
3) Run command "bundle install"
4) We have a .rubocop.yml file. type "rubocop" and you will see no cops. I have allowed the use of double quotes instead of single. So please modify the cop definition accordingly.
5) Run command "cucumber features --tags @televisions -p html_report"
6) After test run , we can see the latest test run report as "Reports.html"
7) In case of ElementNotFound exceptions, we will see the screenshots with unique date time stamp under "screenshots" (relative path) folder like screenshots/1542526275.png.
8) Please note in the next test old screenshots will move under "screenshots/old" 

