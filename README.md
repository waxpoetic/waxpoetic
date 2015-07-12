# WaxPoeticRecords.com

[![Build Status](https://circleci.com/gh/waxpoetic/waxpoeticrecords.com/tree/master.svg?style=svg&circle-token=9ca491303ec9d5ea7d8ba4e01c34855c3ddfac8b)](https://circleci.com/gh/waxpoetic/waxpoeticrecords.com/tree/master)

The official site of **Wax Poetic Records**, including an artist roster
that describes every past and current artist on Wax Poetic, and a release
catalog for browsing more details on each of our releases (including buy
links). There's also an online store for purchasing copies of each
release as well as merchandise and event tickets.

## Features

- Artist and Release catalog
- Online store for merchandise and releases
- Authentication system for release downloads
- Email new releases to a private promo list and upload their tracks
  to Soundcloud.

### Feature Roadmap

- Post new Releases to Twitter, Facebook and Instagram
- Layout re-design, make it less boring
- Event ticketing

## Setup

Install Docker (and potentially Boot2Docker), then run the following
command to get everything set up:

```bash
$ make
```

You should now be able to browse to http://waxpoetic.dev.

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
$ rake db:setup
```

Start Foreman to bring up the web server and Sidekiq:

```bash
$ foreman start
```

You can also run `rake -vT` to view all other command-line tasks for
this app.

[cookbook]: https://github.com/waxpoetic/cookbook
