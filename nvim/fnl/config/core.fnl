(module config.core
  {autoload {a    aniseed.core
             nvim aniseed.nvim
             :    packer}})

(def loaded-plugins {})

(defn set-options [option-table]
  (each [key value (pairs option-table)]
    (tset nvim.o key value)))

(defn set-keymaps [keymap-table user-opts]
  (let [opts (if (a.nil? user-opts)
               {:noremap true :silent true}
               user-opts)]
    (each [_ mapping (ipairs keymap-table)]
      (nvim.set_keymap (. mapping 1)
                       (. mapping 2)
                       (. mapping 3)
                       opts))))

(defn- safe-require [name]
  (let [(ok? val-or-err) (pcall require (.. "config.plugins." name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn use-plugins [plugin-table]
  (packer.startup
    (fn [use]
      (for [i 1 (a.count plugin-table)]
        (let [{: name : repo : config} (. plugin-table i)]
          (tset loaded-plugins name true)
          (when config (safe-require name))
          (if (a.string? repo)
            (use repo)
            (use (a.assoc (. repo 2) 1 (. repo 1)))))))))

(defn plugin-loaded? [name]
  (. loaded-plugins name))
