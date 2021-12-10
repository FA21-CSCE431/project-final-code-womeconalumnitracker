# README


Stack:

* Rails 6.1 +
* Ruby 3.0.2 +
* PostgreSQL

# Dependencies 
 See the [Gemfile.lock](./Gemfile.lock)

# Core features:

Add students to the club
Give the students points
Automatically update whether students are part of the club using their points and whether they have paid dues
Be able to add officers to the club
Set up meetings
Sign in to meetings, which automatically updates student points
Submit requests for points from other meetings, which can be approved by officers.  This will give students the points they requested
Create other meetings
Show a leaderboard of students based on how many points they have


## Authentication

* Log in with Google Account under the Texas A&M University System domain

*** Ex. student@tamu.edu

## Authorization

* User roles
* Role-based access to different features
* Admin can edit user roles

## Connected services:

* Google oAuth API

# Installation

console:
```
git clone https://github.com/tamu-nutrition/WebApp.git
cd WebApp
bundle install
yarn install
rails db:create db:migrate
```
# Start the Web Server
```
rails s -b 0.0.0.0
```
# Run All Tests
```
rails rspec .

```
# Deployment to Heroku
1. Use Docker image from Book Assignment
2. Use $ git checkout <branch> to switch branches
3. We want to run the migration on each deploy automatically.
Create a file named Procfile in the root dir with this line of code
```
 release rails db:migrate
```
5. Create a root route in config/routes.rb
6. Save changes and push to origin/branch 
```
git add . 
git commit -m “add Procfile and route”
git push origin test
```
7. From Heroku Dashboard  
 Click the New button on the top right of the app list and select Create new pipeline  
 ![text](picture/1.PNG?raw=true)    
 ![text](picture/2.PNG?raw=true)  
 
8. Enable Review Apps. Do NOT select any options for this assignment. Click “Enable Review Apps” right away.  
![text](picture/3.PNG?raw=true)  
 
9.  Click “New app” in Review Apps. Choose the test branch. After you click “Create”, Heroku will start deploying immediately. Every time you make changes to the test branch, it triggers automatic deployment.  
![text](picture/4.PNG?raw=true)  
 
10. Create app for staging  
![text](picture/5.PNG?raw=true)  
 
11. Click on the stage-test-app-1. Click Deploy. Choose the main branch for Automatic Deploys.  
![text](picture/6.PNG?raw=true)  
The app is now ready for deployment  
 
12. When the staging app is ready, open the app and check if everything looks good. Then promote it to the production area.  
 ![text](picture/7.PNG?raw=true) 

 

# CI/CD Process
Set up CI/CD through GitHub Actions  
Heroku was used to set up CD, as shown in Deployment to Heroku above  
Go to /.github/workflows/main.yml

## Step 1: set up environment variables
```
env:
  RUBY_VERSION: 3.0.2
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: password
  DATABASE_USER: postgres
  DATABASE_PASSWORD: password
```
## Step 2: create GitHub action "Rails tests"
Action runs when pushing and creating pull requests
```
name: Rails tests
on: [push, pull_request]
```
## Step 3: Create jobs to run – Rspec test
Since we wanted to test using database as well, we set up postgres 
Then we went into the steps that were used to run Rspec tests using our original version of Ruby. The general steps are listed below. 

1.	Install postgres client
``` 
sudo apt-get install libpq-dev
```
2.	Install dependencies
```
gem install bundler
bundler install
``` 
3.	Create database
``` 
bundler exec rails db:create RAILS_ENV=test
bundler exec rails db:migrate RAILS_ENV=test
```
4.	Run tests
``` 
bundler exec rspec .
```
5.	Run brakeman
```
brakeman -o brakeman.txt
```
6.	Run robocop
``` 
bundler exec rubocop --out rubocop.txt
```
7.	Upload coverage results
8.	Upload rubocop report
9.	Upload brakeman report
