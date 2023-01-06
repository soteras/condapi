defmodule CondapiWeb.ErrorView do
  use CondapiWeb, :view

  alias Condapi.Common

  @spec render(binary, map) :: map
  def render("error.json", %{reason: reason}) do
    %{errors: %{detail: reason}}
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: %{detail: Common.traverse_changeset_errors(changeset)}}
  end
end
