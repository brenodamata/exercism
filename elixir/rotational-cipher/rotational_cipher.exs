defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text |> to_charlist |> rotate(rem(shift, 26), "")
  end

  defp rotate([head | tail], real_shift, acc) do
    code = get_code(head, real_shift)
    rotate(tail, real_shift, acc <> to_string([code]))
  end

  defp rotate([], _real_shift, acc) do
    acc
  end

  defp get_code(head, shift) do
    code = head

    if (head >= 65 && head <= 90) do
      code = head + shift
      if code > 90 do
        code = code - 26
      end
    end

    if (head >= 97 && head <= 122) do
      code = head + shift
      if code > 122 do
  	    code = code - 26
      end
    end

    code
  end

end
