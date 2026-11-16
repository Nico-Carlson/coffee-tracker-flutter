# Coffee Tracker Devlog

Full history and step-by-step instructions. Paste THIS file into a new chat so a model has all the context.

## Goal

A Flutter-based application to track coffee beans, brew methods (pour over, moka pot, espresso), and tasting notes.
Modes: (1) Local dashboard for current coffee stash, (2) Brew logging, (3) Authenticated user accounts for cloud sync.

## Stack

- Framework: Flutter / Dart
- IDE: Android Studio
- Data: TBD (Local storage for phase 1, remote backend for phase 2)
- AI Integration: TBD

## Git conventions

- `main` always works; one descriptive branch per piece of work.
- Commit after each working step; merge to main (`--no-ff`) when a branch's goal is done.
- Tag each finished milestone before deleting any branch.

## Status

- [x] Flutter project initialized in Android Studio.
- [x] Git repository established.
- [x] UI for "Coffees" dashboard built matching reference design.
- [x] "Add a coffee" form implemented (Coffee, Roaster, Roast Level, Process, Notes).
- [x] Edit and Delete functionality integrated with state management, including delete confirmation.
- [x] Dynamic color-coding for coffee cards based on roast level.
- [x] Local data persistence using `shared_preferences` and JSON serialization.
- [x] Added visual flair: layered coffee stain image using a `Stack` widget.

## Architecture & Tech Debt

- **State Management:** Currently using ephemeral local state (`StatefulWidget`) for simplicity and rapid prototyping.
  - *Future Upgrade:* Migrate to Riverpod or Provider (industry standards for Flutter) when the app scales to include user authentication and cross-screen brew tracking.
- **Data Persistence:** Currently using in-memory mock data (ephemeral).
  - *Future Upgrade:* Integrate local storage (SQLite via `sqflite` or Hive) for offline persistence, eventually syncing with a remote backend (Firebase or a custom REST API) once user accounts are implemented.
- **UI/UX:** Solid border used on form due to missing native dashed border in Flutter.
  - *Future Upgrade:* Implement custom painter or use the `dotted_border` package to match original design.
- **Data Persistence:** Currently using `shared_preferences` to store JSON strings.
  - *Future Upgrade:* For complex queries (like searching by roast or sorting by brew count), migrate to a local SQLite database using `sqflite` or an object database like Hive before wiring up a remote backend.