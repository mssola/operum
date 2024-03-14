<p align="center">
  <a href="https://github.com/mssola/operum/actions?query=workflow%3ACI" title="CI status for the main branch"><img src="https://github.com/mssola/operum/workflows/CI/badge.svg" alt="Build Status for main branch" /></a>
</p>

---

> mille dea est operum: certe dea carminis illa est; <br />
> &emsp; si mereor, studiis adsit amica meis.
>
> &mdash; P. Ovidi Nasonis - Fasti 3.833-834

This is a simple application that keeps track of all your sources (i.e. books,
papers, articles). With this information at hand you can:

- Add comments and notes to any source to keep track of what you found more
  relevant from it.
- Tag sources and comments in whatever way you wish.
- Save searches that match on a user-defined tag, or a certain string from any
  of your sources or comments.
- Export searches into CSV or TeX so it can be used for building up bibliography
  sections on a paper you might be working on.

## Workflow

The workflow revolves around the idea of being able to track sources and
comments with tags that you have defined, and then being able to list sources
with searches based on these tags. This way, you might want to add tags about
project names, topics, language, etc.; and then attach these tags into the
sources and comments that you have added into the application. Afterwards, you
can save searches and they will be shown on top of the application. With this,
you can switch between different ways in which you have groupped your sources.
This groups come in handy to further filter on your sources, or to export these
sources into a TeX file that can be used for the paper you might be working on.

## Deployment

The recommended way to deploy this application is through a Docker container.
Take a look at the provided `Dockerfile` file, which is more than enough to get
this done. After building the image, remember that:

1. You need to provide a `RAILS_MASTER_KEY`, just like any other Rails application.
2. You need to create a Docker volume for the `/rails/storage` path. This path
   will contain the SQLite3 database and thus you need this to persist across
   deployments.

Oh, yeah, we are using SQLite3 in production, no biggie! For the use case of
this application SQLite3 is actually just fine and it allows us to keep things
simple.

Other than that, there are some *optional* environment variables that you might
want to touch:

- `OPERUM_BASE_TITLE`: the title that is going to be shown for the application.
  By default this is set to be just `Operum`.
- `OPERUM_DEFAULT_LOCALE`: that's right, this application supports multiple
  languages! For now these languages are catalan and english but other languages
  are also welcome, just hit me with a
  [PR](https://github.com/mssola/operum/pulls) and take a look at the files
  under `config/locales`. You can change the default locale (catalan) by setting
  this environment variable with the language code for it (i.e. `en` for
  english).

## Contributing

Do you want to contribute with code, or to report an issue you are facing? Read
the [CONTRIBUTING.md](./CONTRIBUTING.md) file.

## [Changelog](https://pbs.twimg.com/media/DJDYCcLXcAA_eIo?format=jpg&name=small)

Read the [CHANGELOG.md](./CHANGELOG.md) file.

## License

```txt
Copyright (C) 2023-Ω Miquel Sabaté Solà <mikisabate@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
