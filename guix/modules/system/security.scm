;; Original Source: https://github.com/Kicksecure/security-misc
;; Inspiration: https://codeberg.org/hako/Testament
(define-module (system security)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services linux)
  #:use-module (gnu services sysctl)
  #:use-module (gnu packages linux)
  #:use-module (nongnu packages linux)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp))

(define-public %secure-kernel-arguments
  '(("spectre_v2=on"

     "spec_store_bypass_disable=on"

     "l1tf=full,force"

     "mds=full,nosmt"

     "tsx=off"
     "tsx_async_abort=full,nosmt"

     "kvm.nx_huge_pages=force"

     "nosmt=force"

     "l1d_flush=on"

     "mmio_stale_data=full,nosmt"

     "random.trust_bootloader=off"

     "random.trust_cpu=off"

     "intel_iommu=on"
     "amd_iommu=on"

     "efi=disable_early_pci_dma"

     "iommu.passthrough=0"
     "iommu.strict=1"

     "slab_nomerge"

     "init_on_alloc=1"
     "init_on_free=1"

     "pti=on"

     "vsyscall=none"

     "page_alloc.shuffle=1"

     "randomize_kstack_offest=on"

     "extra_latent_entropy"

     "debugfs=off"

     "quiet loglevel=0")))

(define-public %secure-sysctl-rules
  '(("kernel.core_pattern" . "|/run/current-system/profile/bin/false")

    ("kernel.dmesg_restrict" . "1")

    ("fs.protected_fifos" . "2")
    ("fs.protected_regular" . "2")

    ("fs.protected_symlinks" . "2")
    ("fs.protected_hardlinks" . "2")

    ("kernel.unprivileged_bpf_disabled" . "1")
    ("net.core.bpf_jit_harden" . "2")

    ("kernel.kptr_restrict" . "2")

    ("kernel.yama.ptrace_scope" . "2")

    ("fs.suid_dumpable" . "0")

    ("kernel.randomize_va_space" . "2")

    ("net.ipv4.tcp_rfc1337" . "1")

    ("net.ipv4.conf.all.accept_redirects" . "0")
    ("net.ipv4.conf.default.accept_redirects" . "0")
    ("net.ipv4.conf.all.secure_redirects" . "0")
    ("net.ipv4.conf.default.secure_redirects" . "0")
    ("net.ipv6.conf.all.accept_redirects" . "0")
    ("net.ipv6.conf.degault.accept_redirects" . "0")

    ("net.ipv4.icmp_echo_ignore_all" . "1")
    ("net.ipv6.icmp.echo_ignore_all" . "1")

    ("net.ipv4.icmp_ignore_bogus_error_responses" . "1")

    ("net.ipv4.tcp_syncookies" . "1")

    ("net.ipv4.conf.all.accept_source_route" . "0")
    ("net.ipv4.conf.default.accept_source_route" . "0")
    ("net.ipv6.conf.all.accept_source_route" . "0")
    ("net.ipv6.conf.default.accept_source_route" . "0")

    ("net.ipv4.conf.default.rp_filter" . "1")
    ("net.ipv4.conf.all.rp_filter" . "1")

    ("net.ipv4.tcp_timestamps" . "0")

    ("kernel.sysrq" . "132")

    ("dev.tty.ldisc_autoload" . "0")

    ("vm.unprivileged_userfaultfd" . "0")

    ("vm.swappiness" . "1")

    ("kernel.perf_event_paranoid" . "3")

    ("net.ipv6.conf.all.accept_ra" . "0")
    ("net.ipv6.conf.default.accept_ra" . "0")

    ("kernel.kexec_disabled" . "1")

    ("kernel.printk" . "3 3 3 3")))

