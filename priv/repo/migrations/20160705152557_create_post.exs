defmodule Habitus.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :field, :string
      add :content, :string
      add :alias, :string
      add :enable_comments, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:posts, [:user_id])

  end
end
