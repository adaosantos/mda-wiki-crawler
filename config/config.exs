import Config

config :mda_wiki_crawler, ecto_repos: [MdaWikiCrawler.Repo]

import_config "#{config_env()}.exs"
