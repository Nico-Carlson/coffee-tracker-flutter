# Coffee Tracker (Flutter)

A native Flutter application designed to track your current coffee stash, document roasting details, and log specific brew methods and tasting notes. This project serves as a migration and architectural upgrade from an earlier web-based PHP tracking application.

## Features
* **Coffee Stash Dashboard:** Keep track of the beans currently in your cupboard.
* **Detailed Profiles:** Log the roaster, roast level, processing method, and custom tasting notes.
* **Dynamic UI:** Clean, responsive grid layout featuring dynamic card accents based on roast level and subtle visual styling.
* **Local Persistence:** Data is currently saved directly to local device storage using JSON serialization for offline use.

## Development Roadmap
This project is being built iteratively:
1. **Phase 1 (Completed):** UI scaffolding, form state management, and local `shared_preferences` data retention.
2. **Phase 2:** Brew tracking implementation (Pour over, Moka pot, Espresso) linking specific parameters (grind, ratio, temp) to beans in the stash.
3. **Phase 3:** Migration to a robust local SQL/Hive database for advanced local querying and relational data mapping.
4. **Phase 4:** User authentication and cloud data synchronization.

## Getting Started

### Prerequisites
* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* Android Studio or VS Code

### Installation
1. Clone the repository:
   ```bash
   git clone [https://github.com/Nico-Carlson/coffee-tracker-flutter.git](https://github.com/Nico-Carlson/coffee-tracker-flutter.git)