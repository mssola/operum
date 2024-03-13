## Why?

Do you want to fix an error you have found? Do you have a suggestion to improve
this application? I am open for discussion and welcome any help!

## How?

There are many ways to help me out. One way might be to open an issue on
[Github's tracker](https://github.com/mssola/operum/issues) and start a
discussion. For this, mind the following:

- Check that the issue has not already been reported or fixed in `main`.
- Try to be concise and precise in your description.
- If you have found a problem, provide a step by step guide on how to reproduce it.
- Provide the version you are using (git commit SHA).

Another way is to simply submit a pull request. For this, also mind these:

- Write a [good commit message](https://chris.beams.io/posts/git-commit/).
- Tests continue to work (see `Testing` below).
- The application continues to work.
- The pull request has *only* one subject and a clear title. You are not
  submitting a pull request with tons of different unrelated commits.

## Testing

Before doing anything at all make sure that your ruby version is as specified in
the `.ruby-version` file, and that you have also installed `bundler`. After
that, just run `bundle` to get all the gems as needed.

Then prepare the database:

```sh
$ bundle exec rake db:setup
```

And finally, in order to run unit tests, simply run:

```sh
$ bundle exec rails test
```

System tests can also be run quite simply:

```sh
$ bundle exec rails test:system
```

And finally, make sure that the code follows the proper style:

```sh
$ bundle exec rubocop
```
