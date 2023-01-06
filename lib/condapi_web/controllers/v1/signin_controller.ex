defmodule CondapiWeb.Controllers.V1.SigninController do
  @moduledoc """
  Controller responsável por autenticar o usuário.
  """

  use CondapiWeb, :controller

  alias Condapi.Auth.Services.Signin, as: SigninService

  action_fallback CondapiWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, result} <- SigninService.process(%{email: email, password: password}) do
      render_response(result, conn, :created)
    end
  end
end
