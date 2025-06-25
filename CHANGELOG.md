# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial `PLAN.md` for MVP development and codebase streamlining.
- Initial `TODO.md` for tracking MVP tasks.
- Initial `CHANGELOG.md`.

### Changed
- Refactored `madcow_install.command`:
    - Now installs `madcow` and `madcowlib` to `$HOME/.madcow/bin/`.
    - Downloads scripts directly from the GitHub repository.
    - Provides instructions for adding `$HOME/.madcow/bin` to PATH.
    - Includes a placeholder for the main `madcow` script if not found in the repo.
- Removed `madcow/bin/madcow_update.command` as its functionality is simplified; re-running installer updates madcow.

### Added
- Created main executable script `madcow/bin/madcow`:
    - Sources `madcowlib`.
    - Implements `madcow help` command.
    - Implements `madcow list [spec_file]` command to display contents of a spec file.
    - Implements `madcow install [spec_file]` command to parse spec files and call installer functions from `madcowlib`.
    - Handles spec file format `type:package_spec` and comments.
    - Basic argument parsing and error handling.

### Changed
- Refactored `madcow/bin/madcowlib`:
    - Removed Python 2 support functions (`needbrewpy2`, `needpy2`).
    - Removed `sudo chown` logic from `pkgbrew`; now advises `brew doctor` for permission issues.
    - Modernized `needgo` to use `go install <pkg>@latest`.
    - Enhanced `needpy3` and `neednode` with more specific PATH advice if commands are not found after install.
    - Updated `insbrew` for non-interactive Homebrew installation.
    - Improved output formatting (color reset, stderr for warnings/errors, better message spacing).
    - Removed dead code (commented-out `install` function, example snippets).
    - Added header comment and initialization message.
    - Refined argument handling and error messages in helper functions.

### Changed
- Updated `README.md` to reflect MVP functionality:
    - New installation instructions.
    - Details on `install`, `list`, `help` commands.
    - Comprehensive explanation of the spec file format with examples for all supported types (`brew`, `pip3`, `npm`, `go`, `rust`).
    - Clarified how `madcow` parses spec lines and passes arguments to `madcowlib`.
    - Removed outdated command descriptions.

### Fixed
- Resolved parsing issues in `madcow/bin/madcow` for spec file lines:
    - Correctly handles `type:cmd:pkg` syntax for `brew`, `pip3`, `npm`, `go`, `rust`.
    - Ensures trailing comments on spec lines are removed before parsing.
    - Prevents duplication of `@latest` for Go package installations.
- Corrected Homebrew installation within `madcowlib` to properly detect and configure the Homebrew environment for the current script session, especially for Linuxbrew.
