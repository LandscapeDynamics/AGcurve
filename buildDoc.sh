# Process for building documentation (including apropriate NAMESPACE file)
#  manually from within the main package directory.
LIB="AGcurve"                                        # R package name
LIBPATH="$HOME/R/"                                 # R pack. installation dir

R --no-save << EOF
library(roxygen2)
devtools::document(roclets=c('rd', 'collate',      # Create doc. components
                             'namespace', 'vignette'))

print(paste0(rep('#',72), collapse=''))
roxygenize()                                       # Build documentation

print(paste0(rep('#',72), collapse=''))
devtools::install()                                # Install package
EOF

# Manually buid & install package, then create documentation PDF
R CMD build --resave-data=best '.'
R CMD INSTALL --library=$LIBPATH $LIB*.tar.gz
R CMD Rd2pdf $LIBPATH/$LIB -o $LIB-manual.pdf --force overwrite
