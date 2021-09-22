# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run `rails dev:cache` for API caching.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Evaluation](./doc/evaluation.md)

## Live App
[Link to live app. deployment](https://little-esty-shop-denver.herokuapp.com)

## Database Schema

![Schema](https://user-images.githubusercontent.com/72399033/134418403-99e1a24c-11fb-442c-a682-01e86095ba7d.png)

## Schema


## Tools Used

| Development    | Testing |  Gems                 |
| :-------------:| :------:| :--------------------:|
| Ruby 2.7.2     | Rspec   | SimpleCov             |
| Rails 5.2.6    |         | Pry                   |
| HTML5          |         | Capybara              |
| Bootstrap      |         | ShouldaMatcher        |
| Atom           |         | Launchy               |
| Git            |         | Orderly               |
| Github         |         | Factorybot/Faker      |
| Github Project |         |                       |
| Postico.       |         |                       |


## Contributors

- [Isika Powers](https://github.com/Isikapowers/)
- [Ida Olson](https://github.com/idaolson)
- [Mike "Ozzie" Osmonson](https://github.com/ozzman84)
- [Rowan DeLong](https://github.com/RowanDW)
