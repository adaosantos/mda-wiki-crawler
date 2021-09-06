defmodule MdaWikiCrawler.Repo.Migrations.CreateHonor do
  use Ecto.Migration

  def change do
    create table(:honor) do
      add :name, :string
      add :emblem, :string
      add :category_id, references(:honor_category)
      add :code, :string
      add :level, :string
      add :year, :string
      add :source, :string
      timestamps()
    end
  end
end
