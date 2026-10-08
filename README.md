# afloury/tap

Homebrew formulae for [wherdr](https://wherdr.dev), the web app and phone PWA for the coding
agents running in [Herdr](https://herdr.dev).

```sh
brew install afloury/tap/wherdr   # the first install also brings Homebrew's Node.js
brew services start wherdr        # runs now and at every login
wherdr open                       # setup guide in your browser, then its Phone step
```

Update with `brew upgrade wherdr && brew services restart wherdr`.

The formula is updated automatically when a new wherdr version is published on npm.
Issues: https://github.com/afloury/wherdr/issues
