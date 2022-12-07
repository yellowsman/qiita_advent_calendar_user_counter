defmodule QiitaAdventCalendarUserCounter do
  import Meeseeks.CSS

  @spec run(Calendar.year(), String.t()) :: map()
  def run(year \\ Date.utc_today().year, language \\ "elixir") do
    request_body("https://qiita.com/advent-calendar/#{year}/#{language}", 0)
    |> Meeseeks.parse()
    |> Meeseeks.fetch_all(css(".css-1covvrn .css-15wswuq .css-h63oov"))
    |> elem(1)
    |> Enum.map(fn x -> Meeseeks.text(x) |> String.replace(" ","") end) 
    |> Enum.frequencies
    |> Enum.sort
  end

  defp request_body(_, 10), do: "over retry challenge"
  defp request_body(target_url, retry_count) do
    result = HTTPoison.get!(target_url)

    case result.status_code do
      200 ->
        result.body

      _ ->
        :timer.sleep(1000)
        request_body(target_url, retry_count + 1)
    end
  end
end
