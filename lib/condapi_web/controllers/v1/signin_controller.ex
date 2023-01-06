defmodule CondapiWeb.Controllers.V1.SigninController do
  @moduledoc """
  Controller responsável por autenticar o usuário.
  """

  use CondapiWeb, :controller

  alias Condapi.Auth.Services.Signin, as: SigninService

  action_fallback CondapiWeb.FallbackController

  def create(conn, %{"username" => username, "password" => password}) do
    with {:ok, result} <- SigninService.process(%{username: username, password: password}) do
      render_response(result, conn, :created)
    end
  end
end
