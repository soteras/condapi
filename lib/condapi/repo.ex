defmodule Condapi.Repo do
  use Ecto.Repo,
    otp_app: :condapi,
    adapter: Ecto.Adapters.Postgres

  @type changeset :: Ecto.Changeset.t()
  @type query :: Ecto.Query.t()

  @callback all() :: list(struct)
  @callback delete(struct) :: {:ok, struct} | {:error, changeset}
  @callback fetch(integer) :: {:ok, struct} | {:error, changeset}
  @callback fetch_by(keyword) :: {:ok, struct} | {:error, changeset}
  @callback insert(map) :: {:ok, struct} | {:error, changeset}
  @callback insert_or_update(map) :: {:ok, struct} | {:error, changeset}
  @callback update(struct, map) :: {:ok, struct} | {:error, changeset}

  @optional_callbacks all: 0,
                      delete: 1,
                      fetch: 1,
                      fetch_by: 1,
                      insert: 1,
                      insert_or_update: 1,
                      update: 2

  @spec fetch(module | query, integer) :: {:ok, struct} | {:error, :not_found}
  def fetch(source, id) do
    fetch_by(source, id: id)
  end

  @spec fetch_by(module | query, keyword) :: {:ok, struct} | {:error, :not_found}
  def fetch_by(source, params) do
    case get_by(source, params) do
      nil -> {:error, :not_found}
      model -> {:ok, model}
    end
  end

  @spec fetch_one(module | query) :: {:ok, struct} | {:error, :not_found}
  def fetch_one(query) do
    case one(query) do
      nil -> {:error, :not_found}
      model -> {:ok, model}
    end
  end
end
