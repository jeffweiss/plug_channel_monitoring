defmodule PlugChannelMonitoring.Mixfile do
  use Mix.Project

  @description """
    A plug for sending response timing to a Phoenix channel.
    Phoenix is not an explicit dependency, but is expected.
  """

  def project do
    [app: :plug_channel_monitoring,
     version: "0.0.1",
     elixir: "~> 1.0",
     name: "plug_channel_monitoring",
     description: @description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :plug, :phoenix]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [ {:plug, ">= 0.11.0"},
    ]
  end

  defp package do
    [ contributors: ["Jeff Weiss"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/jeffweiss/plug_channel_monitoring"}
    ]
  end
end
