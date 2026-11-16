# Coffee Tracker Devlog

Full history and step-by-step instructions. Paste THIS file into a new chat so a model has all the context.

## Goal
A Flutter-based application to track coffee beans, brew methods (pour over, moka pot, espresso), and tasting notes.
Modes: (1) Local dashboard for current coffee stash, (2) Brew logging, (3) Authenticated user accounts for cloud sync.

## Stack
- Framework: Flutter / Dart
- IDE: Android Studio
- Data: Local storage (shared_preferences) for Phase 1, migrating to SQLite/Hive, then remote backend.
- AI Integration: AI pair-programming for UI construction, state management, and architecture planning.

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
- [x] AI integration defined and implemented for assignment requirements.

## Architecture & Tech Debt
- **State Management:** Currently using ephemeral local state (`StatefulWidget`) for simplicity and rapid prototyping.
  - *Future Upgrade:* Migrate to Riverpod or Provider (industry standards for Flutter) when the app scales to include user authentication and cross-screen brew tracking.
- **Data Persistence:** Currently using `shared_preferences` to store JSON strings.
  - *Future Upgrade:* For complex queries (like searching by roast or sorting by brew count), migrate to a local SQLite database using `sqflite` or an object database like Hive before wiring up a remote backend.
- **UI/UX:** Solid border used on form due to missing native dashed border in Flutter.
  - *Future Upgrade:* Implement custom painter or use the `dotted_border` package to match original design.

## How to work with me (Instructions for AI Assistants)
- ONE step at a time. Never give a long multi-step list; wait for my output before the next step.
- I type all code myself to learn it. Explain what each part does, briefly.
- Keep DEVLOG.md current: as progress is made, record relevant context and instructions here. It is the project's "second brain" so a new model or a new maintainer never has to rebuild context from scratch.

## Future Roadmap
- **Phase 1 (Current):** Establish local dashboard, state management, and basic UI.
- **Phase 2:** Brew Logging. Add a tracking screen to log brew parameters (grind size, water temp, ratio, time, method) associated with a specific coffee from the stash.
- **Phase 3:** Database integration. Migrate from `shared_preferences` to SQLite for robust local querying.
- **Phase 4:** Authentication & Cloud Sync. Implement user sign-in and sync data to a remote backend (e.g., Firebase) to replace the original PHP web app completely.