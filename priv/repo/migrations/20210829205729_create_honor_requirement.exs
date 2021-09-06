defmodule MdaWikiCrawler.Repo.Migrations.CreateHonorRequirement do
  use Ecto.Migration

  def change do
    create table(:honor_requirement) do
      add :description, :map
      add :honor_id, references(:honor)
      add :order, :integer
      timestamps()
    end
  end
end
