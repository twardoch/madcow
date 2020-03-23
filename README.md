# madcow

Mac ADd COmmands Wsomething: Very simple, stupid, private & opinionated "package manager" for CLI tools on my macOS

CLI tools on macOS come from different sources: brew, cargo, npm, pip 2 & 3, go etc.

I am tired of keeping track of where I got what. So I’ll have some premade lists of CLI commands, and sources where they come from.

Then I want to do

```
madcow i [spec] # install all in spec
madcow u [spec] # update all in spec
madcow c [spec] # clean all in spec
madcow d [spec] # delete all in spec
madcow m [spec] # make spec folder from packages installed on machine
madcow l # list all installed
madcow h # help
```

The `spec` is a simple folder that has text files for various installation technologies

It’s opinionated because the premade list of CLI commands is mostly for work with graphics and text, including fonts, SVG, PNG, PDF etc.

And it’s not sophisticated. Doesn’t super-smart resolve dependencies. If it fails, it fails.
