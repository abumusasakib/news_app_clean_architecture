# News App

A clean architecture-based news application built with Flutter, providing the latest news articles. The app features offline article saving, light and dark themes, and seamless navigation.

---

## Features

- **View Latest News**: Fetches news articles using the News API.
- **Detailed Article View**: Displays article details with an option to open in a browser.
- **Save Articles**: Save articles for offline reading.
- **Delete Saved Articles**: Remove articles from the saved list.
- **Light & Dark Mode**: User-friendly themes based on system preferences.
- **Responsive UI**: Designed for a smooth user experience on various devices.

---

## Architecture

The app follows the **Clean Architecture** principles:

### Layers

1. **Presentation**: Flutter UI with `Bloc` for state management.
2. **Domain**: Use cases and business logic.
3. **Data**: Repositories, mappers, and data sources (remote and local).

### Key Components

- **Cubit for State Management**: Handles both remote and local article data.
- **Retrofit for Networking**: Lightweight, type-safe HTTP client for API communication.
- **Floor for Local Storage**: Simple database to store bookmarked articles.
- **Dependency Injection with GetIt**: Centralized service locator for app dependencies.

---

## Screens

1. **Daily News**:
   - Displays a list of news articles fetched from the API.
   - Navigate to article details or bookmark an article.

2. **Article Detail**:
   - Showcases the article's full content with options to:
     - Share the article.
     - Open in a browser.
     - Save the article.

3. **Saved Articles**:
   - View and manage saved articles.
   - Delete saved articles.

---

## Setup and Installation

### Prerequisites

- **Flutter**: Install Flutter SDK (version >= 3.0.0).
- **FVM**: Install Flutter Version Manager.
- **Dart**: Ensure Dart is installed along with Flutter.

### Clone the Repository

```bash
git clone <git-repo>
cd news-app
```

### Install Dependencies

```bash
fvm install
```

```bash
fvm flutter pub get
```

```bash
fvm flutter pub run build_runner build -d
```

### API Key Configuration

1. Copy the provided `sample.env` file to a new file named `.env`:

   ```bash
   cp sample.env .env
   ```

2. Edit the `.env` file and replace `your_api_key_here` with your actual API key:

   ```text
   NEWS_API_BASE_URL=https://newsapi.org/v2
   NEWS_API_KEY=your_api_key_here
   COUNTRY_QUERY=us
   CATEGORY_QUERY=general
   ```

---

## Some of the Packages Used

- **State Management**: `flutter_bloc`
- **Networking**: `dio`, `retrofit`
- **Local Database**: `floor`
- **Routing**: `go_router`
- **UI**: `cached_network_image`, `share_plus`, `intl`
- **DI**: `get_it`

---

## Folder Structure Overview

```text
lib/
├── core/
│   ├── environment/
│   ├── error/
│   ├── resources/
│   └── usecase/
├── features/
│   ├── daily_news/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
└── injection_container.dart
```

---

## How It Works

1. **Fetching Articles**:
   - Uses `NewsApiService` (via Retrofit) to fetch articles from the News API.
   - Maps the JSON response to `ArticleModel` and then to `ArticleEntity` using mappers.

2. **Bookmarking Articles**:
   - Saves articles locally using `Floor` database.
   - `ArticleLocalEntity` is used for storing and retrieving data.

3. **State Management**:
   - `RemoteArticlesCubit`: Manages state for articles fetched from the API.
   - `LocalArticleCubit`: Handles locally saved articles.

4. **Routing**:
   - Uses `go_router` for declarative navigation between screens.

---

## Contribution

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch.
3. Commit your changes.
4. Open a pull request.

---

## Acknowledgments

- [News API](https://newsapi.org/) for providing the news data.
- Flutter community for amazing packages and support.
