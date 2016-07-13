defmodule Habitus.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :role_type, :string

      timestamps()
    end

  end
end
