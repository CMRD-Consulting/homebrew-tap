# CMRD Consulting — Homebrew tap

Casks for CMRD Consulting's macOS apps.

```bash
brew install cmrd-consulting/tap/ratify
```

`brew` expands `cmrd-consulting/tap` to this repository, so there is no
separate `brew tap` step — the first install adds it for you.

**Name the cask in full.** Since Homebrew 6, third-party taps must be trusted
before their casks will load, and `brew install` records that trust only for a
fully-qualified name. `brew tap` followed by a bare `brew install ratify` is
refused:

```
Error: Refusing to load cask cmrd-consulting/tap/ratify from untrusted tap
```

After the first install, `brew upgrade --cask ratify` works unqualified.

## What's in here

| Cask | | |
|---|---|---|
| `ratify` | Approve pull requests in three keystrokes — a macOS review inbox | [ratify.cmrd.dev](https://ratify.cmrd.dev) |

## Where the downloads come from

The casks point at [`CMRD-Consulting/ratify-releases`][releases], a public
repository that holds release tags and DMGs and nothing else. Ratify's source
is private, and Homebrew downloads over plain HTTPS with no credentials, so the
assets need a public home of their own.

## Not yet notarized

Ratify's DMG is not yet signed with an Apple Developer ID, so macOS quarantines
it on download. The cask says so on install and prints the one-time fix:

```bash
xattr -dr com.apple.quarantine "/Applications/Ratify.app"
```

Homebrew removed `--no-quarantine` in 6.0, so this step cannot be folded into
the install. It goes away when notarization lands.

## Updating

Casks here are written by the release script in the app's own repository rather
than by hand, so the version and the checksum always come from the DMG that was
actually built and uploaded.

[releases]: https://github.com/CMRD-Consulting/ratify-releases
