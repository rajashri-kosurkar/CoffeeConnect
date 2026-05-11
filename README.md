# Coffee Connect — iOS Application

A SwiftUI iOS application for browsing, discovering, and ordering coffee beans for **Coffee Connect**.

---

## How to Run

### Requirements
- Xcode 15.4 or later
- iOS 17.0+ deployment target
- No third-party dependencies — uses only native iOS SDK frameworks

### Steps
1. Open 'CoffeeConnect.xcodeproj' in Xcode
2. Select a simulator (iPhone 15 or later recommended) or your connected device
3. Press **⌘R** to build and run

> The 'AllTheBeans.json' file is bundled as a resource in the app target. Ensure it appears under **Build Phases → Copy Bundle Resources** in Xcode (it should automatically, as it is inside the 'Resources' group).

---

## Architecture & Technology Choices

### Pattern: MVVM with Protocol-Oriented Services

The app follows **MVVM** (Model–View–ViewModel), which maps cleanly onto SwiftUI's reactive data flow:

| Layer | Responsibility |
|---|---|
| **Models** ('CoffeeBean', 'Order') | Plain Swift structs; data & business logic only |
| **Services** ('CoffeeBeanService', 'OrderFormService') | Protocol-backed I/O; easily swapped for network implementations |
| **ViewModels** ('CoffeeBeanListViewModel', 'OrderFormViewModel') | '@Observable'; transform service data into view state |
| **Views** | SwiftUI declarative rendering; no business logic |

This separation means every layer can be tested in isolation. The Views know nothing about JSON or networking — they only interact with their ViewModel's properties.

---

### Key Design Decisions

#### 1. Protocol-Backed Services ('BeanServiceProtocol', 'OrderFormServiceProtocol')
Both service layers are expressed as protocols. This means:
- **Testability**: Unit tests inject 'MockBeanService' / 'MockOrderService' — no file I/O or network calls in tests
- **Scalability**: Replacing local JSON with a REST API requires only a new conforming class; no View or ViewModel changes needed
- **Security**: An API implementation would be the single place to add auth headers, TLS pinning, or certificate validation

#### 2. Local JSON Data ('AllTheBeans.json' bundled as a resource)
The scenario provides a static JSON file, so data is loaded from the app bundle via 'LocalBeanService'. The 'async throws' signature on 'fetchBeans()' means it is ready to be replaced with 'URLSession' without any call-site changes.

#### 3. '@MainActor' on ViewModels
Both ViewModels are marked '@MainActor' to ensure all property mutations happen on the main thread. This prevents data races that would otherwise require explicit 'DispatchQueue.main.async' calls.

#### 4. SwiftUI-Only, No Third-Party Libraries
As specified, only iOS SDK frameworks are used:
- **SwiftUI** for all UI
- **Foundation** for JSON decoding and async/await

No SPM packages, CocoaPods, or Carthage dependencies.

#### 5. 'ContentUnavailableView' for Empty/Error States
Uses 'ContentUnavailableView.search(text:)' (iOS 17+) for the empty search state — a platform-native component that respects accessibility and Dynamic Type automatically.

#### 6. Async Image Loading via 'AsyncImage'
Images are loaded using `AsyncImage` (native, iOS 15+), which handles caching, cancellation, and placeholder display without any additional dependencies.

---
