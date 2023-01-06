defmodule Condapi.Factory do
  # credo:disable-for-this-file Credo.Check.Readability.Specs

  @moduledoc """
  Re-exporta as factories da aplicação
  """
  use ExMachina.Ecto, repo: Condapi.Repo

  alias Condapi.Auth.Models.User

  def user_factory do
    %User{
      username: "test",
      password_hash: Bcrypt.hash_pwd_salt("abc123")
    }
  end
end
