# 💬 mysive Mini Chat Application

A professional-grade Flutter chat application built to demonstrate **Clean Architecture**, **State Management (BLoC)**, and **Local Persistence (Hive)**.

This project was developed as a comprehensive assignment submission, featuring a polished UI, real-time message simulation, and interactive **smart text** features.

---

## 📱 Features & Highlights

### ✅ Core Requirements

* **Complex UI Navigation**

  * `NestedScrollView` with a collapsible `SliverAppBar`
  * Tab bar remains pinned during scroll
* **Custom Tab Switcher**

  * Pill-shaped animated tab indicator
  * Dynamically centered based on tab width
* **User Management**

  * Add new users via dialog
  * Users persisted locally using Hive
* **Chat Interface**

  * **Sender messages:** Generated locally
  * **Receiver messages:** Simulated API replies using **Quotable API**
  * Distinct message bubbles and avatar alignment
* **Scroll Persistence**

  * Maintains scroll position between tabs using `PageStorageKey`

---

### 🚀 Pro / Bonus Features

* **🏠 Local Persistence (Hive)**

  * Users and chat history survive app restarts
* **📚 Interactive Dictionary**

  * Long-press any word in chat
  * Highlights selected word
  * Fetches definition from **Free Dictionary API**
  * Displays result in a bottom sheet
* **💡 Feature Discovery**

  * Dismissible “Pro Tip” card shown after first message
* **🎨 Theming & Branding**

  * Custom Violet theme
  * Google Fonts (Poppins)
  * App icon & native splash screen
* **🛡️ Error Handling**

  * Graceful API and network failure handling using **Dio**

---

## 🛠️ Tech Stack & Architecture

The app follows **Clean Architecture**, clearly separating concerns:

```text
lib/
├── core/             # Theme, constants, utilities
├── data/             # Hive models, API services, repositories
├── logic/            # BLoC, events, states
└── presentation/     # Screens & reusable UI widgets
```

### 📦 Key Packages Used

| Package      | Purpose                         |
| ------------ | ------------------------------- |
| flutter_bloc | Predictable state management    |
| hive         | Fast local NoSQL database       |
| dio          | HTTP client for APIs            |
| equatable    | Efficient BLoC state comparison |
| google_fonts | Professional typography         |
| intl         | Date & time formatting          |

---

## 🧪 Unit Testing

Unit tests validate **business logic, UI flow, and BLoC behavior** using Flutter’s testing framework.

### ✅ Covered Test Cases

#### 1️⃣ Initial UI Flow

* App launches with:

  * Empty user list
  * No selected chat
  * Correct initial BLoC state

```dart
test('Initial ChatState should be ChatInitial', () {
  final bloc = ChatBloc();
  expect(bloc.state, ChatInitial());
});
```

---

#### 2️⃣ Add User Flow

* Add User button:

  * Triggers BLoC event
  * Persists user in Hive
  * Updates UI list

```dart
blocTest<UserBloc, UserState>(
  'emits UserAdded when new user is added',
  build: () => UserBloc(fakeRepository),
  act: (bloc) => bloc.add(AddUserEvent('Jahid')),
  expect: () => [isA<UserAdded>()],
);
```

---

#### 3️⃣ Chat Message Flow (ChatBloc)

* Sending a message:

  * Adds sender message immediately
  * Fetches receiver reply from API
  * Emits updated chat state

```dart
blocTest<ChatBloc, ChatState>(
  'adds sender and receiver messages',
  build: () => ChatBloc(fakeChatRepository),
  act: (bloc) => bloc.add(SendMessageEvent('Hello')),
  expect: () => [
    isA<ChatMessageAdded>(),
    isA<ChatReplyReceived>(),
  ],
);
```

---

### 🧰 Testing Tools Used

| Tool         | Purpose                  |
| ------------ | ------------------------ |
| flutter_test | Core Flutter testing     |
| bloc_test    | Simplified BLoC testing  |
| mocktail     | Mock APIs & repositories |
| fake_async   | Async control            |

---

### ▶️ Run Tests

```bash
flutter test
```

---

## 🚀 Getting Started

### 1️⃣ Prerequisites

* Flutter SDK (Latest Stable)
* Android Studio or VS Code

---

### 2️⃣ Clone & Install

```bash
git clone https://github.com/JahidDev24/mysivi_assign.git
cd mysive_assign_main
flutter pub get
```

---

### 3️⃣ Generate Hive Adapters

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### 4️⃣ Run the App

```bash
flutter run
```

---

## 👨‍💻 Author

**Jahid Khan**
Flutter Developer

🌐 [https://neollm.tech](https://neollm.tech)
