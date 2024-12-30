# Standalone binaries for platforms

Here's a step-by-step guide to package your Go API server and Flutter Windows frontend:

Create the following directory structure:
```
CopyYourApp/
├── api/
│   └── server.exe    (your compiled Go API server)
├── frontend/
│   └── myapp.exe     (your compiled Flutter Windows app)
└── launcher.exe      (compiled from main.go above)
```

Compile your Go API server:

bashCopycd path/to/your/api
go build -o server.exe

Build your Flutter Windows app:

bashCopycd path/to/your/flutter/app
flutter build windows

Compile the launcher program I provided:

bashCopygo build -o launcher.exe main.go

Create the final package:


Create a new directory for your packaged application
Copy launcher.exe to the root of this directory
Create an api subdirectory and copy your compiled Go server there
Create a frontend subdirectory and copy your compiled Flutter Windows app there

The launcher program will:

Run your Go API server as a background process
Launch the Flutter Windows frontend
Automatically terminate the API server when the Flutter app closes

