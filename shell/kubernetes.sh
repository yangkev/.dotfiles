if [[ $(command -v kubectl > /dev/null 2>&1) ]]; then
  return
fi

# kubectl
alias k="kubectl"
alias ka="kubectl --all-namespaces"
alias kn="kubectl -n"

# Gets
alias kg="kubectl get"
alias kgn="kubectl get nodes -o wide"

alias kgp="kubectl get pods"
alias kgpa="kubectl get pods --all-namespaces"
alias kgpn="kubectl get pods -n"

alias kgd="kubectl get deploy"
alias kgda="kubectl get deploy --all-namespaces"
alias kgdn="kubectl get deploy -n"

alias kgj="kubectl get jobs"
alias kgja="kubectl get jobs --all-namespaces"
alias kgjn="kubectl get jobs -n"

alias kgc="kubectl get cronjobs.batch"
alias kgca="kubectl get cronjobs.batch --all-namespaces"
alias kgcn="kubectl get cronjobs.batch -n"

# Describes
alias kd="kubectl describe"
alias kdp="kubectl describe pods -n"
alias kdd="kubectl describe deploy -n"
alias kdj="kubectl describe jobs -n"
alias kdc="kubectl describe cronjobs.batch -n"

# Logs
alias klog="kubectl logs -n"

if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
  source <(kubectl completion zsh)
  complete -F __start_kubectl k
  complete -F __start_kubectl ka
  complete -F __start_kubectl kn
  complete -F __start_kubectl kg
  complete -F __start_kubectl kgn
  complete -F __start_kubectl kgp
  complete -F __start_kubectl kgpa
  complete -F __start_kubectl kgpn
  complete -F __start_kubectl kgd
  complete -F __start_kubectl kgda
  complete -F __start_kubectl kgdn
  complete -F __start_kubectl kgj
  complete -F __start_kubectl kgja
  complete -F __start_kubectl kgjn
  complete -F __start_kubectl kgc
  complete -F __start_kubectl kgca
  complete -F __start_kubectl kgcn
  complete -F __start_kubectl kd
  complete -F __start_kubectl kdp
  complete -F __start_kubectl kdd
  complete -F __start_kubectl kdj
  complete -F __start_kubectl kdc
  complete -F __start_kubectl klog
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
  source <(kubectl completion bash)
fi
