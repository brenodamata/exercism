defmodule Bob do
  def hey(input) do
    cond do
       silence?(input) -> "Fine. Be that way!"
      question?(input) -> "Sure."
         shout?(input) -> "Whoa, chill out!"
                  true -> "Whatever."
    end
  end

  defp question?(input), do: String.ends_with?(input, "?")
  defp shout?(input), do: input == String.upcase(input) && letters?(input)
  defp silence?(input), do: String.strip(input) == ""
  defp letters?(input), do: Regex.match?(~r/\p{L}+/, input)
end
