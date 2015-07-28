require "docker"

Docker.options = { read_timeout: 600, write_timeout: 600 }

describe "Dockerfile" do
  it "passes paperback check" do
    expect(ENV).to have_key("DOCKER_HOST"), "Set DOCKER_HOST before running specs."
    result = docker("check")

    expect(result).to eq "Checking Paperback dependencies...
Checking for LaTeX...         Found
Checking for Inconsolata...   Found
Checking for Open Sans...     Found
All dependencies satisfied.
"
  end

  def docker(cmd)
    container = Docker::Image.build_from_dir(".").run(cmd)
    output = []
    container.attach(stdout: true, stderr: true) do |_, chunk|
      output << chunk
    end
    container.wait["StatusCode"]
    output.join
  end
end
