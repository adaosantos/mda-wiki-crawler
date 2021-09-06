defmodule MdaWikiCrawler.Repo.Migrations.CreateHonorCategory do
  use Ecto.Migration

  def change do
    create table(:honor_category) do
      add :name, :string
      add :code, :string
      timestamps()
    end
  end
end
