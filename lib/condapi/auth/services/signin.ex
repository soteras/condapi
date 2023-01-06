defmodule Condapi.Auth.Services.Signin do
  @moduledoc """
  Service responsável por validar os dados de login e gerar um token JWT.
  """

  use Condapi, :application_service

  alias Condapi.Auth.Guardian
  alias Condapi.Auth.Io.Repo.User, as: UserRepo

  def process(%{email: email, password: password}) do
    with {:ok, user} <- UserRepo.fetch_by(email: String.downcase(email)),
         true <- Bcrypt.verify_pass(password, user.password_hash),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: token}}
    else
      _error ->
        {:error, :invalid_email_or_password}
    end
  end
end
