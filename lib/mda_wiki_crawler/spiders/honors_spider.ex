defmodule MdaWikiCrawler.Spiders.HonorsSpider do
  use Crawly.Spider

  alias Crawly.Utils
  alias MdaWikiCrawler.Schemas.Category, as: Category
  alias MdaWikiCrawler.Schemas.Honor, as: Honor

  @impl Crawly.Spider
  def base_url(), do: "https://mda.wiki.br/"

  @impl Crawly.Spider
  def init(), do: [start_urls: ["https://mda.wiki.br/Especialidades"]]

  @impl Crawly.Spider
  def override_settings() do
    [
      pipelines: [
        {Crawly.Pipelines.Validate, fields: [:code]},
        MdaWikiCrawler.Pipelines.StoreEctoPipeline
      ]
    ]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} = Floki.parse_document(response.body)

    hrefs =
      document
      |> Floki.find("h5 + ul li a[href*=\"Especialidade\"")
      |> Floki.attribute("href")

    requests =
      Utils.build_absolute_urls(hrefs, base_url())
      |> Utils.requests_from_urls()

    name =
      document
      |> Floki.find("body[data-ident^=\"especialidade\"]")
      |> Floki.find("h1")
      |> Floki.text()

    infos =
      document
      |> Floki.find("body[data-ident^=\"especialidade\"]")
      |> Floki.find("table.templ_especialidade_dbv tr:nth-child(2) td")
      |> Floki.text(sep: ",")
      |> String.split(",")

    requirements =
      document
      |> Floki.find("body[data-ident^=\"especialidade\"]")
      |> Floki.find("div > ol *")
      |> Floki.raw_html()

    category = document |> Floki.find(".panel-body > a:nth-child(2)") |> Floki.text()

    %Crawly.ParsedItem{
      :requests => requests,
      :items => [
        %Honor{
          name: name,
          category: %Category{name: category, code: Enum.at(infos, 1)},
          level: Enum.at(infos, 2),
          year: Enum.at(infos, 3),
          source: Enum.at(infos, 4),
          requirements: requirements
        }
      ]
    }
  end

  def parse_requirements(Binary: doc) do
    Enum.map(doc, fn {k, v} ->
      {
        {tag, _, subitens} = v
      }
    end)
  end

  def parse_requirements(), do: nil

  def extract_initials([name_part]) do
    String.slice(name_part, 0, 2)
  end

  def extract_initials([name_part | name_parts]) do
    String.slice(name_part, 0, 1) <> extract_initials(name_parts)
  end
end
