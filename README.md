# madcow 🐮

**Madcow** (Mac ADd COmmands Wsomething) is a very simple, opinionated command-line tool to help manage CLI utilities on macOS. It allows you to define sets of tools from various sources (Homebrew, pip3, npm, Go, Rust) in a simple text file and install them.

It's designed for personal use, particularly for those who frequently set up new machines or want to maintain a consistent set of CLI tools.

## MVP Features

The current version is an MVP (Minimum Viable Product) and supports the following:

*   Installing tools from a "spec" file.
*   Listing tools defined in a spec file.
*   Fetching dependencies using:
    *   Homebrew (`brew`)
    *   Python 3's `pip` (`pip3`)
    *   Node.js Package Manager (`npm`)
    *   Go (`go install`)
    *   Rust's Cargo (`cargo install`)

## Installation

1.  **Run the installer:**
    Open your terminal and execute the following command:
    ```bash
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/twardoch/madcow/master/madcow_install.command)"
    ```
    This will download `madcow` and its library `madcowlib` to `$HOME/.madcow/bin/`.

2.  **Add to PATH:**
    The installer will prompt you to add `$HOME/.madcow/bin` to your shell's PATH. You can do this by adding the following line to your shell configuration file (e.g., `~/.zshrc`, `~/.bashrc`, `~/.bash_profile`, or `~/.config/fish/config.fish`):
    ```bash
    export PATH="$HOME/.madcow/bin:$PATH"
    ```
    Remember to restart your shell or source your configuration file (e.g., `source ~/.zshrc`) for the changes to take effect.

3.  **Verify Installation:**
    Once installed and your PATH is updated, you should be able to run:
    ```bash
    madcow help
    ```

## Usage

Madcow operates based on "spec" files. A spec file is a plain text file where each line defines a tool to be installed.

### Commands

*   `madcow help`
    Displays the help message, including available commands and spec file format.

*   `madcow list [spec_file_path]`
    Lists all the packages defined in the specified spec file.
    If `spec_file_path` is not provided, it defaults to `$HOME/.madcow/default.spec`.

*   `madcow install [spec_file_path]`
    Installs all packages defined in the specified spec file.
    If `spec_file_path` is not provided, it defaults to `$HOME/.madcow/default.spec`.

### Spec File Format

A spec file is a simple text file. Each line should define one package using the following format:

`type:part1[:part2...][:partN]`

*   **`type`**: Specifies the installation method. Supported types are:
    *   `brew`: For Homebrew packages.
    *   `pip3`: For Python 3 packages via pip.
    *   `npm`: For Node.js packages via npm.
    *   `go`: For Go packages via `go install`.
    *   `rust`: For Rust crates via `cargo install`.
*   The parts after `type:` are processed by the main `madcow` script and passed to the respective functions in `madcowlib`.
    *   Generally, `part1` is the command to check for existence in PATH.
    *   `part2` (and subsequent parts) are package names or installation arguments.

**Comments:** Lines starting with `#` are ignored.

**Example `default.spec`:**

```spec
# Homebrew packages
# Format: brew:package_name (command to check is assumed to be package_name)
brew:htop
brew:jq
brew:ripgrep # Installs ripgrep, checks for command 'ripgrep'. `rg` is the actual command.
             # For brew, if pkg name and cmd name differ, madcow won't know unless you script around it
             # or this feature is enhanced. For now, it checks for 'ripgrep' command.

# Python 3 packages
# Format: pip3:command_to_check:package_name
pip3:virtualenvwrapper:virtualenvwrapper
pip3:ytdl:youtube-dl # checks for 'ytdl' command, installs 'youtube-dl' pip package

# Node.js packages
# Format: npm:command_to_check:package_name
npm:svgo:svgo
npm:prettier:prettier

# Go packages
# Format: go:command_to_check:go_package_path[@version] [additional_go_args]
go:points:github.com/borud/points@latest
go:png2svg:github.com/xyproto/png2svg/cmd/png2svg@latest

# Rust packages
# Format: rust:command_to_check:crate_name_or_cargo_install_args...
# For crates from crates.io:
rust:rg:ripgrep       # command 'rg' is provided by 'ripgrep' crate
rust:bat:bat          # command 'bat' is provided by 'bat' crate
# For git repositories:
rust:svg-halftone:--git:https://github.com/evestera/svg-halftone # command 'svg-halftone', installed via cargo --git
```

**How `madcow` parses spec lines:**

The `madcow` script parses the line `type:part1:part2:part3...` and generally passes arguments to `madcowlib` functions as follows:
*   `needbrew package_name` (derived from `brew:package_name`)
*   `needpy3 command_to_check package_name [other_args]` (derived from `pip3:command_to_check:package_name...`)
*   `neednode command_to_check package_name [other_args]` (derived from `npm:command_to_check:package_name...`)
*   `needgo command_to_check package_path [other_args]` (derived from `go:command_to_check:package_path...`)
*   `needrust command_to_check [cargo_install_args...]` (derived from `rust:command_to_check:arg1:arg2...`)

If only one component follows `type:` (e.g., `brew:htop`, `pip3:flake8`), it's typically used as both the command-to-check and the package name. For `go` and `rust`, providing the command to check is usually distinct from the full package path or installation arguments.

Refer to the `madcow help` output and the `madcowlib` functions for precise argument handling. The examples above illustrate common usage.

## Philosophy

*   **Simple & Stupid:** Not a full-fledged package manager. No complex dependency resolution. If something fails, it fails.
*   **Opinionated:** Designed around a specific workflow.
*   **Private:** Primarily for personal use, but shared if others find it useful.

## Future Ideas (Post-MVP)

*   `update` command: Update all tools managed by a spec file.
*   `uninstall` command: Remove tools defined in a spec.
*   `make spec`: Generate a spec file from currently installed tools (this is ambitious).
*   More sophisticated spec file management.
*   Self-update mechanism for `madcow` itself (`madcow update-self`).

## Contributing

This is a personal project, but suggestions or bug reports via GitHub Issues are welcome.

## License

MIT License - see [LICENSE](LICENSE) file.
