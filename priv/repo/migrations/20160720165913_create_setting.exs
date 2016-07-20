defmodule Habitus.Repo.Migrations.CreateSetting do
  use Ecto.Migration

  def change do
    create table(:settings) do
      add :title, :string
      add :tagline, :string
      add :logo, :string
      add :theme, :string
      add :file_size_limit, :integer
      add :enable_user_uploads, :boolean, default: false, null: false
      add :enable_registration, :boolean, default: false, null: false
      add :enable_blog, :boolean, default: false, null: false
      add :enable_file_uploads, :boolean, default: false, null: false
      add :front_page, :string

      timestamps()
    end

  end
end
