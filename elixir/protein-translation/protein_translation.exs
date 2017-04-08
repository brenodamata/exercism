defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    {response, head} = rna |> first_three |> of_codon
    tail = rna |> rest
    get_codons(response, head, tail, [])
  end

  defp get_codons(response, _head, _tail, _result) when response == :error, do: { :error, "invalid RNA" }
  defp get_codons(_response, head, _tail, result) when head == "STOP", do: { :ok, result }
  defp get_codons(_response, head, "", result), do: { :ok, result ++ [head] }
  defp get_codons(_response, head, tail, result) do
    {response, new_head} = tail |> first_three |> of_codon
    new_tail = tail |> rest
    get_codons(response, new_head, new_tail, result ++ [head])
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case codon do
      c when c in ["UCU", "UCC", "UCA", "UCG"] -> { :ok, "Serine" }
      c when c in ["UAA", "UAG", "UGA"]        -> { :ok, "STOP" }
      c when c in ["UAU", "UAC"]               -> { :ok, "Tyrosine" }
      c when c in ["UUU", "UUC"]               -> { :ok, "Phenylalanine" }
      c when c in ["UUA", "UUG"]               -> { :ok, "Leucine" }
      c when c in ["UGU", "UGC"]               -> { :ok, "Cysteine" }
      "UGG"                                    -> { :ok, "Tryptophan" }
      "AUG"                                    -> { :ok, "Methionine" }
      _                                        -> { :error, "invalid codon" }
    end
  end


  defp first_three(rna), do: rna |> String.slice(0..2)
  defp rest(rna), do: rna |> String.slice(3..-1)

end

