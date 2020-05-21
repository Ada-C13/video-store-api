# Video Store API

## At a Glance
- Pair, [stage 2](https://github.com/Ada-Developers-Academy/pedagogy/blob/master/rule-of-three.md#stage-2) project
- Due EOD Friday at 6 PM on **DATE HERE**
- Submit this project with a PR

## Introduction

[Video rental stores](https://en.wikipedia.org/wiki/Video_rental_shop) are businesses that need to track a lot of things. Namely, they need to keep track of:

- the store's inventory of videos available for rental
- their customers

A small video rental business would use software to help manage this data.

## Learning Goals

- Design an API in Rails that is compatible with a given dataset, and design an ERD and ActiveRecord models
- Build an API that exposes database contents
- Apply best practices to handle edge-cases in the context of an API, and reasonably handle bad user data
- Practice testing APIs through writing controller tests

## Objective

We will make an API in Rails for a small video rental store.

This API will be able to serve information about the store's inventory of videos and customer information.

The API will also be able to update the status of rental.

This repository provides two JSON datafiles to serve as the initial seeds for this system.

You and your team should use all the techniques we've learned so far to keep yourselves organized and on track, and ensure that no requirements slip through the cracks.

### Success Criteria
Your project will be evaluated against the following requirements:

- API conformity
  - The provided smoke tests should pass (see the subfolder)
  - Bad data sent to the API should result in an appropriate status code and helpful error
- Test coverage
  - Models: All relations, validations, and custom model methods should include at least one positive and one negative test case
  - Controllers: Every API endpoint should include at least one positive and one negative test case
- Style and Organization
  - Everything we've learned so far about how to design and build a Rails app still applies!

## Project Baseline
- Read the API Requirements specified in the [Wave 2 & 3 requirements section](https://github.com/Ada-C12/video-store-api#wave-2-customers-and-movies) and take note of the following for each endpoint
  - The _HTTP verbs_ each endpoint will use
  - Any data that must be provided to the endpoint in order for it to do its work
- Read the Seed Data description below and, bearing in mind the API Requirements, create an ERD for your database that specifies
  - The _models_ your database will require
  - The _attributes_ for each model
  - Any _relationships_ between models
- Create a new Rails app to serve as the API
  - **Create the rails app with:** `$ rails new . --api`
- Create a route that responds to `/zomg` that serves a json-encoded "it works!"

## Wave 1: Database Models, Tables, & Seeds
- Generate Rails models and associations to match your ERD
- Use the provided seed script `db/seeds.rb` to import the provided JSON data into your database

In the past, many students have spent lots of time writing and testing validations for these models. Because project time is limited and validations are not an important learning objective this week, we do not recommend this. Instead, validate only those fields that, if they are absent, will break your API.

### Seed Data
`movies.json` contains information about the videos available to rent at the store. The data is presented as an array of objects, with each object having the following key-value pairs:

| Field          | Datatype | Description
|----------------|----------|------------
| `title`        | string   | The title of the film
| `overview`     | string   | A short plot synopsis
| `release_date` | date   | `YYYY-MM-DD`, Day the film was originally released
| `inventory`    | integer  | How many copies of the film the video store owns

`customers.json` contains information about the customers that have rented with the store in the past. The data is presented as, you guessed it, an array of objects, with each object have the following key-value pairs:

| Field            | Datatype | Description
|------------------|----------|------------
| `name`           | string   | The customer's name
| `registered_at`  | datetime   | `Wed, 29 Apr 2015 07:54:14 -0700`, When the customer first visited the store
| `address`        | string   | Street address
| `city`           | string   | &nbsp;
| `state`          | string   | &nbsp;
| `postal_code`    | string   | &nbsp;
| `phone`          | string   | Primary contact phone number

### Testing
As with all Rails projects, model testing is a requirement. You should have _at least_ one positive and one negative test case for each relation, validation, and custom function you add to your models.

Use good TDD practices, and test _before_ you code. Remember: red-green-refactor.

## Waves 2 and 3: Coding The API
In this wave, you will implement the API described below. The endpoints are described more-or-less in order of complexity, and we recommend you build them in that order. Every endpoint must serve JSON data, and must use HTTP response codes to indicate the status of the request.

The schema of your database and the structure of your rails app are completely up to you, so long as the API conforms to the description and provided script.

### Error Handling
If something goes wrong, your API should return an appropriate [HTTP status code](http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/), as well as a list of errors. The list should be formatted like this:

```json
{
  "errors": {
    "title": ["Movie 'Revenge of the Gnomes' not found"]
  }
}
```

All errors your API can return should be covered by at least one test case.

### Testing
Because APIs are often open to the public, thorough testing is essential. For a Rails API, that means controller testing.

For each API endpoint, you should have _at least_:
- A basic test with no parameters, if applicable
- Positive and negative tests for any URI parameters (user ID, movie title)
- Testing around any data in the request body

Use good TDD practices, and test _before_ you code. Remember: red-green-refactor.

#### Smoke Tests
Because this API will be used as the backend for a future project, there are strict requirements about how it should be structured. To this end, we have provided a set of [smoke tests](http://softwaretestingfundamentals.com/smoke-testing/) written in Postman to exercise all the endpoints.

The smoke tests will verify that your API looks correct to the outside world, by sending actual HTTP requests to your running server and checking the results. They test things like:

- Did I get a success response for a valid request?
- Did the API return JSON?
- Does the JSON contain the expected property names?

We have also included [this video](https://adaacademy.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=1324e06e-9767-49e4-85a0-a98c0122d69a) to show you how to run and use smoke tests.

**The smoke tests are not a substitute for writing your own tests!!!!!** They do **not** check that the content is _correct_, nor do they cover any negative or edge cases. Verifying correctness in these cases is **your** responsibility.

The smoke tests live in the [test folder](test). To run them:

1. Open Postman
1. Click `Import` in the top left
1. Drag-and-drop the file into the box
1. In the left sidebar, click on the `Collections` tab
1. There should now be an entry for the smoke tests. Hover over it and click the `>` icon for a detail view.  You will notice they are in the format `{{url}}/movies`.  `{{url}}` is a key which you can give a value on your computer.
1.  To do so go to the Gearbox in the top-right and select `Manage Environments`
![Manage Environments](images/manage-environment.png)
1.  Then Select `Add`
![add button](images/add-btn.png)
1.  Lastly add a key `url` and value `http://localhost:3000`
![Key & Value](images/key-value.png)
1. Click the blue `Run` button. This will launch the collection runner.
1. In the collection runner, scroll down in the center pane and click the blue `Start Test` button

## API Description

### Wave 2: Customers and Movies

#### `GET /customers`
List all customers

Fields to return:
- `id`
- `name`
- `registered_at`
- `postal_code`
- `phone`
- `movies_checked_out_count`
  - This will be 0 unless you've completed optional requirements

#### `GET /movies`
List all movies

Fields to return:
- `id`
- `title`
- `release_date`

#### `GET /movies/:id`
Look a movie up by `id`

URI parameters:
- `id`: Movie identifier

Fields to return:
- `title`
- `overview`
- `release_date`
- `inventory` (total)
- `available_inventory` (not currently checked-out to a customer)
  - This will be the same as `inventory` unless you've completed the optional endpoints.

#### `POST /movies`
Create a new movie in the video store inventory.

Upon success, this request should return the `id` of the movie created.

Request body:

| Field         | Datatype            | Description
|---------------|---------------------|------------
| `title` | string             | Title of the movie
| `overview` | string | Descriptive summary of the movie
| `release_date` | string `YYYY-MM-DD` | Date the movie was released
| `inventory` | integer | Quantity available in the video store

### Wave 3: Rentals

Wave 2 focused on working with customers and movies. With these endpoints you can extend the functionality of your API to allow managing the rental process.

#### `POST /rentals/check-out`
Check out one of the movie's inventory to the customer. The rental's check-out date should be set to today, and the due date should be set to a week from today.

**Note:** Some of the fields from wave 2 should now have interesting values. Good thing you wrote tests for them, right... right?

Request body:

| Field         | Datatype            | Description
|---------------|---------------------|------------
| `customer_id` | integer             | ID of the customer checking out this film
| `movie_id`    | integer | ID of the movie to be checked out

#### `POST /rentals/check-in`
Check in one of a customer's rentals

Request body:

| Field         | Datatype | Description
|---------------|----------|------------
| `customer_id` | integer  | ID of the customer checking in this film
| `movie_id`    | integer | ID of the movie to be checked in

## Optional Enhancements
These really are **optional** - if you've gotten here and you have time left, that means you're moving speedy fast!

### Query Parameters
Any endpoint that returns a list should accept 3 _optional_ [query parameters](http://guides.rubyonrails.org/action_controller_overview.html#parameters):

| Name   | Value   | Description
|--------|---------|------------
| `sort` | string  | Sort objects by this field, in ascending order
| `n`    | integer | Number of responses to return per page
| `p`    | integer | Page of responses to return

So, for an API endpoint like `GET /customers`, the following requests should be valid:
- `GET /customers`: All customers, sorted by ID
- `GET /customers?sort=name`: All customers, sorted by name
- `GET /customers?n=10&p=2`: Customers 11-20, sorted by ID
- `GET /customers?sort=name&n=10&p=2`: Customers 11-20, sorted by name

Of course, adding new features means you should be adding new controller tests to verify them.

Things to note:
- Sorting by ID is the rails default
- Possible sort fields:
  - Customers can be sorted by `name`, `registered_at` and `postal_code`
  - Movies can be sorted by `title` and `release_date`
  - Overdue rentals can be sorted by `title`, `name`, `checkout_date` and `due_date`
- If the client requests both sorting and pagination, pagination should be relative to the sorted order
- Check out the [will_paginate gem](https://github.com/mislav/will_paginate)

### More Endpoints: Inventory Management
All these endpoints should support all 3 query parameters. All fields are sortable.

#### `GET /rentals/overdue`
List all customers with overdue movies

Fields to return:
- `movie_id`
- `title`
- `customer_id`
- `name`
- `postal_code`
- `checkout_date`
- `due_date`

#### `GET /movies/:id/current`
List customers that have _currently_ checked out a copy of the film

URI parameters:
- `id`: Movie identifier

Fields to return:
- `customer_id`
- `name`
- `postal_code`
- `checkout_date`
- `due_date`

#### `GET /movies/:id/history`
List customers that have checked out a copy of the film _in the past_

URI parameters:
- `id`: Movie identifier

Fields to return:
- `customer_id`
- `name`
- `postal_code`
- `checkout_date`
- `due_date`

#### `GET /customers/:id/current`
List the movies a customer _currently_ has checked out

URI parameters:
- `id`: Customer ID

Fields to return:
- `title`
- `checkout_date`
- `due_date`

#### `GET /customers/:id/history`
List the movies a customer has checked out _in the past_

URI parameters:
- `id`: Customer ID

Fields to return:
- `title`
- `checkout_date`
- `due_date`


## Reference
- [Postman on Environments](https://www.getpostman.com/docs/environments)

## What We're Looking For

Check the [feedback template](./feedback.md) to see how we will evaluate your project.
