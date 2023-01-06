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

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  @spec template_not_found(binary, map) :: %{errors: any}
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
