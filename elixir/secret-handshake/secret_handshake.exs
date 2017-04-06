defmodule SecretHandshake do
  use Bitwise

  @codes ["wink", "double blink", "close your eyes", "jump"]

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when is_integer(code) do
    @codes
     |> Enum.with_index
     |> Enum.map( fn {c, i} -> {c, 2 <<< (i-1) } end)
     |> decode(code, [])
  end

  def commands(_code), do: raise ArgumentError, message: "Integers only, please" 

  defp decode([], code, result) do
    case check_bit(code, 16) do
      true -> result |> Enum.reverse
      _ -> result
    end
  end

  defp decode([{command, bit} | tail], code, result) do
    case check_bit(code, bit) do
      true -> decode(tail, code, result ++ [command])
      _ -> decode(tail, code, result)
    end
  end

  defp check_bit(code, bit), do: (code &&& bit) == bit

#  defp convert(code, result) when code == 1 or code == 0 do 
#    result ++ [code]
#  end
#
#  defp convert(code, result) do
#    new_bit = code |> rem(2)
#    convert(div(code,2), result ++ [new_bit])
#  end

end

