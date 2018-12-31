countdown(){
  date1=$((`date +%s` + $1));
  while [ "$date1" -ge `date +%s` ]; do 
    ## Is this more than 24h away?
    days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400))
    echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r"; 
    sleep 0.1
  done
}

stopwatch(){
  date1=`date +%s`; 
  while true; do 
    days=$(( $(($(date +%s) - date1)) / 86400 ))
    echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
  done
}

# Create a new directory in the GOPATH and symlink it to $HOME/src
godir(){
  dirpath="$GOPATH/src/github.com/yangkev/${1}"
  ln -s "${dirpath}" "$HOME/src" > /dev/null 2>&1 
  if [[ $? -ne 0 ]]; then
    echo "symlink already exists. can't create $HOME/src/$1"
    return 1
  elif [[ -d "${dirpath}" ]]; then
    echo "directory already exists. can't create ${dirpath}"
    return 1
  fi
  mkdir -p "${dirpath}"
}

# gormdir() {
#     dirpath="$GOPATH/src/github.com/yangkev/${1}"
#     rmdir "${dirpath}"
# }
