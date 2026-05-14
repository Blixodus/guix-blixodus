(define-module (blixodus packages atostekid)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cryptsetup)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages debian)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages security-token)
  #:use-module (gnu packages qt)

  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)

  #:use-module (nonguix build-system binary)
  #:use-module (nonguix licenses))

(define-public atostekid
  (package
   (name "atostekid")
   (version "4.5.0.0")
   (source
    (origin
     (method url-fetch)
     (uri (string-append
           "https://files.fineid.fi/download/atostek/";
           version "/linux/AtostekID_DEB_" version ".deb"))
     (sha256
      (base32 "1r5kj1l9ii0rdwaaz6zhwc558620hqjwkgm34w5dv2vywa0fklhl"))))
   (build-system binary-build-system)
   (arguments
    `(#:install-plan
      '(("usr/bin/" "bin")
        ("etc/" "etc"))
      #:patchelf-plan
      '(("usr/bin/atostekid" ("libc" "qpdf" "botan" "minizip" "pcsc-lite" "qtbase" "gcc")))
      #:phases
      (modify-phases %standard-phases
		     (replace 'unpack
			      (lambda* (#:key inputs source #:allow-other-keys)
				(let ((dpkg (string-append (assoc-ref inputs "dpkg")
							   "/bin/dpkg")))
				  (invoke dpkg "-x" source "."))))
		     (add-after 'install 'wrap-executable
				(lambda* (#:key inputs outputs #:allow-other-keys)
				  (let ((out (assoc-ref outputs "out"))
					(qtbase (assoc-ref inputs "qtbase")))
				    (wrap-program (string-append out "/bin/atostekid")
						  `("QT_QPA_PLATFORM" = ("xcb"))
						  `("XDG_DATA_DIRS" prefix 
						    (,(string-append out "/share")
						     ,(string-append (assoc-ref inputs "qtbase") "/share")))))))
		     (add-after 'install 'patch-nss-path
				(lambda* (#:key inputs outputs #:allow-other-keys)
				  (let ((patchelf (search-input-file inputs "/bin/patchelf"))
					(libnss (string-append (assoc-ref inputs "nss") "/lib/nss"))
					(exe (string-append (assoc-ref outputs "out") "/bin/atostekid")))
				    (invoke patchelf "--set-rpath" 
					    (string-append libnss ":" (getenv "LIBRARY_PATH"))
					    exe)))))))
   (native-inputs (list dpkg patchelf))
   (inputs (list qpdf botan-2 nss minizip pcsc-lite qtbase libdbusmenu-qt `(,gcc "lib")))
   (supported-systems '("x86_64-linux"))
   (home-page "https://dvv.fi/en/card-reader-software")
   (synopsis "Finnish smart ID card software.")
   (description "Atostek ID is card reader software used with certificate cards issued
by the Finnish Digital and Population Data Services Agency. This Guix
package is a binary installation from a .deb archive.")
   (license (nonfree (string-append "file://" (assoc-ref outputs "atostekid"))))))
