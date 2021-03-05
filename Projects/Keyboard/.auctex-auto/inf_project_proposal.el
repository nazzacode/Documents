(TeX-add-style-hook
 "inf_project_proposal"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref")
   (LaTeX-add-labels
    "sec:orgb81b979"
    "sec:orgc3eb84d"
    "sec:orga9b190d"
    "sec:org4151840"
    "sec:org2a503d4"
    "sec:orga64caad"
    "sec:org3829ae9"
    "sec:org07a6421"
    "sec:org7bb1cdd"
    "sec:org30081e5"
    "sec:org4aa83e7"
    "sec:orgc1161a8"
    "sec:orgbd80591"
    "sec:org8d0c272"
    "sec:orgb609c05"
    "sec:org54d821f"
    "sec:orgf1f5d26"
    "sec:orge7dfda8"
    "sec:org5256635"
    "sec:orgb294e2f"
    "sec:org2d45bec"
    "sec:orgbef1a72"
    "sec:orgb892b2e"
    "sec:orgbef738c"
    "sec:orgdc39aab"
    "sec:org78c5e13"
    "sec:org57ab83c"))
 :latex)

