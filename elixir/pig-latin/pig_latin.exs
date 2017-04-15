defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase |> String.split
    |> piggify([])
  end

  defp piggify([], coded), do: coded |> Enum.join(" ")
  defp piggify([head | tail], coded) do
    piggify(tail, coded ++ [pig_for(head)])
  end

  defp pig_for(word) do
    cond do
      Enum.member?(~w/squ sch thr/, String.slice(word,0,3)) -> code(:consonant, word, 3)
      Enum.member?(~w/ch qu th/, String.slice(word,0,2)) -> code(:consonant, word, 2)
      Enum.member?(~w/yt xr/, String.slice(word,0,2)) -> code(word)
      Enum.member?(~w/a e i o u/, String.slice(word,0,1)) -> code(word)
      true -> code(:consonant, word, 1)
    end
  end

  defp code(:consonant, word, i) do
    head = word |> String.slice(0,i)
    tail = word |> String.slice(i..-1)
    code(tail <> head)
  end

  defp code(word) do
    word <> "ay"
  end

end
