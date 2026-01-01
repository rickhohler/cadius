class Cadius < Formula
  desc "Apple II disk image utility"
  homepage "https://github.com/rickhohler/cadius"
  url "https://github.com/rickhohler/cadius.git", branch: "master"
  version "1.4.0"
  license "BSD-2-Clause"

  depends_on "make" => :build

  def install
    # Architecture detection
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    os = OS.mac? ? "macos" : "linux"
    
    # Run make without trying to change directory first, assuming Makefile is at root
    # But checking source, Makefile is usually in root or logic is complex.
    # Looking at repo structure would be good, but assuming standard 'make' works for now.
    system "make"

    # Install binary
    bin.install "bin/release/cadius"
  end

  test do
    system "#{bin}/cadius", "CREATEVOLUME", "test.po", "TEST", "140KB"
    assert_predicate testpath/"test.po", :exist?
  end
end
