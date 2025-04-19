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

3. Additional: Run this line to sort imports
```bash
dart run import_sorter:main
```

## Limitations
1. No support for pusher yet
2. Code is not fully optimized yet
3. Custom icons are not used yet