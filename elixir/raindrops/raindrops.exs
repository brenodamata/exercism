defmodule Raindrops do
  @factors %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    number |> convert(3, "")
  end

  defp convert(number, factor, ret) when factor > 7 do
    case String.length(ret) do
      0 -> number |> Integer.to_string
      _ -> ret
    end
  end
  defp convert(number, factor, ret) when rem(number, factor) != 0, do: convert(number, factor + 2, ret)
  defp convert(number, factor, ret), do: convert(number, factor + 2, (ret <> @factors[factor]))
end
