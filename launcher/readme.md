# Standalone binaries for platforms

Create the following directory structure:
```
Gouda/
├── api/
│   └── gouda.exe    (your compiled Go API server)
├── frontend/
│   └── brie.exe     (your compiled Flutter Windows app)
└── launcher.exe      (compiled from main.go)
```

1. Create a new directory for your packaged application
2. Copy launcher.exe to the root of this directory
3. Create an api subdirectory and copy your compiled Go server there
4. Create a frontend subdirectory and copy your compiled Flutter Windows app there

### The launcher program will:

* Run the main gouda API server as a background process
* Launch the Flutter frontend
* Automatically terminate the API server when the Flutter app closes

## Attributions

<a href="https://www.flaticon.com/free-icons/gouda" title="gouda icons">Gouda icons created by Paul J. - Flaticon</a>
