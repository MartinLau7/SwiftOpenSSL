# OpenSSL

**This project is based on [Kitura/OpenSSL](https://github.com/Kitura/OpenSSL)**

Also refer to the dependency replacement on [OuterCorner/OpenSSL](https://github.com/OuterCorner/OpenSSL) memory macOS.
If you trust this project, you can add dependencies through SPM:

```swift
dependencies: [
    .package(url: "https://github.com/MartinLau7/SwiftOpenSSL", from: "1.1.1.201016")
]
```

**If you don't believe the XCFramework in the project, you can `git clone` and use the script to make a new build.**

> Swift modulemaps for libSSL and libcrypto.

## Import

Import as:
``` swift
import OpenSSL
```

## 


## Supported Swift version

This package supports Swift 5+ .
