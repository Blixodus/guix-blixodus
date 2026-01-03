(define-module (packages fineid)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cryptsetup)
  #:use-module (gnu packages debian)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages linux)

  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)

  #:use-module (nonguix build-system binary))

(define-public fineid
  (package
    (name "fineid")
    (version "4.4.1.0")
    (source
    (origin
     (method url-fetch)
     (uri (string-append
           "https://files.fineid.fi/download/atostek/";
           version "/linux/AtostekID_DEB_" version ".deb"))
     (sha256
      (base32 "0ix69k74n720hbl55pl2dm0wx95rcf2x5lmc28pmmy9gpy4kvv3g"))))
    (build-system binary-build-system)
    (arguments
     `(#:install-plan
       '(("usr/" "usr")
         ("etc/" "etc"))
       #:patchelf-plan
       '(("usr/bin/atostekid" ("libc" "libgcc")))
       #:phases
       (modify-phases %standard-phases
         (replace 'unpack
           (lambda* (#:key inputs source #:allow-other-keys)
             (let ((dpkg (string-append (assoc-ref inputs "dpkg")
                                      "/bin/dpkg")))
               (invoke dpkg "-x" source ".")))))))
    (native-inputs
     `(("dpkg" ,dpkg)))
    (inputs
     `(("libgcc" ,libgcc)))
    (supported-systems '("x86_64-linux"))
    (home-page "https://dvv.fi/en/card-reader-software")
    (synopsis "Finnish smart ID card software")
    (description "Finnish smart ID card software from a .deb file.")
    (license #f)))
