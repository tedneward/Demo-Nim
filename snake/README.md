# README

## Troubleshooting
The Snake binary might fail at startup because Nim's `sdl2` binding loads `libSDL2.dylib` by bare name at runtime. On this macOS system (Apple Silicon/Homebrew), that name is not found in the default dynamic-loader search path.

Reproduction:

```sh
./snake
# could not load: libSDL2.dylib
```

Confirmed root cause with:

```sh
nim c -d:nimDebugDlOpen -o:snake_dbg src/snake.nim
./snake_dbg
# dlopen(libSDL2.dylib, 0x0002): tried:
#   'libSDL2.dylib' (no such file),
#   '/System/Volumes/Preboot/Cryptexes/OSlibSDL2.dylib' (no such file),
#   '/usr/lib/libSDL2.dylib' (no such file, not in dyld cache),
#   'libSDL2.dylib' (no such file)
```

The library is installed correctly:

```sh
file /opt/homebrew/lib/libSDL2.dylib
otool -L /opt/homebrew/lib/libSDL2.dylib
sdl2-config --libs   # -L/opt/homebrew/lib -lSDL2main -lSDL2 ...
```

And loading works when the Homebrew library directory is supplied:

```sh
DYLD_LIBRARY_PATH=/opt/homebrew/lib ./snake
```

## Possible causes

1. **Homebrew prefix is not in the macOS loader search path.**
   `/opt/homebrew/lib` is not searched by default for a bare `libSDL2.dylib`.

2. **`DYLD_LIBRARY_PATH` is unset or stripped.**
   The variable may not be exported, or may be ignored in the launch context.

3. **Broken or unlinked Homebrew installation.**
   The `libSDL2.dylib` symlink may be missing or dangling after an upgrade.

4. **Architecture mismatch.**
   An `x86_64` library paired with an `arm64` binary, or vice versa, can fail to load.

5. **Launch-directory assumption failure.**
   The relative `libSDL2.dylib` lookup may fail when running the binary from another directory.

6. **Hardened runtime or library validation.**
   Stricter signing/security settings can reject third-party dylibs.

7. **Broken dependency chain.**
   The top-level dylib may exist, but one of its dependent dylibs may be missing or incompatible.

## Diagnostic commands

```sh
./snake
nim c -d:nimDebugDlOpen -o:snake_dbg src/snake.nim && ./snake_dbg
DYLD_PRINT_LIBRARIES=1 ./snake
DYLD_LIBRARY_PATH=/opt/homebrew/lib ./snake
file /opt/homebrew/lib/libSDL2.dylib
readlink -f /opt/homebrew/lib/libSDL2.dylib
lipo -info /opt/homebrew/lib/libSDL2.dylib
otool -L /opt/homebrew/lib/libSDL2.dylib
otool -D /opt/homebrew/lib/libSDL2.dylib
otool -l snake | grep -A2 -E 'LC_RPATH|LC_LOAD_DYLIB'
env | grep -i dyld
brew --prefix sdl2
brew list sdl2
brew doctor
sudo fs_usage -w -f filesys | grep -i libSDL2
```

## Remediation options

- For local development, export the Homebrew path:

  ```sh
  export DYLD_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_LIBRARY_PATH
  ```

- Run through a wrapper script that sets the variable.

- Bundle the needed SDL2 dylibs with the application and use an `@loader_path`/`@rpath`-relative load path.

- Link against a vendored or static SDL2 build instead of relying on a system/Homebrew runtime dylib.

- Avoid installing into `/usr/lib` or weakening macOS protections. Keep the fix scoped to the user environment or application bundle.
