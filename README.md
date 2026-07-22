# 📚 The Best Books App

An interactive English learning mobile application for children built with **Flutter**, designed with an offline-first architecture for seamless learning without internet connectivity.

---

## ✨ Key Features

* 🎨 **Dynamic Color-Theming**: Automatic card background and text contrast calculation for high accessibility.
* 📖 **Structured Curriculum**: Fast content loading powered by local JSON data models (`BookModel`, `UnitModel`, `PageModel`, `ItemModel`).
* ⚡ **Offline-First**: Complete offline access to books and units without network dependency.
* 📱 **Modern UI**: Clean layout with custom components (`UnitCard`) and smooth navigation between screens.

---

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **Data Source:** Local JSON & Assets (`assets/curriculum.json`)
* **Architecture:** Layered Architecture (Models, Screens, Services, Widgets, Utils)

---

## 📁 Project Structure

```text
lib/
├── models/                  # Data models (Book, Unit, Page, Item)
│   ├── book_model.dart
│   ├── item_model.dart
│   ├── page_model.dart
│   └── unit_model.dart
├── screens/                 # Application screens
│   ├── home_screen.dart
│   ├── intro_screen.dart
│   ├── lesson_screen.dart
│   └── units_screen.dart
├── services/                # Local data handling
│   └── local_data_service.dart
├── utils/                   # Helper tools & extensions
│   └── string_extensions.dart
├── widgets/                 # Reusable UI components
│   └── unit_card.dart
└── main.dart                # App entry point
