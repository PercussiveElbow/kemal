require "./spec_helper"

describe "Config" do
  it "sets default port to 3000" do
    config = Kemal.config
    config.port.should eq 3000
  end

  it "sets default environment to development" do
    config = Kemal.config
    config.env.should eq "development"
  end

  it "sets environment to production" do
    config = Kemal.config
    config.env = "production"
    config.env.should eq "production"
  end

  it "sets host binding" do
    config = Kemal.config
    config.host_binding = "127.0.0.1"
    config.host_binding.should eq "127.0.0.1"
  end

  it "adds a custom handler" do
    config = Kemal.config
    config.add_handler CustomTestHandler.new
    config.handlers.size.should eq(5)
  end

  it "adds custom options" do
    config = Kemal.config
    ARGV.push("--test")
    ARGV.push("FOOBAR")
    $test_option = nil

    config.on_options = ->(parser : OptionParser) {
      parser.on("--test TEST_OPTION", "Test an option") do |opt|
        $test_option = opt
      end
    }
    Kemal::CLI.new
    $test_option.should eq("FOOBAR")
  end
end
