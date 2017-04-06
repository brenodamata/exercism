defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
    keep_this(list, fun, [])
  end

  defp keep_this([], fun, result), do: result
  defp keep_this([h | t], fun, result) do
    case apply(fun, [h]) do
      true -> keep_this(t, fun, result ++ [h])
      _ -> keep_this(t, fun, result)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    discard_this(list, fun, [])
  end

  defp discard_this([], fun, result), do: result
  defp discard_this([h | t], fun, result) do
    case apply(fun, [h]) do
      false -> discard_this(t, fun, result ++ [h])
      _ -> discard_this(t, fun, result)
    end
  end
end

