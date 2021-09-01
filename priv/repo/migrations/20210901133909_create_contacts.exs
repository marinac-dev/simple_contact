defmodule SimpleContact.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :name, :string
      add :phone_number, :string
      add :address, :string

      timestamps()
    end

  end
end
