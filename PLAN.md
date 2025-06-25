# Madcow Streamlining & MVP Development Plan

This document outlines the plan to streamline the `madcow` codebase and develop a Minimum Viable Product (MVP) focused on core functionality.

## 1. Initial Setup and Analysis (Completed)

*   Generate `llms.txt` if it doesn't exist.
*   Read and analyze `llms.txt` to understand the current codebase structure and functionality.
*   Identify areas for streamlining, removing redundancy, and focusing on MVP features.

## 2. Create Planning Documents (`PLAN.md`, `TODO.md`, `CHANGELOG.md`) (Current)

*   Create `PLAN.md`: This document.
*   Create `TODO.md`: A simplified checklist version of this plan.
*   Create `CHANGELOG.md`: To track all changes made. Initialize it.

## 3. Refactor Installation and Update Mechanism

*   **Goal:** Simplify the self-installation and self-update process.
*   **Modify `madcow_install.command`:**
    *   It should download `madcowlib` and a new main `madcow` executable script (which will parse commands) to `$HOME/.madcow/bin`.
    *   It should ensure `$HOME/.madcow/bin` is in the user's PATH or provide clear instructions to the user on how to add it.
*   **Remove `madcow/bin/madcow_update.command`:** Its functionality for self-update will be deferred post-MVP. For MVP, re-running the installer will serve as the "update" mechanism for `madcow` itself.
*   The directory structure within `$HOME/.madcow` should be considered, e.g., `$HOME/.madcow/bin` for scripts, `$HOME/.madcow/lib` for libraries if `madcowlib` isn't directly sourced or embedded. For simplicity, keeping `madcowlib` in `bin` and sourcing it is fine for MVP.

## 4. Develop the Main `madcow` Executable Script

*   Create a new script `madcow/bin/madcow` (this will be the main entry point for the user).
*   This script will:
    *   Parse command-line arguments for MVP commands: `install [spec_file]`, `list`, `help`.
        *   Use a simple `case` statement or basic `if/elif/else` for argument parsing.
    *   Source `$HOME/.madcow/bin/madcowlib` for helper functions.
    *   **Implement `help` command:**
        *   Display usage instructions for the supported MVP commands and spec file format.
    *   **Implement `list` command:**
        *   For MVP, this command could list the tools specified in a given spec file, or list available spec files in a predefined directory (e.g., `~/.madcow/specs/`). A more advanced version would list actually *managed* packages, but this requires state tracking, which is post-MVP.
    *   **Implement `install` command:**
        *   Define a simple structure for "spec" files. For MVP, a single default spec file can be used, e.g., `~/.madcow/default.spec`.
        *   A spec file will list packages, one per line, with a prefix indicating the type (e.g., `brew:package_name`, `npm:package_name`, `pip3:package_name`, `go:github.com/user/repo`, `rust:crate_name`).
        *   The `install` command will:
            *   Read the specified (or default) spec file.
            *   Parse each line to determine the type and package name.
            *   Call the appropriate installer function from `madcowlib`.
            *   Provide clear feedback for each attempted installation.

## 5. Refactor `madcowlib`

*   **Location:** This library will reside in `$HOME/.madcow/bin/madcowlib` (or `$HOME/.madcow/lib/madcowlib` if preferred, adjust installer and main script). For MVP, `$HOME/.madcow/bin/madcowlib` is fine.
*   Remove the commented-out `install` function and any other dead or example code (e.g., the bash regex snippet at the end).
*   Review the `uncomment` function:
    *   If it's useful for parsing spec files (e.g., to allow comments in them), keep it and integrate it.
    *   Otherwise, if not used by the MVP, remove it.
*   **Homebrew Permissions (`pkgbrew` function):**
    *   Remove the automatic `sudo chown` logic.
    *   If Homebrew permission issues are detected (e.g., by a command failing in a way that suggests permissions), `madcow` should advise the user to run `brew doctor` or check their Homebrew setup, rather than attempting to modify permissions itself. This is safer and respects Homebrew's management.
*   **Python 2 Support:**
    *   Remove `needbrewpy2` and `needpy2` functions. The MVP will focus on Python 3 support (`needbrewpy3`, `needpy3`). This simplifies the codebase.
*   Ensure all active helper functions (`needbrew`, `needpy3`, `needgo`, `needrust`, `neednode`, and their sub-components like `pkgbrew`, `insbrew`) are robust.
    *   Improve error handling: functions should return status codes or clear messages that the main `madcow` script can use to inform the user.
    *   Standardize output messages (using `pp`, `pins`, `pok`, `perr`, `pwarn`).
*   Add a header to `madcowlib` explaining its purpose and that it's meant to be sourced.

## 6. Documentation and Cleanup

*   Update `README.md` in the repository to:
    *   Reflect the actual MVP functionality and commands (`install`, `list`, `help`).
    *   Explain the spec file format and its expected location (e.g., `~/.madcow/default.spec` or user-provided path).
    *   Provide clear installation instructions (how to run `madcow_install.command`).
*   Ensure comments within the `madcow` script and `madcowlib` are clear, concise, and explain non-obvious logic.
*   Review `.gitignore`: It appears comprehensive, but a final check is good.

## 7. Testing (Manual for MVP)

*   Create a sample `default.spec` file with a mix of `brew`, `pip3`, `npm`, `go`, and `rust` packages.
*   Test `madcow install` using the sample spec file. Verify installations and outputs.
*   Test `madcow list` (based on its defined MVP functionality).
*   Test `madcow help`.
*   Test the `madcow_install.command` script on a clean environment (if possible) or after removing `$HOME/.madcow`.
*   Test edge cases:
    *   Empty spec file.
    *   Spec file with invalid lines.
    *   Trying to install a package that's already installed.
    *   Trying to install a non-existent package.

## 8. Post-MVP Considerations (Out of Scope for This Iteration)

*   `update` command for installed packages.
*   `uninstall`/`delete` command.
*   `clean` command.
*   `make spec` command (to generate a spec from currently installed tools).
*   More sophisticated spec file management (multiple specs, named specs).
*   State management (tracking what `madcow` has installed).
*   Automated tests.
*   Self-update mechanism for `madcow` itself (e.g., `madcow update-self`).

## Conservatism and Focus

*   Stick to the defined MVP features.
*   Prioritize simplicity and robustness for the core functionality.
*   Avoid premature optimization or feature creep.
*   Changes to `madcowlib` should primarily be about removing unused code, fixing the Homebrew permission issue, and ensuring the remaining functions are solid for the MVP's needs.
