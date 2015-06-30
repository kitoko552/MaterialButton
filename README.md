# MaterialButton
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

MaterialButton is material design button like used in [Google Calendar for iOS](https://itunes.apple.com/us/app/google-calendar/id909319292?mt=8) or [Inbox by Gmail for iOS](https://itunes.apple.com/us/app/inbox-by-gmail-inbox-that/id905060486?mt=8).  

MaterialButton is inspired by [MaterialKit@nghialv](https://github.com/nghialv/MaterialKit) and based in my [CircularRevealAnimator@kitoko552](https://github.com/kitoko552/CircularRevealAnimator).

## Installation
Add the `MaterialButton.swift` file to your project.

Not supported CocoaPods and Carthage yet.

## Usage
### Initialize
MaterialButton is subclass of UIButton. So you can initialize it both on Srotyboard and in program.

But you should specify width and height of button to equal. MaterialButton should be square and its background color should be same to super view, but if you use it as circle shape, you do not have to be same color.

If you want to know more, please see my example (MaterialButton/Example).


#### Storyboard
If you use Storyboard in your project, you can initialize MaterialButton by specifying it to subclass of UIButton.

![Storyboard](http://f.st-hatena.com/images/fotolife/k/kitoko552/20150630/20150630171315.png)

#### Program
If you want to initialize MaterialButton, you can use two initializers below.

```swift
let button1 = MaterialButton()
let button2 = MaterialButton(frame: CGRectMake(...))
```

### Customization
You can customize some properties of animation below.
- expandDuration
- contractDuration
- rippleOpacity
- rippleColor

## Requirements
- iOS 8.0+
- Xcode 6.3

## License
MaterialButton is released under the MIT license. See LICENSE for details.
