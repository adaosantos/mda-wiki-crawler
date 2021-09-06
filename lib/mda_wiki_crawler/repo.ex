defmodule MdaWikiCrawler.Repo do
  use Ecto.Repo,
    otp_app: :mda_wiki_crawler,
    adapter: Ecto.Adapters.Postgres
end
