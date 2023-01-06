defmodule Condapi.Auth.Io.Repo.User do
  @moduledoc """
  Repo com as funções para manipular a tabela `users`.
  """

  use Condapi, :repo

  alias Condapi.Auth.Models.User

  @impl true
  def insert(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @impl true
  def fetch_by(params) do
    fetch_by(User, params)
  end
end
