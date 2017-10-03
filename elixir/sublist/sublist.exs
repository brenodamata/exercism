defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b             -> :equal
      a |> sublist_of?(b) -> :sublist
      b |> sublist_of?(a) -> :superlist
      true                -> :unequal
    end
  end

  defp sublist_of?([], _), do: true
  defp sublist_of?(_, []), do: false
  defp sublist_of?(a, b) when length(a) > length(b), do: false

  defp sublist_of?(a = [ah | at], [bh | bt]) do
    if ah === bh and matches(at, bt) do
      true
    else
      a |> sublist_of?(bt)
    end
  end

  defp matches([], _), do: true
  defp matches(_, []), do: false
  defp matches([ah | at], [bh | bt]) do
    if ah === bh do
      matches(at, bt)
    else
      false
    end
  end
end
