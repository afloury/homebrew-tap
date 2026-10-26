class Wherdr < Formula
  desc "Web app and phone PWA to drive the coding agents running in Herdr"
  homepage "https://wherdr.dev"
  url "https://github.com/afloury/wherdr/releases/download/v2.2.0/wherdr-2.2.0.tgz"
  sha256 "0e14a74a2b7a86a63356572afac3c60d032f52dafc73981f821e8c7b84aad540"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      wherdr needs Herdr (https://herdr.dev) running on this machine. Then:
        1. brew services start wherdr   # runs now and at every login
        2. wherdr open                  # setup guide in your browser
        3. Follow its Phone step to use wherdr from your phone.
    EOS
  end

  service do
    run [opt_bin/"wherdr", "run"]
    keep_alive true
    # launchd and systemd start services with a minimal PATH: Homebrew's bin folder
    # holds node (and herdr when installed with Homebrew); the server also looks
    # for herdr in ~/.local/bin (herdr.dev installer) and finds Herdr's socket
    # under $HOME, which both service managers set.
    environment_variables PATH: std_service_path_env
    log_path var/"log/wherdr.log"
    error_log_path var/"log/wherdr.log"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/wherdr --version").strip
  end
end
