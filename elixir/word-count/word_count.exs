defmodule Words do
  @punctiation ~r/!|"|\#|\$|%|&|'|\(|\)|\*|\+|,|\.|\/|:|;|<|=|>|\?|@|\[|\\|]|\^|_|`|\{|\||}|~/

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
      |> String.replace(@punctiation, " ")
      |> String.split
      |> count_words(%{})
  end

  defp count_words([], result), do: result
  defp count_words([h | t], result) do
    h = h |> String.downcase
    cond do
      result[h] == nil -> count_words(t, Map.put(result, h, 1))
      true -> count_words(t, %{result | h => result[h] + 1})
    end
  end
end
