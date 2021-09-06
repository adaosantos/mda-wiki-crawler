import Config

config :mda_wiki_crawler, MdaWikiCrawler.Repo,
  database: "mda_wiki_crawler_repo_dev",
  username: "mda_crawler",
  password: "password",
  hostname: "localhost"

config :crawly,
  pipelines: [
    Crawly.Pipelines.JSONEncoder,
    {Crawly.Pipelines.WriteToFile, folder: "priv/output/", extension: "json"}
  ]
