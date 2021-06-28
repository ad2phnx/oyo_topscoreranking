# Top Score Ranking OYO Challenge

Top Score Ranking API built with Ruby 3.0.1.

This application can be built and ran using Docker compose as per instructions below.

# Building

> The docker rails development setup came from [Ruby on Whales:
Dockerizing Ruby and Rails development](https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development)

From the main directory you can spin up the docker container using the following 3 commands:

1. Build the application:

```bash
$ docker-compose build
```

2. Install yarn and setup database:

```bash
$ docker-compose run runner yarn install
```

3. Spin up the main container
```bash
$ docker-compose run runner ./bin/setup
```

# Running

When the runner container is spun up run

```bash
$ rails server
```

to start the rails server listening on port: `127.0.0.1` and port `3000`.

The Postgres database runs inside its' own container and listens for connections at `postgres://postgres:postgres@postgres:5432`

# Tsting

Tests are written using `rspec` and can be ran from the root directory with the following command:

```bash
$ bundle exec rspec
```

The spec files can be found in `spec/[model,requests]` directories


# Configuration

Main configuration for the docker settings can be made inside the `docker-compose.yaml` file in the root directory of the application.

# API

The api exposes the following endpoints and takes requests and responds with json:

## `/health`

### `GET /health/index`

Basic health status check of server. Returns online status:

```json
{
    "status": "online"
}
```

## `/players`

### `GET /players` - Return a list of all players in the form:

```json
[
    {
        "id": 102,
        "name": "jOhn",
        "created_at": "2021-06-28T09:10:01.412Z",
        "updated_at": "2021-06-28T09:10:01.412Z"
    },
    ...
]
```

## `/players/:id`

### `GET /players/:id` - Return player infor and history; top score, low score, average score, all scores (score and time) in the form:

```json
{
    "player": {
        "id": 22,
        "name": "jOhn",
        "created_at": "2021-06-28T08:45:49.351Z",
        "updated_at": "2021-06-28T08:45:49.351Z"
    },
    "top_score": 75,
    "low_score": 34,
    "avg_score": "54.5",
    "all_score": [
        {
            "score": 75,
            "time": "2020-07-19"
        },
        {
            "score": 34,
            "time": "2020-07-20"
        },
        ...
    ]
}
```

## `/scores`

### `POST /scores` - Create a score for a player with `name`. (If player does not exist will be created, otherwise the score will be added to the players current scores)

> Example JSON Body:
```json
{
    "player": {"name": "joe"},
    "score": "11",
    "time": "2021-05-19"
}
```

### `GET /scores` - Get a list of all scores 10 at a time. The following parameters are available and can be stacked:

> All scores endpoint uses pagination for the results and is set to return 10 entries per page.

* `by_player=[player_ids]` - Get scores for one or more specific players, player_ids is a comma separated list of player ids
* `before_time=['yyyy-mm-dd']` - Get scores before a certain date (inclusive)
* `after_time=['yyyy-mm-dd']` - Get scores after a certain date (inclusive)
* `page=[page_number]` - Returns the entries from a certain page

> *Example*:
```json
GET /scores?player_id=1,2&before_time=2021-6-25&after_time=2021-6-20&page=2
```

### `GET /scores/:id` - Get a score object with a specific score id

```json
GET /scores/2
```

### `DELETE /scores/:id` - Delete a score object with a specific id

```json
DELETE /scores/3
```