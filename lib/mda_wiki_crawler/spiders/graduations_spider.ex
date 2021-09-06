defmodule MdaWikiCrawler.Spiders.GraduationsSpider do
  use Crawly.Spider

  alias Crawly.Utils

  @impl Crawly.Spider
  def base_url(), do: "https://mda.wiki.br/"

  @impl Crawly.Spider
  def init(), do: [start_urls: ["https://mda.wiki.br/"]]

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} = Floki.parse_document(response.body)

    hrefs =
      document
      |> Floki.find("body[data-ident=\"page@inicio\"]")
      |> Floki.find("ul.sidebar-menu")
      |> Floki.find("li.sidebar-label:fl-contains('Desbravadores') + li")
      |> Floki.find("ul.sub-nav li a")
      |> Floki.attribute("href")

    requests =
      Utils.build_absolute_urls(hrefs, base_url())
      |> Utils.requests_from_urls()

    title = document |> Floki.find("h1") |> Floki.text()

    %Crawly.ParsedItem{
      :requests => requests,
      :items => [%{title: title, url: response.request_url}]
    }
  end
end
