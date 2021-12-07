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

