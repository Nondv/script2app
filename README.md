# script2app

Creates OS X .app package from a script.

## Usage

Lets say we have script `HelloWorld.sh`:

```bash
#!/usr/bin/env bash
osascript -e 'display notification "Hello, World!" with title "Hey!"'
```

Now use script2app:

```
./script2app.rb HelloWorld.sh
```

Here we are. Now we have `HelloWorld.sh`:

```
open HelloWorld.app
```

Note that you don't have to make script executable. Script will do it for you.
