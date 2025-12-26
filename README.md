# 💬 mysive Mini Chat Application

A professional-grade Flutter chat application built to demonstrate **Clean Architecture**, **State Management (BLoC)**, and **Local Persistence (Hive)**.

This project was developed as a comprehensive assignment submission, featuring a polished UI, real-time message simulation, and interactive "smart text" features.

---

## 📱 Features & Highlights

### Core Requirements
- **Complex UI Navigation:** Implemented a `NestedScrollView` with a `SliverAppBar` that collapses on scroll while keeping the Tab Bar pinned.
- **Custom Tab Switcher:** Designed a "Pill-shaped" tab indicator that centers dynamically based on content.
- **User Management:** Ability to add new users via a dialog, persisted locally.
- **Chat Interface:**
  - **Sender Messages:** Locally generated.
  - **Receiver Messages:** Simulated network replies fetched from the **Quotable API**.
  - **UI:** Distinct bubble designs and avatar alignments for sender vs. receiver.
- **Scroll Persistence:** Preserves scroll position between "Users" and "History" tabs using `PageStorageKey`.

### 🚀 Pro / Bonus Features
- **🏠 Local Storage (Hive):** Users and Chat History are persisted on-device. Data survives app restarts.
- **📚 Interactive Dictionary:** **Long-press** any word in a chat bubble to:
  - 🟡 Highlight the word in yellow.
  - 📖 Fetch and display its definition via the **Free Dictionary API** in a bottom sheet.
- **💡 Feature Discovery:** A dismissible "Pro Tip" card appears when the first message is sent to educate users about the long-press feature.
- **🎨 Theming & Branding:** Custom Violet theme, consistent typography (Google Fonts), app icon, and native splash screen.
- **🛡️ Error Handling:** Graceful handling of API failures and network issues using **Dio**.

---

## 🛠️ Tech Stack & Architecture

The project follows a **Clean Architecture** principle, separating code into three distinct layers:

```text
lib/
├── core/             # Global configurations (Theme, Constants)
├── data/             # Data Layer (Hive Models, API Repositories)
├── logic/            # Business Logic (BLoC, Events, States)
└── presentation/     # UI Layer (Screens, Reusable Widgets)

Package,Purpose
flutter_bloc,State Management for predictable data flow.
hive,"Fast, NoSQL local database for persisting chat history."
dio,Robust HTTP client for API requests (Quotable & Dictionary).
equatable,Value equality for efficient BLoC state comparisons.
google_fonts,Professional typography (Poppins).
intl,Date and time formatting.

Here is the complete README.md file code, ready to be copied and pasted into your project.Markdown# 💬 Mini Chat Application

A professional-grade Flutter chat application built to demonstrate **Clean Architecture**, **State Management (BLoC)**, and **Local Persistence (Hive)**.

This project was developed as a comprehensive assignment submission, featuring a polished UI, real-time message simulation, and interactive "smart text" features.

---

## 📱 Features & Highlights

### Core Requirements
- **Complex UI Navigation:** Implemented a `NestedScrollView` with a `SliverAppBar` that collapses on scroll while keeping the Tab Bar pinned.
- **Custom Tab Switcher:** Designed a "Pill-shaped" tab indicator that centers dynamically based on content.
- **User Management:** Ability to add new users via a dialog, persisted locally.
- **Chat Interface:**
  - **Sender Messages:** Locally generated.
  - **Receiver Messages:** Simulated network replies fetched from the **Quotable API**.
  - **UI:** Distinct bubble designs and avatar alignments for sender vs. receiver.
- **Scroll Persistence:** Preserves scroll position between "Users" and "History" tabs using `PageStorageKey`.

### 🚀 Pro / Bonus Features
- **🏠 Local Storage (Hive):** Users and Chat History are persisted on-device. Data survives app restarts.
- **📚 Interactive Dictionary:** **Long-press** any word in a chat bubble to:
  - 🟡 Highlight the word in yellow.
  - 📖 Fetch and display its definition via the **Free Dictionary API** in a bottom sheet.
- **💡 Feature Discovery:** A dismissible "Pro Tip" card appears when the first message is sent to educate users about the long-press feature.
- **🎨 Theming & Branding:** Custom Violet theme, consistent typography (Google Fonts), app icon, and native splash screen.
- **🛡️ Error Handling:** Graceful handling of API failures and network issues using **Dio**.

---

## 🛠️ Tech Stack & Architecture

The project follows a **Clean Architecture** principle, separating code into three distinct layers:

```text
lib/
├── core/             # Global configurations (Theme, Constants)
├── data/             # Data Layer (Hive Models, API Repositories)
├── logic/            # Business Logic (BLoC, Events, States)
└── presentation/     # UI Layer (Screens, Reusable Widgets)

Key Packages UsedPackagePurposeflutter_blocState Management for predictable data flow.hiveFast, NoSQL local database for persisting chat history.dioRobust HTTP client for API requests (Quotable & Dictionary).equatableValue equality for efficient BLoC state comparisons.google_fontsProfessional typography (Poppins).intlDate and time formatting.🚀 Getting StartedFollow these steps to run the project locally.1. PrerequisitesEnsure you have the following installed:Flutter SDK (Latest Stable)Android Studio or VS Code2. Clone & InstallBash
# Clone the repository
git clone [https://github.com/yourusername/mini-chat-app.git](https://github.com/yourusername/mini-chat-app.git)

# Navigate to directory
cd mini-chat-app

# Install dependencies
flutter pub get
3. Generate Hive AdaptersSince this project uses Hive for local storage, you must generate the type adapters before running the app.Bash# Run the build runner
flutter pub run build_runner build --delete-conflicting-outputs
4. Run the AppBashflutter run



👨‍💻 Author
Jahid Khan Flutter Developer

neollm.tech