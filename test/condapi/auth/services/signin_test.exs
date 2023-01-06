defmodule Condapi.Auth.Services.SigninTest do
  use Condapi.DataCase, async: true

  alias Condapi.Auth.Guardian
  alias Condapi.Auth.Services.Signin, as: Service

  describe "process/1" do
    setup do
      user = insert(:user, email: "test@gmail.com", password: "abc123")

      attrs = %{
        email: "test@gmail.com",
        password: "abc123"
      }

      %{attrs: attrs, user: user}
    end

    test "when email and password are valid", %{attrs: attrs, user: user} do
      {:ok, %{token: token}} = Service.process(attrs)

      {:ok, %{"sub" => sub, "iss" => iss}} = Guardian.decode_and_verify(token)

      assert sub == to_string(user.id)
      assert iss == "condapi"
    end

    test "when email is invalid", %{attrs: attrs} do
      attrs = %{attrs | email: "wrong_email@gmail.com"}

      assert {:error, :invalid_email_or_password} == Service.process(attrs)
    end

    test "when password is invalid", %{attrs: attrs} do
      attrs = %{attrs | password: "wrong"}

      assert {:error, :invalid_email_or_password} == Service.process(attrs)
    end
  end
end
