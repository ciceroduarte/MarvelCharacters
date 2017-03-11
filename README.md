# MarvelCharacters

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE) 
[![Build Status](https://travis-ci.org/ciceroduarte/MarvelCharacters.svg?branch=master)](https://travis-ci.org/ciceroduarte/MarvelCharacters)
[![codecov](https://codecov.io/gh/ciceroduarte/MarvelCharacters/branch/master/graph/badge.svg)](https://codecov.io/gh/ciceroduarte/MarvelCharacters)

![image0][img0]

## Requirements

- Xcode 8.2+
- [CocoaPods](http://cocoapods.org/)

## Usage

- Create a account on [Marvel Developer Portal](http://developer.marvel.com)
- Go to [My Developer Account](https://developer.marvel.com/account)
- Update `Constants.swift` with your Public and Private keys

```swift
struct Keys {
    static let privateKey: String = "PRIVATE_KEY"
    static let publicKey: String = "PUBLIC_KEY"
}
```

- Run `pod install` from the directory

[img0]:https://raw.githubusercontent.com/ciceroduarte/MarvelCharacters/master/images/transition.gif
