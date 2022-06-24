# Kill Proccesses #

## Motivation ##

For some reason, when I close some programs by interface with my Manjaro Gnome, it doesn't close all processes of the program and it keeps running on background.

**That's not a problem. Let's script.**

## First of all ##

Make sure you have ruby installed on your system...

## How I use ##

Add a simple alias in your **bashrc** or **zshrc**.
```sh
  alias kp="ruby path/to/kill_proccesses/caller.rb"
```

Then, call it wherever you want. On the exemple below, we are going to kill the slack and zoom processes.
```sh
  $ kp slack zoom
```

It should respond "Proccess {process_name} not found" if it's not found or not running.

It should respond "Proccess {process_name} killed" if it has successfully killed the process.

Some other outputs may be disconsidered.
