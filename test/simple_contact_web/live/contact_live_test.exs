defmodule SimpleContactWeb.ContactLiveTest do
  use SimpleContactWeb.ConnCase

  import Phoenix.LiveViewTest

  alias SimpleContact.Accounts

  @create_attrs %{address: "some address", name: "some name", phone_number: "some phone_number"}
  @update_attrs %{address: "some updated address", name: "some updated name", phone_number: "some updated phone_number"}
  @invalid_attrs %{address: nil, name: nil, phone_number: nil}

  defp fixture(:contact) do
    {:ok, contact} = Accounts.create_contact(@create_attrs)
    contact
  end

  defp create_contact(_) do
    contact = fixture(:contact)
    %{contact: contact}
  end

  describe "Index" do
    setup [:create_contact]

    test "lists all contacts", %{conn: conn, contact: contact} do
      {:ok, _index_live, html} = live(conn, Routes.contact_index_path(conn, :index))

      assert html =~ "Listing Contacts"
      assert html =~ contact.address
    end

    test "saves new contact", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.contact_index_path(conn, :index))

      assert index_live |> element("a", "New Contact") |> render_click() =~
               "New Contact"

      assert_patch(index_live, Routes.contact_index_path(conn, :new))

      assert index_live
             |> form("#contact-form", contact: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contact-form", contact: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contact_index_path(conn, :index))

      assert html =~ "Contact created successfully"
      assert html =~ "some address"
    end

    test "updates contact in listing", %{conn: conn, contact: contact} do
      {:ok, index_live, _html} = live(conn, Routes.contact_index_path(conn, :index))

      assert index_live |> element("#contact-#{contact.id} a", "Edit") |> render_click() =~
               "Edit Contact"

      assert_patch(index_live, Routes.contact_index_path(conn, :edit, contact))

      assert index_live
             |> form("#contact-form", contact: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#contact-form", contact: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contact_index_path(conn, :index))

      assert html =~ "Contact updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes contact in listing", %{conn: conn, contact: contact} do
      {:ok, index_live, _html} = live(conn, Routes.contact_index_path(conn, :index))

      assert index_live |> element("#contact-#{contact.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#contact-#{contact.id}")
    end
  end

  describe "Show" do
    setup [:create_contact]

    test "displays contact", %{conn: conn, contact: contact} do
      {:ok, _show_live, html} = live(conn, Routes.contact_show_path(conn, :show, contact))

      assert html =~ "Show Contact"
      assert html =~ contact.address
    end

    test "updates contact within modal", %{conn: conn, contact: contact} do
      {:ok, show_live, _html} = live(conn, Routes.contact_show_path(conn, :show, contact))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Contact"

      assert_patch(show_live, Routes.contact_show_path(conn, :edit, contact))

      assert show_live
             |> form("#contact-form", contact: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#contact-form", contact: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.contact_show_path(conn, :show, contact))

      assert html =~ "Contact updated successfully"
      assert html =~ "some updated address"
    end
  end
end
