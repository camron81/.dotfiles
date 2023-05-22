(module magic.plugin
  {autoload {a aniseed.core
             packer packer}})

(defn- safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. "magic.plugin" name))]
    (when (not ok?)
      (print (.. "Plugin config error: " val-or-err)))))
   
(defn req [name]
  (.. "require('magic.plugin." name "')"))

(defn use [...]
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
  nil)
