defmodule MdaWikiCrawler.Schemas.Honor do
  use Ecto.Schema

  schema "honors" do
    field(:name, :string)
    field(:emblem, :string)
    field(:code, :string)
    field(:level, :string)
    field(:year, :string)
    field(:source, :string)
    belongs_to(:category, MdaWikiCrawler.Schemas.Category)
    has_many(:requirements, MdaWikiCrawler.Schemas.HonorRequirement)
    timestamps()
  end
end
