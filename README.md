## Setup

This sample was developed using Ruby v2.6.0.

Download Ruby at [www.ruby-lang.org](https://www.ruby-lang.org/en/downloads/),
or via a Ruby version manager such as rbenv: `rbenv install 2.6.0`

Setup:

1. Clone the repo.
2. Run `bundle install`.

## Run

### Task 1

From the root of the project, run `ruby main.rb`.

This instantiates a UserManager, imports seed files located in `./files`,
instantiates Users, sorts by various fields, and prints the sorted Users.

The results will be printed in the terminal in order:

- Output 1 – sorted by gender (females before males) then by last name ascending.
- Output 2 – sorted by birth date, ascending.
- Output 3 – sorted by last name, descending.

### Task 2

From the root of the project, run `rackup ./config.ru`.

The web server will run by default on localhost:9292, exposing these endpoints:

- POST /records
- GET /records/gender
- GET /records/birthdate
- GET /records/name

## Specs

To run the specs, from the root of the project, run `bundle exec rspec`.

## Assumptions
__Task 1__

- Data contains no headers.
- Data sources contain clean records.
  - No NULL fields.
  - Consistent order of columns.
- Records are separated by new lines.
- Only two gender options, i.e. sex assigned at birth: female | male.

__Task 2__

- Requests made to POST /records will have this JSON format in the request body.

```
{
  "records": [
    "last_name,first_name,gender,favorite_color,date_of_birth",
    "last_name,first_name,gender,favorite_color,date_of_birth",
    ...
  ]
}
```
- The `records` array may also consist of strings with pipe "|" or space delimited fields, but must be consistent per request.
- Responses to all POST and GET requests will similarly consist of a "records" key, with an array of JSON representing User records.
