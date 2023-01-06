defmodule Condapi.Query do
  @moduledoc """
  Comportamento que define ações de um módulo de Queries
  """

  @callback root_query :: Ecto.Query.t()
end
