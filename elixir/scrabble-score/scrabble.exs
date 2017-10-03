defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.

  Letter                           Value
  A, E, I, O, U, L, N, R, S, T       1
  D, G                               2
  B, C, M, P                         3
  F, H, V, W, Y                      4
  K                                  5
  J, X                               8
  Q, Z                               10
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> String.replace(~r/\W/, "")
    |> String.codepoints
    |> Stream.map(&get_value(&1))
    |> Enum.sum
  end

  defp get_value letter do
    cond do
      ["F", "H", "V", "W", "Y"] |> Enum.member?(letter) -> 4
           ["B", "C", "M", "P"] |> Enum.member?(letter) -> 3
                     ["D", "G"] |> Enum.member?(letter) -> 2
                     ["J", "X"] |> Enum.member?(letter) -> 8
                     ["Q", "Z"] |> Enum.member?(letter) -> 10
                          ["K"] |> Enum.member?(letter) -> 5
                                                   true -> 1
    end
  end
end
