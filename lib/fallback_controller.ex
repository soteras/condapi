defmodule CondapiWeb.FallbackController do
  @moduledoc false
  use CondapiWeb, :controller

  alias CondapiWeb.ErrorView

  @type conn :: Plug.Conn.t()

  @spec call(conn, any) :: conn
  def call(conn, nil) do
    call(conn, {:error, :not_found})
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, %Ecto.Changeset{} = changeset) do
    call(conn, {:error, changeset})
  end

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(:forbidden)
    |> put_view(ErrorView)
    |> render("error.json", reason: gettext("Access Denied"))
  end

  def call(conn, {:error, :invalid_email_or_password}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render("error.json", reason: gettext("Email or Password are invalid"))
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("error.json", reason: gettext("The item you requested doesn't exist"))
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
