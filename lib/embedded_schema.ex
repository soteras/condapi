defmodule Condapi.EmbeddedSchema do
  @moduledoc """
  Comportamento para definição de embedded schemas
  """

  @callback changeset(map) :: {:ok, map} | {:error, Ecto.Changeset.t()}
end
