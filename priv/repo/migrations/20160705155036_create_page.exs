defmodule Habitus.Repo.Migrations.CreatePage do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :content, :string
      add :alias, :string

      timestamps()
    end

  end
end
