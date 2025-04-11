# zhks

An app to manage ЖКс for residents.

## Getting Started

1. After cloning repository, add the following config files:

```bash
*.env
/firebase.json
/lib/core/config/firebase_options.dart
/android/app/google-services.json
```

2. Generate code

```bash
dart run build_runner build --delete-conflicting-outputs
```