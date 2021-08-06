# Pave iOS Sample Use Case

This is a sample iOS implementation of pave.dev's Cashflow API.

## Contents

1. [Getting Started](#getting-started)
2. [Building The Project](#building-the-project)
3. [Implementing The HTTP API](#implementing-the-http-api)
3. [Exploring The Code](#exploring-the-code)


## Getting started
This use case sample was implemented in swift, as a result you'll need to have xcode installed on your develoment environment. You can download it [from their official page](https://developer.apple.com/xcode/) if you don't already have it installed.

Additionally, this project uses [Cocoapods](https://cocoapods.org/) as a dependency manager. If you don't already have it installed on your development environment, you can follow the instructions [on their website](https://cocoapods.org/).

## Building The Project
Run `pod install` in the project's root folder. This will build the project's dependencies.

## Implementing the HTTP API
To start working with the app, put your API Key and a user's id  in `Pave/Services/NetworkService.swift` (fields `token` and `userId`).
```swift
var token: String {
	return "YOUR_TOKEN_HERE"
}
```

```swift
var userId: String = "ID_OF_THE_USER"
```

You can browse this file for the rest of the API Implementation

## Exploring the code

If you're interested in how we built the charts, you can find the code for that in the `Pave/Charts` folder

To set values to ChartViewController, map your values to array of `DashboardValue`, and then pass them in `setValues` method.

