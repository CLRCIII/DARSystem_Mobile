# DAR System Mobile

A Flutter-based mobile application for creating, managing, and exporting Daily Activity Reports (DAR) in PDF format.

## Overview

The DAR System Mobile app allows users to:

- Create and manage daily activity reports
- Export reports as PDF documents
- Store reports locally on the device
- View activity logs and report history
- Manage user profiles and authentication

## Features

### Core Functionality

- **Report Creation**: Create new activity reports with start/end dates, activities, details, and remarks
- **PDF Export**: Generate and export reports as PDF files
- **Local Storage**: Save reports securely on device storage
- **Report Management**: View, edit, and organize saved reports

### User Management

- **Authentication**: Secure sign-in system
- **Profile Management**: Update user information and change passwords
- **Notifications**: Stay updated with system notifications

### Technical Features

- **Cross-Platform**: Works on Android and iOS devices
- **Offline Support**: Create and view reports without internet connection
- **File Sharing**: Share exported PDFs with other apps

## Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **PDF Generation**: pdf package
- **Printing**: printing package
- **File Management**: path_provider, open_file, share_plus
- **Storage**: shared_preferences for local data persistence

## Getting Started

### Prerequisites

- Flutter SDK (^3.11.1)
- Dart SDK (^3.11.1)
- Android Studio or Xcode (for mobile development)
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/CLRCIII/DARSystem_Mobile.git
   cd darsystem_mobile
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK:**

```bash
flutter build apk --release
```

**iOS (on macOS):**

```bash
flutter build ios --release
```

## Documentation

For detailed information about the DAR System Mobile:

- **[API Documentation](https://pub.dev/)**: External package documentation

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── constants/
│   └── app_colors.dart       # App color constants
├── models/
│   └── report_file.dart      # Data models for reports
├── pages/                    # UI screens
│   ├── dashboard_page.dart
│   ├── create_report_page.dart
│   └── ...
├── services/                 # Business logic
│   ├── report_file_service.dart
│   └── report_storage.dart
└── widgets/                  # Reusable UI components
    └── logo_container.dart
docs/                         # Documentation
├── architecture.md          # System architecture
└── user_guide.md           # User manual
```

## Key Components

### Models

- **ReportFile**: Represents a complete report with metadata and content
- **ReportRow**: Individual activity entries within a report

### Services

- **ReportFileService**: Handles PDF export and file operations
- **ReportStorage**: Manages local storage of reports

### Pages

- **Dashboard**: Main screen showing report overview
- **CreateReport**: Form for creating new reports
- **ActivityLogs**: View historical activities

## Dependencies

### Production Dependencies

- `pdf: ^3.10.8` - PDF document generation
- `printing: ^5.12.0` - Print and share documents
- `path_provider: ^2.1.3` - Find commonly used locations on filesystem
- `shared_preferences: ^2.2.2` - Persistent storage for simple data
- `open_file: ^3.3.2` - Open files with default applications
- `share_plus: ^7.2.1` - Share content to other apps

### Development Dependencies

- `flutter_test` - Flutter testing framework
- `flutter_lints` - Recommended linting rules

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is private and not intended for public distribution.

## Support

For support and questions, please contact the development team.
