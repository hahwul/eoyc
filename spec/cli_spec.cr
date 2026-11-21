require "spec"
require "json"

private def run_cli(args : Array(String), input : String = "")
  stdout = IO::Memory.new
  stderr = IO::Memory.new
  status = Process.run(
    "crystal",
    ["run", "src/eoyc.cr", "--"] + args,
    input: IO::Memory.new(input),
    output: stdout,
    error: stderr
  )

  {status: status.exit_code, stdout: stdout.to_s, stderr: stderr.to_s}
end

describe "eoyc CLI" do
  it "fails for unknown encoders" do
    result = run_cli(["-e", "missing"], "hello\n")

    result[:status].should eq(1)
    result[:stdout].should eq("")
    result[:stderr].should contain("ERROR: unknown encoder: missing")
  end

  it "fails cleanly for invalid regex patterns" do
    result = run_cli(["-r", "[", "-e", "base64"], "hello\n")

    result[:status].should eq(1)
    result[:stdout].should eq("")
    result[:stderr].should contain("ERROR: invalid regex '['")
  end

  it "does not create the output file when regex validation fails" do
    path = File.join(Dir.tempdir, "eoyc-invalid-regex-#{Process.pid}.txt")

    begin
      result = run_cli(["-r", "[", "-e", "base64", "-o", path], "hello\n")

      result[:status].should eq(1)
      File.exists?(path).should be_false
    ensure
      File.delete(path) if File.exists?(path)
    end
  end

  it "writes JSON output to the requested output file" do
    path = File.join(Dir.tempdir, "eoyc-json-#{Process.pid}.json")

    begin
      result = run_cli(["-e", "base64", "--json", "-o", path], "hello\n")

      result[:status].should eq(0)
      result[:stdout].should eq("")
      File.read(path).strip.should eq(%({"input":["hello"],"encoders":["base64"],"output":["aGVsbG8="]}))
    ensure
      File.delete(path) if File.exists?(path)
    end
  end

  it "writes each stdin line before waiting for more input" do
    process = Process.new(
      "crystal",
      ["run", "src/eoyc.cr", "--", "--trim", "-e", "upcase"],
      input: Process::Redirect::Pipe,
      output: Process::Redirect::Pipe,
      error: Process::Redirect::Inherit
    )

    begin
      process.output.read_timeout = 30.seconds
      process.input.puts "hello  "
      process.input.flush
      process.output.gets.should eq("HELLO")
    ensure
      process.input.close
      status = process.wait
    end

    status.exit_code.should eq(0)
  end

  it "supports positional arguments as direct input (no pipe)" do
    result = run_cli(["-e", "base64", "hello"])

    result[:status].should eq(0)
    result[:stdout].should eq("aGVsbG8=\n")
  end

  it "supports multiple positional arguments as separate lines" do
    result = run_cli(["-e", "upcase", "foo", "bar"])

    result[:status].should eq(0)
    result[:stdout].should eq("FOO\nBAR\n")
  end

  it "positional arguments take precedence over stdin" do
    result = run_cli(["-e", "base64", "from-arg"], "from-stdin\n")

    result[:status].should eq(0)
    result[:stdout].should eq("ZnJvbS1hcmc=\n")
  end

  it "supports --trim to remove trailing whitespace from inputs (echo without -n case)" do
    # Simulate echo "hello" which adds a newline
    result = run_cli(["--trim", "-e", "sha256-hex"], "hello\n")

    # sha256 of "hello" (no trailing newline)
    expected = "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824\n"
    result[:status].should eq(0)
    result[:stdout].should eq(expected)
  end

  it "combines --trim with positional args and chains" do
    result = run_cli(["--trim", "-e", "base64>base64-decode", "hello  \n"])

    result[:status].should eq(0)
    result[:stdout].should eq("hello\n")
  end

  it "preserves whitespace in reversible transforms (no hidden strip in chain)" do
    # reverse on a string with trailing spaces should keep them
    result = run_cli(["-e", "reverse"], "ab  \n")

    result[:status].should eq(0)
    result[:stdout].should eq("  ba\n")
  end

  it "reports only the transformation applied to the regex-selected text" do
    result = run_cli(["--json", "--chain-info", "-r", "b=(same)", "-e", "upcase>reverse", "a=same b=same", "a=same"])
    data = JSON.parse(result[:stdout])

    result[:status].should eq(0)
    data["output"].should eq(JSON.parse(%(["a=same b=EMAS","a=same"])))
    expected_steps = JSON.parse(<<-JSON)
      [
        {"input":"a=same b=same","chain":[{"encoder":"upcase","output":"SAME"},{"encoder":"reverse","output":"EMAS"}]},
        {"input":"a=same","chain":[]}
      ]
      JSON
    data["steps"].should eq(expected_steps)
  end

  it "reports no chain steps for a missing literal substring" do
    result = run_cli(["--json", "--chain-info", "-s", "missing", "-e", "base64", "hello"])
    data = JSON.parse(result[:stdout])

    result[:status].should eq(0)
    data["output"].should eq(JSON.parse(%(["hello"])))
    data["steps"].should eq(JSON.parse(%([{"input":"hello","chain":[]}])))
  end
end
