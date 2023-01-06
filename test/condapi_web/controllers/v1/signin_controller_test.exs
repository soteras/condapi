defmodule CondapiWeb.Controllers.V1.SigninControllerTest do
  use CondapiWeb.ConnCase, async: true

  @moduletag :integration

  describe "POST: /v1/signin" do
    setup do
      insert(:user, email: "test@gmail.com", password: "abc123")

      attrs = %{
        email: "TEST@gmail.com",
        password: "abc123"
      }

      %{attrs: attrs}
    end

    test "authenticate user and returns jwt token", %{attrs: attrs, conn: conn} do
      conn = post(conn, "/v1/signin", attrs)

      data = json_response(conn, 201)["data"]

      assert is_binary(data["token"])
    end

    test "when email is invalid", %{attrs: attrs, conn: conn} do
      conn = post(conn, "/v1/signin", %{attrs | email: "wrong_email@gmail.com"})

      data = json_response(conn, 401)["errors"]

      assert data["detail"] == "Email or Password are invalid"
    end

    test "when password is invalid", %{attrs: attrs, conn: conn} do
      conn = post(conn, "/v1/signin", %{attrs | password: "wrong"})

      data = json_response(conn, 401)["errors"]

      assert data["detail"] == "Email or Password are invalid"
    end
  end
end
