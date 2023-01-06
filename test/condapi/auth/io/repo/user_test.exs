defmodule Condapi.Auth.Io.Repo.UserTest do
  use Condapi.DataCase, async: true

  alias Condapi.Auth.Io.Repo.User, as: Repo

  @moduletag :integration

  describe "insert/1" do
    test "with valid attrs" do
      attrs = %{
        name: "User test",
        email: "test@gmail.com",
        password: "abc123"
      }

      {:ok, user} = Repo.insert(attrs)

      assert user.name == "User test"
      assert user.email == "test@gmail.com"
      assert is_binary(user.password_hash)
      assert Bcrypt.verify_pass("abc123", user.password_hash)
    end

    test "with invalid attrs" do
      attrs = %{
        name: "",
        email: "test",
        password: ""
      }

      {:error, changeset} = Repo.insert(attrs)

      assert errors_on(changeset).name == ["can't be blank"]
      assert errors_on(changeset).email == ["has invalid format"]
      assert errors_on(changeset).password == ["can't be blank"]
    end
  end

  describe "fetch_by/1" do
    test "gets user by email" do
      target = insert(:user, email: "test@gmail.com")

      {:ok, user} = Repo.fetch_by(email: "test@gmail.com")

      assert user.id == target.id
    end

    test "when user not exist" do
      assert {:error, :not_found} = Repo.fetch_by(email: "test@gmail.com")
    end
  end
end
