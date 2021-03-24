# [![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)

## Tuist

This project is setup with [Tuist](https://tuist.io). Therefore no `xcodeproj`/`xcworkspace` is committed to this repo.

To run the project execute the following commands in Terminal after cloning the repo.

1. Run `.tuist-bin/tuist generate`. This will generate the needed `xcodeproj` and `xcworkspace` files.
2. Run `xed .` to open the project in Xcode.

## Modular

This project has a modular structure. This means that the app contains of multiple modules. I think this picture explains this setup quite nicely.

![Modular](https://miro.medium.com/max/4800/1*R0eXIAd8_2A1jnfA1LqD2Q.png)

### MainApp

The `MainApp` module is the starting point of the app. It contains the `AppDelegate` and `SceneDelegate` and does some setup like resolving dependencies. Also, this module should contain the UI tests (not yet implemented).

### Feature ScaleFinder

Currently the app consists of only one feature: `ScaleFinder`. This feature enables a user to type in some random notes and get all possible scales for these notes in return.

This feature is setup according to Clean Architecture principles. The `GetScaleInteractor` has some unit tests as an example.

### Common layer

The Common layer consists of modules which can be used by the App Module or Feature Modules. For example the `Resolver` module which is used for Dependency Injection.

### External dependencies

External dependencies are added through SPM. In order to make it possible to use the same external dependency in several modules all external dependencies are added to the dynamic framework `SPMDependencies`. This is a workaround for the `duplicate symbols` error in Xcode if a (static) framework is added to different modules.
