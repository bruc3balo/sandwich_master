# Form Ni Gani? (Which Form?) 📝

**Form Ni Gani** is a benchmark project designed to explore and compare various **Flutter State Management** patterns when applied to **complex, multi-field forms**. 

Managing state in large forms (with validation, dependent fields, and asynchronous data) is one of the most debated topics in Flutter development. This project implements the exact same complex form using different state providers to help developers decide which pattern fits their needs best.

## 🚀 The Mission

Build a robust, scalable, and maintainable form architecture that:
- Uses a **unified data source** (Repository/Local Storage).
- Decouples UI from business logic.
- Demonstrates handling of complex validation and inter-field dependencies.
- Showcases the "Developer Experience" (DX) of each state management solution.

## 🛠 State Management Implementations

Each implementation resides in its own module/feature directory, using the same underlying business logic but a different state provider:

| Provider | Description | Complexity |
| :--- | :--- | :--- |
| **BLoC (Business Logic Component)** | Event-driven, strict separation of concerns, highly testable. | High |
| **Riverpod** | Compile-safe, no context dependency, powerful dependency injection. | Medium-High |
| **Flutter Hooks** | Functional approach to state, reduces boilerplate for widget-local state. | Medium |
| **ChangeNotifier** | Built-in Flutter solution, easy to understand, great for simple to medium complexity. | Low-Medium |
| **ValueNotifier** | Lightweight, granular updates, perfect for high-performance UI components. | Low |

## 🏗 Architecture

The project follows a **Layered Architecture**:

1.  **Data Layer**: Repositories and models (Shared across all implementations).
2.  **Domain Layer**: Entities and business logic (Shared).
3.  **Presentation Layer**: 
    - **View Model / Controller**: Specific to the state management provider.
    - **View (UI)**: Identical layouts reacting to different state streams/notifiers.

## 🚦 Getting Started

### Prerequisites
- Flutter SDK (Latest Stable)
- Dart SDK

### Running a specific version
Each implementation is linked from the main dashboard. You can navigate to the specific implementation to see it in action.

```bash
flutter run
```

## 📊 Comparison Matrix

| Feature | BLoC | Riverpod | Hooks | ChangeNotifier | ValueNotifier |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Boilerplate | High | Medium | Low | Low | Very Low |
| Scalability | Excellent | Excellent | Good | Medium | Medium |
| Testability | Excellent | Excellent | Medium | Good | Good |
| Learning Curve | Steep | Medium | Medium | Easy | Easy |

## 📜 License
This project is open-source and available under the MIT License.

