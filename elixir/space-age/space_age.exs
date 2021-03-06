defmodule SpaceAge do
  @earth_year 31557600
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    get_age_on(planet, seconds)
  end

  # One way of solving is with methods and guard clauses:
#  defp get_age_on(:earth, seconds), do: seconds / @earth_year
#  defp get_age_on(:mercury, seconds), do: get_age_on(:earth, (seconds / 0.2408467))
#  defp get_age_on(:venus, seconds), do: get_age_on(:earth, (seconds / 0.61519726))
#  defp get_age_on(:mars, seconds), do: get_age_on(:earth, (seconds / 1.8808158))
#  defp get_age_on(:jupiter, seconds), do: get_age_on(:earth, (seconds / 11.862615))
#  defp get_age_on(:saturn, seconds), do: get_age_on(:earth, (seconds / 29.447498))
#  defp get_age_on(:uranus, seconds), do: get_age_on(:earth, (seconds / 84.016846))
#  defp get_age_on(:neptune, seconds), do: get_age_on(:earth, (seconds / 164.79132))

  # Another way is with case:
  defp get_age_on(planet, seconds) do
    period = case planet do
      :mercury -> 0.2408467
      :venus   -> 0.61519726
      :mars    -> 1.8808158
      :jupiter -> 11.862615
      :saturn  -> 29.447498
      :uranus  -> 84.016846
      :neptune -> 164.79132
      _ -> 1
    end

    seconds / period / @earth_year
  end
end
