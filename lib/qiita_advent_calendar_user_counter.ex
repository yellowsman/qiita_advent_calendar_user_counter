defmodule QiitaAdventCalendarUserCounter do
  import Meeseeks.CSS

  @spec run(Calendar.year()) :: map()
  def run(year \\ Date.utc_today().year) do
    body = request_body("https://qiita.com/advent-calendar/#{year}/elixir", 0)
           |> Meeseeks.parse()

    body
    |> Meeseeks.fetch_all(css(".css-1covvrn .css-15wswuq .css-h63oov"))
    |> elem(1)
    |> Enum.map(fn x -> Meeseeks.text(x) |> String.replace(" ","") end) 
    |> Enum.frequencies
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
