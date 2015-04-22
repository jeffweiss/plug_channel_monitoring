defmodule Plug.ChannelMonitoring do
  require Logger
  def init(opts), do: opts

  def call(conn, opts = [endpoint_module: module]) do
    before_time = :os.timestamp()

    conn
    |> Plug.Conn.register_before_send( fn conn ->
      after_time = :os.timestamp()
      diff = div(:timer.now_diff(after_time, before_time), 1000)
      timing_metric = metric_name(conn)
      {mega, sec, micro} = :erlang.now
      javascript_timestamp = mega * 1_000_000 * 1_000_000 + sec * 1_000_000 + micro
      payload = %{type: :timing, timestamp: javascript_timestamp, milliseconds: diff, metric: timing_metric}
      Logger.debug "Preparing to send telemetry payload: #{inspect payload}"
      apply(module, :broadcast, [timing_metric, "response_time", payload])
      conn
    end)
  end

  def metric_name(conn) do
    ["telemetry", "response", "timing", conn.method, conn.path_info]
    |> List.flatten
    |> Enum.join(":")
  end
end
