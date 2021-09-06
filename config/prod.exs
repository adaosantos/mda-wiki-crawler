import Config

config :mda_wiki_crawler, MdaWikiCrawler.Repo,
  database: "mda_wiki_crawler_repo_prod",
  username: "mda_crawler",
  password: "password",
  hostname: "localhost"
