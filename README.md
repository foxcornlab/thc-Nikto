# `thc-Nikto`

`web` `scanner` `misconfig-hunter`. the classic `Nikto` tree, kept alive and building under `Foxcorn Lab` as `valdenikto`.

> `fork` note: upstream is [`sullo/nikto`](https://github.com/sullo/nikto) — `GPLv2`, `Chris Sullo` and contributors. the engine, plugins and test databases below are upstream's and untouched. what changed here: `Foxcorn Lab` branding, and a half-done rebrand that shipped broken — fixed.

## `what` broke, `what` got fixed

the old fork renamed the binary to `valdenikto.pl` but never finished the rename, so the tool died on every launch. three fixes:

1. `config` lookup looked for `nikto.conf.default` while shipping `valdenikto.conf.default` → now resolves `valdenikto.conf*`
2. path-guessing regexes stripped `nikto.pl` from `$0`, never matching `valdenikto.pl` → config/plugins dirs now resolve
3. hardcoded `require ".../nikto_core.plugin"` and `NIKTODTD=docs/nikto.dtd` → point at the `valdenikto_*` names that actually ship

`perl -c` clean on the engine and core plugin. `boot` and `scan` verified: `valdenikto.pl -Version` boots, and a live scan against a local `http.server` completed end-to-end (`52 requests`, server banner picked up).

## `run` it

```shell
git clone https://github.com/foxcornlab/thc-Nikto
cd thc-Nikto/program
# Run using the shebang interpreter
./valdenikto.pl -h http://www.example.com
# Run using perl (if you forget to chmod)
perl valdenikto.pl -h http://www.example.com
```

`perl` with `LWP` needs to be around. `SSL` scans want `Net::SSLeay`. or take the lazy route:

```docker
docker build -t foxcornlab/thc-nikto .
docker run --rm foxcornlab/thc-nikto -h http://www.example.com
docker run --rm -v $(pwd):/tmp foxcornlab/thc-nikto -h http://www.example.com -o /tmp/out.json
```

## `usage`

`valdenikto -h` / `valdenikto -hh` prints the full flag dump. the short version:

```perl
Options:
-ask+               Whether to ask about submitting updates (yes/no/auto)
-Cgidirs+           Scan these CGI dirs: "none", "all", or values like "/cgi/ /cgi-a/"
-config+            Use this config file
-Display+           Turn on/off display outputs (redirects, cookies, 200s, auth, debug, errors, progress, scrub, verbose)
-dbcheck            Check database and other key files for syntax errors
-followredirects    Follow 3xx redirects to new location
-evasion+           Encoding technique (URI encoding, /./, case games, spacers, ...)
-Format+            Save file (-o) format: csv, htm, msf+, nbe, txt, xml
-Help               Extended help information
-host+              Target host
-IgnoreCode         Ignore codes, treat as negative responses
-id+                Host auth to use, format id:pass or id:pass:realm
-key+               Client certificate key file
-list-plugins       List all available plugins, perform no testing
-maxtime+           Maximum testing time per host
-mutate+            Guess additional file names (all-files, password files, ~user enum, subdomains, dirnames)
-mutate-options     Provide information for mutates
-nointeractive      Disables interactive features
-nolookup           Disables DNS lookups
-noslash            Strip trailing slash from URL
-nossl              Disables the use of SSL
-no404              Disables valdenikto attempting to guess a 404 page
-output+            Write output to this file ('.' for auto-name)
-Pause+             Pause between tests (seconds, integer or float)
-Plugins+           List of plugins to run (default: ALL)
-port+              Port to use (default 80)
-RSAcert+           Client certificate file
-root+              Prepend root value to all requests, format is /directory
-Save               Save positive responses to this directory ('.' for auto-name)
-ssl                Force ssl mode on port
-Tuning+            Scan tuning:
                    1     Interesting File / Seen in logs
                    2     Misconfiguration / Default File
                    3     Information Disclosure
                    4     Injection (XSS/Script/HTML)
                    5     Remote File Retrieval - Inside Web Root
                    6     Denial of Service
                    7     Remote File Retrieval - Server Wide
                    8     Command Execution / Remote Shell
                    9     SQL Injection
                    0     File Upload
                    a     Authentication Bypass
                    b     Software Identification
                    c     Remote Source Inclusion
                    x     Reverse Tuning Options
-timeout+           Timeout for requests (default 10 seconds)
-Userdbs            Load only user databases, not the standard databases
-until              Run until the specified time or duration
-update             Update databases and plugins from CIRT.net
-useproxy           Use the proxy defined in valdenikto.conf
-usecookies         Use cookies from responses in future requests
-Version            Print plugin and database versions
-vhost+             Virtual host (for Host header)
    + requires a value
```

## `Thanks to`

- > `Chris Sullo` (for making `nikto`)
- > upstream `nikto` contributors (engine, plugins, databases — all `GPLv2`)
- > `GangstaCrew` (organization)

## `legal` bits

this tool is for `authorized` testing and `education` only. the author cannot be held liable for anything done with it. scan your own stuff, or stuff you have `written permission` to poke.

`valdenikto` here is a fork of [`sullo/nikto`](https://github.com/sullo/nikto), licensed under `GPLv2` — see `licenses/COPYING`. fork packaging and docs `(c) Vineeth Kumar` (`Foxcorn Lab`).

> Research by `Vineeth Kumar` (`foxcornlab`). Found a bug or want a feature, open an `issue`.
