defmodule MdaWikiCrawler.Schemas.HonorRequirement do
  use Ecto.Schema

  schema "requirements" do
    field(:description, :map)
    field(:order, :integer)
    belongs_to(:honor, MdaWikiCrawler.Schemas.Honor)
    timestamps()
  end
end
