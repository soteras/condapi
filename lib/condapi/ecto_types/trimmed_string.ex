defmodule Condapi.EctoTypes.TrimmedString do
  @moduledoc """
  Novo type do ecto para limpar valores vazio no inicio e fim da string.
  """

  use Ecto.Type

  defdelegate cast(type, value), to: Ecto.Type
  defdelegate load(type, value), to: Ecto.Type
  defdelegate dump(type, value), to: Ecto.Type

  @impl Ecto.Type
  def type, do: :string

  @impl Ecto.Type
  def cast(binary) when is_binary(binary), do: {:ok, String.trim(binary)}
  def cast(other), do: cast(:string, other)

  @impl Ecto.Type
  def load(data), do: load(:string, data)

  @impl Ecto.Type
  def dump(data), do: dump(:string, data)
end
