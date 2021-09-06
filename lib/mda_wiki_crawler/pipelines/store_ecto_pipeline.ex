defmodule MdaWikiCrawler.Pipelines.StoreEctoPipeline do
  @behaviour Crawly.Pipeline
  @impl Crawly.Pipeline
  def run(%MdaWikiCrawler.Schemas.Honor{} = item, state, _opts \\ []) do
    case MdaWikiCrawler.Repo.insert(item) do
      {:ok, _} ->
        {item, state}

      {:error, _} ->
        {false, state}
    end
  end
end
