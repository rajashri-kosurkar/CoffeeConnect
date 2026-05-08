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
