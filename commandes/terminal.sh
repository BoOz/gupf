#!/bin/sh

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$DIR"
# on remonte de /bin vers le cran du dessus.
cd ../

# on source l'install dans ce rep 
. install.sh

exit