(define network-manager-ipv6-privacy
  (plain-file "NetworkManager.conf"
    "
    [connection]
    ipv6.ip6-privacy=2
    "))

(define generic-machine-id
  (plain-file "machine-id" 
              "b08dfa6083e7567a1921a715000001fb"))

(define modules-blacklist
  (plain-file "blacklist.conf"
    "
    options nf_conntrack nf_conntrack_helper=0

    install bluetooth /run/current-system/bin/false
    install btusb /run/current-system/bin/false

    install uvcvideo /run/current-system/bin/false

    install thunderbolt /run/current-system/bin/false
    install firewire-core /run/current-system/bin/false
    install firewire_core /run/current-system/bin/false
    install firewire-ohci /run/current-system/bin/false
    install firewire_ohci /run/current-system/bin/false
    install firewire_sbp2 /run/current-system/bin/false
    install firewire-sbp2 /run/current-system/bin/false
    install ohci1394 /run/current-system/bin/false
    install sbp2 /run/current-system/bin/false
    install dv1394 /run/current-system/bin/false
    install raw1394 /run/current-system/bin/false
    install video1394 /run/current-system/bin/false

    install msr /run/current-system/bin/false

    install dccp /run/current-system/bin/false
    install sctp /run/current-system/bin/false
    install rds /run/current-system/bin/false
    install tipc /run/current-system/bin/false
    install n-hdlc /run/current-system/bin/false
    install ax25 /run/current-system/bin/false
    install netrom /run/current-system/bin/false
    install x25 /run/current-system/bin/false
    install rose /run/current-system/bin/false
    install decnet /run/current-system/bin/false
    install econet /run/current-system/bin/false
    install af_802154 /run/current-system/bin/false
    install ipx /run/current-system/bin/false
    install appletalk /run/current-system/bin/false
    install psnap /run/current-system/bin/false
    install p8023 /run/current-system/bin/false
    install p8022 /run/current-system/bin/false
    install can /run/current-system/bin/false
    install atm /run/current-system/bin/false

    install cramfs /run/current-system/bin/false
    install freevxfs /run/current-system/bin/false
    install jffs2 /run/current-system/bin/false
    install hfs /run/current-system/bin/false
    install hfsplus /run/current-system/bin/false
    install udf /run/current-system/bin/false

    install cifs /run/current-system/bin/false
    install nfs /run/current-system/bin/false
    install nfsv3 /run/current-system/bin/false
    install nfsv4 /run/current-system/bin/false
    install ksmbd /run/current-system/bin/false
    install gfs2 /run/current-system/bin/false

    install vivid /run/current-system/bin/false

    install mei /run/current-system/bin/false
    install mei-me /run/current-system/bin/false

    blacklist ath_pci

    blacklist evbug
    blacklist usbmouse
    blacklist usbkbd
    blacklist eepro100
    blacklist de4x5
    blacklist eth1394
    blacklist snd_intel8x0m
    blacklist snd_aw2
    blacklist prism54
    blacklist bcm43xx
    blacklist garmin_gps
    blacklist asus_acpi
    blacklist snd_pcsp
    blacklist pcspkr
    blacklist amd76x_edac

    blacklist aty128fb
    blacklist atyfb
    blacklist radeonfb
    blacklist cirrusfb
    blacklist cyber2000fb
    blacklist cyblafb
    blacklist gx1fb
    blacklist hgafb
    blacklist i810fb
    blacklist intelfb
    blacklist kyrofb
    blacklist lxfb
    blacklist matroxfb_bases
    blacklist neofb
    blacklist nvidiafb
    blacklist pm2fb
    blacklist rivafb
    blacklist s1d13xxxfb
    blacklist savagefb
    blacklist sisfb
    blacklist sstfb
    blacklist tdfxfb
    blacklist tridentfb
    blacklist vesafb
    blacklist vfb
    blacklist viafb
    blacklist vt8623fb
    blacklist udlfb

    blacklist cdrom
    blacklist sr_mod
    "))

(define no-root-tty
  (plain-file "securetty" ""))

(define no-coredumps
  (plain-file "coredump.conf" "* hard core 0"))

(define no-root-ssh
  (plain-file "sshd_config" 
              "PermitRootLogin no"))

(define-public %secure-etc-files-service
  (simple-service 
    'secure-etc-files etc-service-type
    `(("NetworkManager/NetworkManager.conf" ,network-manager-ipv6-privacy)
      ("machine-id" ,generic-machine-id)
      ("modprobe.d/blacklist.conf" ,modules-blacklist)
      ("securetty" ,no-root-tty)
      ("security/limits.d/coredump.conf" ,no-coredumps)
      ("ssh/sshd_config" ,no-root-ssh))))

; (define lkrg-full-kernel
;   (package
;     (inherit lkrg)
;     (arguments
;       `(#:linux ,linux
;         #:tests? #f
;         #:make-flags
;         (list (string-append "CC=" ,(cc-for-target))
;               (string-append "SYSSRC="
;                              (assoc-ref %build-inputs
;                                         "linux-module-builder")
;                              "/lib/modules/build"))))))
;
; (define-public %secure-packages
;   (list 
;     lkrg-full-kernel
;     jitterentropy-rngd))
;
; (define-public %secure-kernel-loader-service
;   (service kernel-module-loader-service-type 
;            '("jitterentropy_rng")))

(define-public %secure-base-services
  (modify-services %base-services
    (sysctl-service-type config =>
                         (sysctl-configuration
                           (inherit config)
                           (settings %secure-sysctl-rules)))))
