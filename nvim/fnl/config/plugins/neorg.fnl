(module config.plugins.neorg
  {autoload {neorg :neorg}})

(neorg.setup
  {:load {:core.defaults {}
          :core.completion
          {:config {:engine "nvim-cmp"}}
          :core.concealer
          {:config {:icon_preset "diamond"
                    :icons {:ordered 
                            {"level_1" {:icon tostring}}}}}
          :core.dirman 
          {:config {:workspaces 
                    {:notes "~/notes"
                     :finance "~/notes/finance/"}
                    :default_workspace "notes"}}
          :core.summary {}}})
