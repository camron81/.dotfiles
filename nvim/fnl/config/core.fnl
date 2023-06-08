(module config.core
  {autoload {nvim aniseed.nvim
             : packer}})

(defn- string? [value]
  (= "string" (type value)))

(defn set-options [option-table]
  (each [key value (pairs option-table)]
    (tset nvim.o key value)))

(defn set-keymaps [keymap-table user-opts]
  (let [opts (if (= nil user-opts)
               {:noremap true :silent true}
               user-opts)]
    (each [_ map (ipairs keymap-table)]
      (nvim.set_keymap (. map 1)
                       (. map 2)
                       (. map 3)
                       opts))))

(defn use-plugins [plugin-list]
   (packer.startup
     (fn [use]
       (each [_ plugin (ipairs plugin-list)]
         (if (string? plugin)
           (use plugin)
           (let [[repo opts] plugin]
             (tset opts 1 repo)
             (use opts)))))))
