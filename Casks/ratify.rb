cask "ratify" do
  version "0.22.0"
  sha256 "adee3ce0b67fa1291de019dfb3fc78eb3631976628b2db69a07ddedb4be0215b"

  url "https://github.com/CMRD-Consulting/ratify-releases/releases/download/v#{version}/Ratify_#{version}_universal.dmg",
      verified: "github.com/CMRD-Consulting/ratify-releases/"
  name "Ratify"
  desc "Keyboard-driven pull request review inbox"
  homepage "https://ratify.cmrd.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # macOS, with no minimum. The app needs Big Sur (its minimumSystemVersion),
  # but Homebrew itself no longer runs on anything older, so its style check
  # (Homebrew/OSDependsOn) rejects the minimum as redundant — and a release
  # whose cask fails brew style stops before it publishes.
  depends_on :macos

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
end
