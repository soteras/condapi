defmodule Condapi.Auth.Models.User do
  @moduledoc false

  use Condapi, :model

  @required_fields ~w(name email password)a

  schema "users" do
    field :name, TrimmedString
    field :email, TrimmedString
    field :password, TrimmedString, virtual: true
    field :password_hash, TrimmedString

    timestamps()
  end

  @spec changeset(%__MODULE__{}, map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = model, params) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 2)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> maybe_put_pass_hash()
  end

  defp maybe_put_pass_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    hash = Bcrypt.hash_pwd_salt(password)
    put_change(changeset, :password_hash, hash)
  end

  defp maybe_put_pass_hash(changeset), do: changeset
end
