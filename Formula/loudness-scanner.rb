class LoudnessScanner < Formula
  desc "A tool that scans your music files and tags them with loudness information."
  homepage "https://github.com/jiixyj/loudness-scanner"
  head "https://github.com/jiixyj/loudness-scanner.git"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "taglib"
  depends_on "ffmpeg"

  def install
    mkdir "build"
    cd "build" do
      disable_args = [
        "SNDFILE",
        "MPG123",
        "MPCDEC",
        "GSTREAMER",
        "RSVG2",
        "GTK2",
        "QT4",
        "QT5"
      ].map {|item| "-DDISABLE_%s=ON" % item}
      system "cmake", "..", *std_cmake_args, *disable_args
      system "make", "install"
      lib_files = [
        "libfiletree.a",
        "libinput.a",
        "libinput_ffmpeg.so",
        "libscanner-common.a",
        "libscanner-lib.a",
        "libscanner-tag.a"
      ]
      for f in lib_files do
        mv f, lib/f
      end
      mkdir_p bin
      mv "loudness", bin
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test loudness-scanner`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
