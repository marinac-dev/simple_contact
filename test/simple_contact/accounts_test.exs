defmodule SimpleContact.AccountsTest do
  use SimpleContact.DataCase

  alias SimpleContact.Accounts

  describe "contacts" do
    alias SimpleContact.Accounts.Contact

    @valid_attrs %{address: "some address", name: "some name", phone_number: "some phone_number"}
    @update_attrs %{address: "some updated address", name: "some updated name", phone_number: "some updated phone_number"}
    @invalid_attrs %{address: nil, name: nil, phone_number: nil}

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Accounts.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Accounts.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = Accounts.create_contact(@valid_attrs)
      assert contact.address == "some address"
      assert contact.name == "some name"
      assert contact.phone_number == "some phone_number"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{} = contact} = Accounts.update_contact(contact, @update_attrs)
      assert contact.address == "some updated address"
      assert contact.name == "some updated name"
      assert contact.phone_number == "some updated phone_number"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_contact(contact, @invalid_attrs)
      assert contact == Accounts.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Accounts.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Accounts.change_contact(contact)
    end
  end
end
