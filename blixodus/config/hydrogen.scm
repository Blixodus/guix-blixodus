;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(define-module (blixodus config hydrogen)
  #:use-module (gnu)
  #:use-module (gnu system locale)
  #:use-module (gnu services guix)
  #:use-module (gnu services authentication)
  #:use-module (gnu services security-token)
  #:use-module (gnu services cups)
  #:use-module (gnu services desktop)
  #:use-module (gnu services networking)
  #:use-module (gnu services ssh)
  #:use-module (gnu services xorg)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnome-xyz)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (blixodus config home))

(define-public hydrogen-config
  (operating-system
   (kernel linux-7.0)
   (initrd microcode-initrd)
   (firmware (list sof-firmware linux-firmware))
   (locale "en_US.utf8")
   (locale-definitions (cons* (locale-definition
			       (name "fi_FI.utf8") (source "fi_FI"))
			      %default-locale-definitions))
   (timezone "Europe/Paris")
   (keyboard-layout (keyboard-layout "fi"
				     #:options '("ctrl:hyper_capscontrol")))
   (host-name "hydrogen")

   ;; The list of user accounts ('root' is implicit).
   (users (cons* (user-account
                  (name "atte")
                  (comment "Atte Torri")
                  (group "users")
                  (home-directory "/home/atte")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
		 %base-user-accounts))

   ;; Packages installed system-wide.  Users can also install packages
   ;; under their own account: use 'guix search KEYWORD' to search
   ;; for packages and 'guix install PACKAGE' to install a package.
   (packages (append (list gnome-shell-extensions
                           gnome-shell-extension-appindicator
                           gnome-tweaks)
                     %base-packages))

   ;; Below is the list of system services.  To search for available
   ;; services, run 'guix system search KEYWORD' in a terminal.
   (services
    (append (list (service gnome-desktop-service-type)
		  (service bluetooth-service-type)
		  ;(service fprintd-service-type)
		  (service pcscd-service-type)
                  ;; To configure OpenSSH, pass an 'openssh-configuration'
                  ;; record as a second argument to 'service' below.
                  (service openssh-service-type)
                  (service cups-service-type)
		  (service guix-home-service-type `(("atte" ,home-config)))
                  (set-xorg-configuration
                   (xorg-configuration (keyboard-layout keyboard-layout))))

            ;; Append default desktop services, add nonguix substitutes
            ;; server. (Replace with %desktop-services if removed)
            (modify-services %desktop-services
			     (guix-service-type config =>
						(guix-configuration
						 (inherit config)
						 (substitute-urls
						  (append (list "https://guix.bordeaux.inria.fr"
								;; "https://substitutes.nonguix.org"
								"https://nonguix-proxy.ditigal.xyz"
								"https://cache-cdn.guix.moe/")
							  %default-substitute-urls))
						 (authorized-keys
						  (append (list (local-file "./files/signing-key-guix-science.pub")
								(local-file "./files/signing-key-nonguix.pub")
								(local-file "./files/signing-key-guix-moe.pub"))
							  %default-authorized-guix-keys)))))))
   
   (bootloader (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(targets (list "/boot/efi"))
		(keyboard-layout keyboard-layout)))
  
   (mapped-devices (list (mapped-device
                          (source (uuid
                                   "79404010-ac74-4ca2-8931-5a1ac4ac3da8"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

   ;; The list of file systems that get "mounted".  The unique
   ;; file system identifiers there ("UUIDs") can be obtained
   ;; by running 'blkid' in a terminal.
   (file-systems (cons* (file-system
			 (mount-point "/boot/efi")
			 (device (uuid "B7A6-1039"
                                       'fat32))
			 (type "vfat"))
			(file-system
			 (mount-point "/")
			 (device "/dev/mapper/cryptroot")
			 (type "ext4")
			 (dependencies mapped-devices)) %base-file-systems))

   ;; Add swap with a file in root file system (this requires root to
   ;; be loaded)
   (swap-devices
    (list
     (swap-space
      (target "/swapfile")
      (dependencies (filter (file-system-mount-point-predicate "/")
			    file-systems)))))

   ;; Kernel argument to enable correct hibernation
   (kernel-arguments
    (cons* "resume=/swapfile"
	   %default-kernel-arguments))))

hydrogen-config
