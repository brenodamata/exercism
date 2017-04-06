defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count(strand, nucleotide, 0)
  end

  # defp count([head | tail], nucleotide, acc) when nucleotide == head do
  defp count([nucleotide | tail], nucleotide, acc) do
    count(tail, nucleotide, acc + 1)
  end

  defp count([_|tail], nucleotide, acc) do
    count(tail, nucleotide, acc)
  end

  defp count([], nucleotide, acc) do
    acc
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    initial_histogram = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    histogram(strand, initial_histogram)
  end

  defp histogram([head | tail], acc) do
    histogram(tail, %{acc | head => Map.get(acc, head) + 1})
  end

  defp histogram([], acc) do
    acc
  end
end
