# Elementary ❤️ Hummingbird

> [!NOTE]
> Please use the [hummingbird-elementary](https://github.com/hummingbird-community/hummingbird-elementary) integration package
> when using Elementary with Hummingbird.

## Running the example

Run the app and open http://localhost:8080 in the browser

```sh
swift run App
```

## Dev mode with auto-reload on save

The `swift-dev` script auto-reloads open browser tabs on source file changes.

It is using [watchexec](https://github.com/watchexec/watchexec) and [browsersync](https://browsersync.io/).

### Install required tools

Use homebrew and npm to install the following (tested on macOS):

```sh
npm install -g browser-sync
brew install watchexec
```

### Run app in watch-mode

This will watch all swift files in the demo package, build on-demand, and re-sync the browser page

```sh
swift dev
```
