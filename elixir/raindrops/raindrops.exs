defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number), do: print_out([sound(number, 3), sound(number, 5), sound(number, 7)], number)

  defp sound(n, 3) when rem(n, 3) == 0, do: "Pling"
  defp sound(n, 5) when rem(n, 5) == 0, do: "Plang"
  defp sound(n, 7) when rem(n, 7) == 0, do: "Plong"
  defp sound(_, _), do: ""

  defp print_out(["","",""], number), do: number |> Integer.to_string
  defp print_out(sounds, _number), do: sounds |> Enum.join

end
