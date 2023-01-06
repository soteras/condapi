defmodule Condapi.Auth.Services.SigninTest do
  use Condapi.DataCase, async: true

  alias Condapi.Auth.Guardian
  alias Condapi.Auth.Services.Signin, as: Service

  describe "process/1" do
    setup do
      user = insert(:user, username: "test", password: "abc123")

      attrs = %{
        username: "test",
        password: "abc123"
      }

      %{attrs: attrs, user: user}
    end

    test "when username and password are valid", %{attrs: attrs, user: user} do
      {:ok, %{token: token}} = Service.process(attrs)

      {:ok, %{"sub" => sub, "iss" => iss}} = Guardian.decode_and_verify(token)

      assert sub == to_string(user.id)
      assert iss == "condapi"
    end

    test "when username is invalid", %{attrs: attrs} do
      attrs = %{attrs | username: "wrong"}

      assert {:error, :invalid_username_or_password} == Service.process(attrs)
    end

    test "when password is invalid", %{attrs: attrs} do
      attrs = %{attrs | password: "wrong"}

      assert {:error, :invalid_username_or_password} == Service.process(attrs)
    end
  end
end
