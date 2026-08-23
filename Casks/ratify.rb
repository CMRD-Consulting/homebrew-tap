cask "ratify" do
  version "0.1.0"
  sha256 "b2f5ca4988be78d68cced9a5c2c4042ba233500313d41fb4f86bf3b84f4624d6"

  url "https://github.com/CMRD-Consulting/ratify-releases/releases/download/v#{version}/Ratify_#{version}_universal.dmg",
      verified: "github.com/CMRD-Consulting/ratify-releases/"
  name "Ratify"
  desc "Keyboard-driven pull request review inbox"
  homepage "https://ratify.cmrd.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # A bare symbol is a minimum, not an exact match — Homebrew's own style rule
  # rewrites ">= :big_sur" to this. It matches the app's minimumSystemVersion.
  depends_on macos: :big_sur

  app "Ratify.app"

  # The GitHub token is deliberately not listed here. It lives in the login
  # Keychain, which zap cannot reach, and deleting someone's credential on an
  # uninstall would be a surprise either way. Ratify's own sign-out removes it.
  zap trash: [
    "~/Library/Application Support/co.crishell.ratify",
    "~/Library/Caches/co.crishell.ratify",
    "~/Library/HTTPStorages/co.crishell.ratify",
    "~/Library/Preferences/co.crishell.ratify.plist",
    "~/Library/Saved Application State/co.crishell.ratify.savedState",
    "~/Library/WebKit/co.crishell.ratify",
  ]

  caveats <<~EOS
    Ratify is not yet notarized by Apple, so macOS quarantines it on download
    and refuses to open it. Clear the quarantine flag once, after installing:

      xattr -dr com.apple.quarantine "/Applications/Ratify.app"

    Homebrew removed `--no-quarantine` in 6.0, so there is no flag that does
    this for you. Notarization is coming; this line goes away when it lands.
  EOS
end
