defmodule Condapi.Auth.Io.Repo.UserTest do
  use Condapi.DataCase, async: true

  alias Condapi.Auth.Io.Repo.User, as: Repo

  @moduletag :integration

  describe "insert/1" do
    test "with valid attrs" do
      attrs = %{
        username: "test",
        password: "abc123"
      }

      {:ok, user} = Repo.insert(attrs)

      assert user.username == "test"
      assert Bcrypt.verify_pass("abc123", user.password_hash)
    end

    test "with invalid attrs" do
      attrs = %{
        username: "",
        password: ""
      }

      {:error, changeset} = Repo.insert(attrs)

      assert errors_on(changeset).username == ["can't be blank"]
      assert errors_on(changeset).password == ["can't be blank"]
    end
  end

  describe "fetch_by/1" do
    test "gets user by username" do
      target = insert(:user, username: "test")

      {:ok, user} = Repo.fetch_by(username: "test")

      assert user.id == target.id
    end

    test "when user not exist" do
      assert {:error, :not_found} = Repo.fetch_by(username: "test")
    end
  end

  describe "fetch/1" do
    test "gets user by id" do
      target = insert(:user, username: "test")

      {:ok, user} = Repo.fetch(target.id)

      assert user.id == target.id
    end

    test "when user not exist" do
      assert {:error, :not_found} = Repo.fetch(999)
    end
  end
end
