# NetworkLogger

A lightweight, drop-in network debugging framework for iOS. Intercepts all HTTP/HTTPS traffic and displays requests and responses in a built-in UI

![iOS 16+](https://img.shields.io/badge/iOS-16%2B-blue)
![Swift 5.9](https://img.shields.io/badge/Swift-5.9-orange)
![SPM Compatible](https://img.shields.io/badge/SPM-Compatible-green)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

## Features

- **Automatic Interception** — Captures all `URLSession` traffic via `URLProtocol` swizzling. No manual instrumentation needed.
- **Shake to Open** — Shake your device to open the logger UI instantly.
- **Request List** — Browse all captured requests with color-coded status, method, duration, content type, and search/filter support.
- **Request Detail** — Inspect Overview, Request Headers/Body, and Response Headers/Body in a tabbed view.
- **Encrypted Response Support** — Attach decrypted response bodies from your app's decryption layer for display alongside the raw encrypted data.
- **Share & Copy** — Export requests as cURL commands, copy individual tabs, or share the full log.
- **Settings** — Configure logging behavior, filtering, body capture limits, appearance, and shake gesture toggle. All settings persist across launches.
- **Light / Dark Mode** — Choose between System, Light, or Dark theme for the logger UI. Does not affect your app's appearance.
- **Floating Search Bar** — iOS 26-style bottom floating search with keyboard-aware positioning.
- **Liquid Glass UI** — Buttons use `UIButton.Configuration.glass()` on iOS 26+ with graceful fallback.
- **iPad Support** — Optimized form sheet presentation on iPad, fullscreen on iPhone.


## Preview

![NetworkLogger Preview 2](https://github.com/user-attachments/assets/ccf2f0c8-4079-453c-9726-9b75a718b0b0)

## Installation

### Swift Package Manager

In Xcode:

1. Go to **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://github.com/way2dipak/NetworkLogger.git
   ```
3. Select version **1.0.0** or later
4. Add **NetworkLogger** to your target

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/way2dipak/NetworkLogger.git", from: "1.0.0")
]
```

Then add the dependency to your target:

```swift
.target(
    name: "YourApp",
    dependencies: ["NetworkLogger"]
)
```

## Quick Start

### 1. Start the Logger

In your `AppDelegate` or app entry point:

```swift
import NetworkLogger

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    NL.shared.start()
    return true
}
```

That's it. All `URLSession` traffic is now captured automatically.

### 2. Open the Logger UI

**Shake your device** to open the logger, or call it manually:

```swift
NL.shared.show()
```

### 3. Stop Logging (Optional)

```swift
NL.shared.stop()
```

## Encrypted Response Support

If your app uses encrypted API responses (e.g., an `enc_data` field), you can attach the decrypted body to the log entry so it displays alongside the raw response.

Call `logDecryptedResponse` after your app decrypts the response:

```swift
// In your network layer, after decrypting:
let decryptedJSON: [String: Any] = // ... your decrypted response

NL.shared.logDecryptedResponse(decryptedJSON, for: "/v1/movies/bulk")
```

The `for:` parameter is a URL substring — it matches against the most recent log entry whose URL contains that path.

The detail view will show both:
- **DECRYPTED BODY** — the decrypted content
- **RAW BODY (encrypted)** — the original encrypted response

### Encodable Models

You can also pass `Encodable` models directly:

```swift
NL.shared.logDecryptedResponse(myDecodedModel, for: endpoint.path)
```

## Settings

Access settings programmatically or through the built-in Settings screen (gear icon in the logger UI).

```swift
let settings = NL.Settings.shared

// Logging controls
settings.isLoggingEnabled = true       // Toggle logging on/off
settings.maxLogLimit = 500             // Max logs in memory (0 = unlimited)
settings.autoClearOnLaunch = false     // Clear logs on app launch

// Filtering
settings.ignoredDomains = ["analytics.google.com"]
settings.ignoredURLPatterns = ["/healthcheck"]
settings.logOnlyErrors = false         // Only capture 4xx/5xx responses

// Display
settings.captureRequestBody = true     // Capture request bodies
settings.captureResponseBody = true    // Capture response bodies
settings.bodySizeLimitKB = 0           // Truncate bodies (0 = no limit)

// Appearance
settings.appearance = .system          // .system, .light, or .dark

// Gesture
settings.isShakeEnabled = true         // Enable shake-to-open

// Reset
settings.resetToDefaults()
```

All settings persist in `UserDefaults` across app launches.

## API Reference

### NL

| Method | Description |
|--------|-------------|
| `start()` | Begin intercepting network traffic |
| `stop()` | Stop intercepting |
| `show()` | Present the logger UI manually |
| `logDecryptedResponse(_:for:)` | Attach decrypted body to a log entry |
| `removeAllLogs()` | Clear all captured logs |
| `getLogsCount()` | Get the number of captured logs |

### NL.Settings

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isLoggingEnabled` | `Bool` | `true` | Global logging toggle |
| `maxLogLimit` | `Int` | `500` | Max logs (0 = unlimited) |
| `autoClearOnLaunch` | `Bool` | `false` | Clear logs on `start()` |
| `ignoredDomains` | `[String]` | `[]` | Domains to skip |
| `ignoredURLPatterns` | `[String]` | `[]` | URL patterns to skip |
| `logOnlyErrors` | `Bool` | `false` | Only log 4xx/5xx |
| `captureRequestBody` | `Bool` | `true` | Store request bodies |
| `captureResponseBody` | `Bool` | `true` | Store response bodies |
| `bodySizeLimitKB` | `Int` | `0` | Truncation limit (0 = none) |
| `isShakeEnabled` | `Bool` | `true` | Shake gesture toggle |
| `appearance` | `Appearance` | `.system` | Logger UI theme (system/light/dark) |

## Requirements

- iOS 16.0+
- Swift 5.9+
- Xcode 15.0+

## License

NetworkLogger is available under the MIT license.

## Author

Made with ❤️ by [Dipak Singh](https://github.com/way2dipak)
