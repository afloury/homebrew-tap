class Wherdr < Formula
  desc "Web app and phone PWA to drive the coding agents running in Herdr"
  homepage "https://wherdr.dev"
  url "https://registry.npmjs.org/wherdr/-/wherdr-1.3.0.tgz"
  sha256 "8be128bdeaadd673277363e896ac4cd3c96878d36515e1526403e8a434251ecc"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      wherdr needs Herdr (https://herdr.dev) running on this machine.
      Start it now and at every login:
        brew services start wherdr
      Then open http://localhost:7683 and follow the Phone step of the setup guide
      (or run: wherdr phone). Data lives in ~/wherdr/data.
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
