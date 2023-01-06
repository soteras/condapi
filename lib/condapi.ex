defmodule Condapi do
  @moduledoc """
  API pública do contexto de condapi que define o dominio e as regras de negócio.
  """

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def application_service do
    quote do
      @behaviour Condapi.ApplicationService
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def domain_service do
    quote do
      import Ecto.Changeset
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def model do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      alias Condapi.EctoTypes.TrimmedString

      @self __MODULE__
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def query do
    quote do
      import Ecto.Query

      @type query :: Ecto.Query.t()

      @behaviour Condapi.Query
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def repo do
    quote do
      @behaviour Condapi.Repo

      @type changeset :: Ecto.Changeset.t()
      @type query :: Ecto.Query.t()

      alias Condapi.Repo

      import Condapi.Repo, only: [fetch: 2, fetch_by: 2, fetch_one: 1]
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def schema do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      alias Condapi.EctoTypes.TrimmedString

      @type changeset :: Ecto.Changeset.t()

      @behaviour Condapi.EmbeddedSchema

      @primary_key false

      @spec maybe_apply_changes(changeset) :: {:ok, map} | {:error, changeset}
      def maybe_apply_changes(%Ecto.Changeset{} = changeset) do
        apply_action(changeset, :parse)
      end
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
