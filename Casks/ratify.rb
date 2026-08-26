cask "ratify" do
  version "0.8.0"
  sha256 "e3b6fbc9ae50c3294a4aaf95b2baf3899e5caa4275f1144378086cda8af84eaf"

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
  # The co.crishell.* paths are the pre-rename bundle identifier. They stay
  # listed so an uninstall still clears data left by a version installed before
  # the move to dev.cmrd.ratify.
  #
  # Strictly alphabetical, which is why each directory's old id comes before
  # its new one rather than the other way round. Homebrew 6.0's
  # Cask/ArrayAlphabetization rule requires it, and brew style fails the
  # release otherwise; the readable pairing is not worth a hand-fixed cask.
  zap trash: [
    "~/Library/Application Support/co.crishell.ratify",
    "~/Library/Application Support/dev.cmrd.ratify",
    "~/Library/Caches/co.crishell.ratify",
    "~/Library/Caches/dev.cmrd.ratify",
    "~/Library/HTTPStorages/co.crishell.ratify",
    "~/Library/HTTPStorages/dev.cmrd.ratify",
    "~/Library/Preferences/co.crishell.ratify.plist",
    "~/Library/Preferences/dev.cmrd.ratify.plist",
    "~/Library/Saved Application State/co.crishell.ratify.savedState",
    "~/Library/Saved Application State/dev.cmrd.ratify.savedState",
    "~/Library/WebKit/co.crishell.ratify",
    "~/Library/WebKit/dev.cmrd.ratify",
  ]

  caveats <<~EOS
    Ratify is not yet notarized by Apple, so macOS quarantines it on download
    and refuses to open it. Clear the quarantine flag once, after installing:

      xattr -dr com.apple.quarantine "/Applications/Ratify.app"

    Homebrew removed `--no-quarantine` in 6.0, so there is no flag that does
    this for you. Notarization is coming; this line goes away when it lands.
  EOS
end
