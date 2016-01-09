# WaxPoeticRecords.com

[![Build Status](https://circleci.com/gh/waxpoetic/waxpoeticrecords.com/tree/master.svg?style=svg&circle-token=9ca491303ec9d5ea7d8ba4e01c34855c3ddfac8b)](https://circleci.com/gh/waxpoetic/waxpoeticrecords.com/tree/master)

The official site of **Wax Poetic Records**, including an artist roster
that describes every past and current artist on Wax Poetic, and a release
catalog for browsing more details on each of our releases (including buy
links).

## Features

- Artist and Release catalog
- Automated promotional support for new releases on social media

### Feature Roadmap

- Post new Releases to Twitter, Facebook and Instagram
- Layout re-design, make it less boring

## Development

To develop on this app, you must have the following installed onto your
system:

- Ruby 2.3.0
- PostgreSQL 9.3 or above
- PhantomJS

### Setup

Clone this repo down:

    git clone git@github.com:waxpoetic/waxpoeticrecords.com.git

Install dependencies and stand up the database:

    bundle install
    rake db:setup

Start the Rails server:

    bin/rails server

### Running Tests

A passing build is required for all contributions to this repo. Make
sure the build passes by running tests on your local machine, and fixing
them if they're broken:

    bin/rake test

You can also run different suites of tests for faster results:

    bin/rake test:units
    bin/rake test:features

### Deployment

Deployments are performed automatically using Travis CI. All pushes to
master will be deployed to the staging server at
http://dev.waxpoeticrecords.com, and all tag pushes will result in a
deployment to the production site at http://www.waxpoeticrecords.com.

To bump the version number, tag a new release, and deploy it, run the
following Rake task:

    bin/rake release

You can specify what kind of release you want to deploy:

    bin/rake release:patch
    bin/rake release:minor
    bin/rake release:major

## Contributions

We accept contributions in the form of a pull request, and with a
passing build that adheres to this README and the [CODE OF CONDUCT][].

[CODE OF CONDUCT]: https://github.com/waxpoetic/waxpoeticrecords.com/blob/master/CODE_OF_CONDUCT.md
