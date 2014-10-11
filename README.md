# WaxPoeticRecords.com

The official site of **Wax Poetic Records**, including an artist roster
that describes every past and current artist on Wax Poetic, and a release
catalog for browsing more details on each of our releases (including buy
links). There's also an online store for purchasing copies of each
release as well as merchandise and event tickets.

## Setup

Check out the [waxpoetic cookbook][cookbook] to set up the application
in Chef.

### Requirements

- Ruby 2.1.3
- PostgreSQL 9.3 or above
- PhantomJS (for developers)

### Instructions

Clone this repo down:

```bash
$ git clone git@github.com:waxpoetic/waxpoeticrecords.com.git
```

Install dependencies and stand up the database:

```bash
$ bundle install
$ export RAILS_ENV=staging
$ rake db:schema:load db:seed
```

Start Foreman to bring up the web server and Sidekiq:

```bash
$ foreman start
```

## Development

All contributions must include tests and must be given within a pull
request. Tests should encompass both unit and integration levels, as
well as acceptance features.

### Feature Roadmap

- Post new Releases to Twitter, Facebook, Soundcloud and Instagram
- Layout re-design, make it less boring
