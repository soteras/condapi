defmodule Condapi.ApplicationService do
  @moduledoc """
  Comportamento para application services
  """

  @callback process(map) :: :ok | {:ok, term} | {:error, term} | {:error, term, term}
end
