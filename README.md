# WaxPoeticRecords.com

[![Build Status](https://travis-ci.org/waxpoetic/waxpoetic.svg?branch=master)](https://travis-ci.org/waxpoetic/waxpoetic)

The official site of **Wax Poetic Records**, an open-source record label
from Philadelphia. On the surface, this application powers
http://www.waxpoeticrecords.com and serves a speedy and simple marketing
site for the label. Powering this front-end is a central repository for
all information related to the label, including the artist roster,
release catalog, upcoming events, and social media automation features.
In addition to the marketing site consuming this backend information,
it's also provided as an API to power our various band marketing sites
such as http://www.thewonderbars.com and http://www.rnd.club, which are
simple front-end apps that call out to this API for information.

## Features

- Artist and Release catalog
- Automated promotional support for new releases on social media
- JSON API for powering additional marketing sites
- Frontend marketing site powered by [ES6][], [Haml][] and [SCSS][].
- Events database and artists CMS powered by Facebook

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
[ES6]: http://es6rocks.com
[Haml]: http://haml-lang.com
[SCSS]: http:/sass-lang.com
