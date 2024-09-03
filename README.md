# GistApp

This project is intended to show the public GitHub Gists.

## Features

- List public Gists of GitHub with pagination;
- Show Gist details;
- Show the first Gist content;
- Copy the first Gist content;
- Favorite Gist;
- Unfavorite Gist;
- List all the favorited Gists;
- Show favorited Gist detail;
- Clear all favorited Gists.

## Build and Runtime Requirements

- Xcode 15.2 or later
- iOS 15.0 or later

## Installation

Clone the repository:
`https://github.com/SiqueiraYris/gist-app.git`

Go to folder:
`GistApp`

Open the file:
`GistApp.xcodeproj`

Run:
`Command + R`

## Architecture

The project is structured based on the `MVVM-C` design pattern and clean architecture. The app is a set of modules each module is basically (but not necessary) a screen of the app, where each one is a SPM (Swift Package Manager). They are all located in the `Packages` folder.

- `ViewController`: responsible for building the UI and receive user events.
- `ViewModel`: responsible for making the logic and receive events from `ViewController`.
- `Service`: responsible for making requests for backend.
    - `ServiceRoute`: responsible for defining request parameters.
- `Coordinator`: responsible for making the navigation and flow control.
- `Composer`: responsible for having the concrete instances of objects.

The project has an `Application` folder where are the app startup files located. It also has a `Resources` folder where are the project assets, configurations etc. The `Navigation` folder inside `Application` is the possible app navigation routes.

The app has two schemes allowing you to change environments (Development and Production). Today it only has a host address provided by GitHub, but if a development address appears, the app is already prepared.

### Modularization

The application has some utility modules (Foundation):
- `NetworkKit`: manages all requests with the backend, exposing only one manager.
- `DynamicKit`: used to do reactive programming.
- `ComponentsKit`: centralizes the components, colors and UI tokens of the app.
- `DatabaseKit`: manages the local database of the app.
- `CommonKit`: centralizes all common utilities for the app.
- `RouterKit`: manager the app navigation, based on URLs.

The application has three feature modules:
- `GistKit`: responsible for showing the list of public Gists.
- `GistDetailKit`: responsible for showing Gist detail.
- `FavoritesKit`: responsible for showing favorited Gists offline.

### Unit Tests

- `DynamicKit`: unit tests are located in `DynamicKitTests`, the code coverage is 100%.
- `CommonKit`:  unit tests are located in `CommonKitTests`, the code coverage is 98%.
- `RouterKit`: unit tests are located in `RouterKitTests`, the code coverage is 99%.
- `NetworkKit`: unit tests are located in `NetworkKitTests`, the code coverage is 87%.
- `GistKit`: unit tests are located in `GistKitTests`, the code coverage is 88%.
- `FavoritesKit`: unit tests are located in `FavoritesKitTests`, the code coverage is 82%.
- `GistDetailKit`: unit tests are located in `GistDetailKitTests`, the code coverage is 81%. Note: when running the `GistDetailViewModelTests`, you need to enable an alert for pasting content into the simulator.

## Next steps

- Show all files content of the Gist;
- Add other languages (internationalization);
- Add UI tests to `ComponentsKit`;
- Change `DynamicKit` to `Combine`;
- Use `Combine` in `RouterKit`.
