defmodule SimpleContact.Repo do
  use Ecto.Repo, otp_app: :simple_contact, adapter: Ecto.Adapters.MyXQL
end
