defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> encode_regex
    |> encode_it([])
  end

  defp encode_it([], ret), do: ret |> Enum.join
  defp encode_it([[sequence | letter] | tail], ret) do
    addition = if String.length(sequence) == 1 do letter else "#{String.length(sequence)}#{letter}" end
    encode_it(tail, ret ++ [addition])
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> decode_regex
    |> decode_it([])
  end

  defp decode_it([], ret), do: ret |> Enum.join
  defp decode_it([[_, number, letter] | tail], ret) do
    times = if number == "" do 1 else String.to_integer(number) end
    decode_it(tail, ret ++ [String.duplicate(letter, times)])
  end

  defp encode_regex(str), do: Regex.scan(~r/([a-zA-Z\s])\1*/, str)
  defp decode_regex(str), do: Regex.scan(~r/(\d*)(.)/, str)

end
