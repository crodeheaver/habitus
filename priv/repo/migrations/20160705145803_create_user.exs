defmodule Habitus.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :display_name, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :role_id, references(:roles, on_delete: :nothing), default: 3

      timestamps()
    end
    create index(:users, [:role_id])
    create unique_index(:users, [:email])
    create unique_index(:users, [:display_name])
  end
end
