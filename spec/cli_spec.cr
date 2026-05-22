require "spec"

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
end
