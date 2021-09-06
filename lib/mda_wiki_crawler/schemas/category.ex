defmodule MdaWikiCrawler.Schemas.Category do
  use Ecto.Schema

  schema "categories" do
    field(:name, :string)
    field(:code, :string)
    has_many(:honors, MdaWikiCrawler.Schemas.Honor)
    timestamps()
  end
end
