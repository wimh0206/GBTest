To Run these cucumber test cases, 
plz follow below steps:
 
1.Install RVM and ruby
https://rvm.io/rvm/install 
https://www.ruby-lang.org/en/documentation/installation/

2.Install capybara

gem install capybara

3.Install cucumber 

gem install cucumber

4.Install Selenium Webdriver

gem install Selenium-Webdriver

5.Install siteprism 

gem install site_prism

6.Open project and run as below: 

bundle install

7.Run test scenaro using 

cucumber cucumber <feature_directories> 

e.g: cucumber /Users/nhunguyen/insurance_app/features/travel_insurance/travel_insurance.feature

8.Run report 

cucumber -f pretty -f html -o report.html

I also generated report, plz have a look in report.html 

9.All information about code struture is below file

https://docs.google.com/document/d/1yR3DIBZBq-4V_l_mzj32QkpBVj56GL29uHXYVwAU1mI/edit# GBTest
