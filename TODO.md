# Madcow MVP - TODO List

## Phase 1: Planning & Setup
- [x] Analyze existing codebase (`llms.txt`)
- [x] Create `PLAN.md` with detailed steps
- [x] Create `TODO.md` (this file)
- [x] Create and initialize `CHANGELOG.md`

## Phase 2: Core Refactoring & Development
- [x] **Refactor Installation (`madcow_install.command`)**
    - [x] Installer downloads `madcowlib` and new `madcow` script to `$HOME/.madcow/bin/`
    - [x] Installer advises on adding `$HOME/.madcow/bin` to PATH
    - [x] Remove old `madcow/bin/madcow_update.command`
- [x] **Develop Main `madcow` Executable (`madcow/bin/madcow`)**
    - [x] Implement basic command-line argument parsing (`install`, `list`, `help`)
    - [x] Source `$HOME/.madcow/bin/madcowlib`
    - [x] Implement `help` command
    - [x] Implement `list` command (e.g., list items in spec, or list spec files)
    - [x] Implement `install [spec_file]` command
        - [x] Define simple spec file format (e.g., `type:package_name`)
        - [x] Parse spec file
        - [x] Call `madcowlib` functions for installation
- [x] **Refactor `madcowlib` (`$HOME/.madcow/bin/madcowlib`)**
    - [x] Remove commented-out/dead code (old `install` fn, regex example)
    - [x] Evaluate and integrate or remove `uncomment` function (kept, not currently used by main script)
    - [x] Remove `sudo chown` from `pkgbrew`; advise `brew doctor` instead
    - [x] Remove Python 2 support functions (`needbrewpy2`, `needpy2`)
    - [x] Ensure robustness and clear output for all helper functions
    - [x] Add header comment to `madcowlib`

## Phase 3: Documentation & Testing
- [x] **Update Documentation**
    - [x] Update `README.md` for MVP features, spec format, installation
    - [x] Add/clarify comments in code (reviewed, deemed sufficient for MVP)
- [x] **Manual Testing**
    - [x] Create sample spec file (`test_spec_vX.spec`)
    - [x] Test `madcow install` (iteratively, covering different types and error conditions)
    - [x] Test `madcow list` (including non-existent spec file)
    - [x] Test `madcow help`
    - [x] Test `madcow_install.command` (logic reviewed, full execution deferred due to sandbox constraints but components tested via main script)
    - [x] Test edge cases (empty spec parts, invalid lines, already installed, non-existent packages, comment handling)

## Phase 4: Submission
- [ ] Commit changes
- [ ] Submit

## Post-MVP (Future Considerations)
- [ ] `update` command for installed packages
- [ ] `uninstall`/`delete` command
- [ ] `clean` command
- [ ] `make spec` command
- [ ] Advanced spec management
- [ ] State tracking
- [ ] Automated tests
- [ ] `madcow update-self` command
