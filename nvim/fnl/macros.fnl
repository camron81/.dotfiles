(fn safe-require [name]
  `(let [(ok# module#) (pcall require ,name)]
     (if ok#
       module#
       (print "config error: " module#))))

(fn plugin-config [name]
  (safe-require (.. "config.plugins." name)))

(fn plugin-loadable? [name]
  `(let [(ok# module#) (pcall require ,name)]
     (if ok#
       true
       false)))

{: safe-require
 : plugin-config
 : plugin-loadable?}
