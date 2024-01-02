defmodule UsersApiSerguei.Repo.Migrations.CreatePreferencesTable do
  use Ecto.Migration

  def change do
    create table(:preferences) do
      add :likes_emails, :boolean, default: false
      add :likes_phone_calls, :boolean, default: false
      add :likes_faxes, :boolean, default: false
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
