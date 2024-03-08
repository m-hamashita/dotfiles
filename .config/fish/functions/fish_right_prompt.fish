# ref: https://github.com/Ladicle/fish-kubectl-prompt/blob/b9bce1d64c5369518ba2b101c3ddfd5ee6a2bfc1/functions/fish_prompt.fish
function kubectl_status
  [ -z "$KUBECTL_PROMPT_ICON" ]; and set -l KUBECTL_PROMPT_ICON "⎈"
  [ -z "$KUBECTL_PROMPT_SEPARATOR" ]; and set -l KUBECTL_PROMPT_SEPARATOR "/"

  set -l config $KUBECONFIG
  [ -z "$config" ]; and set -l config "$HOME/.kube/config"
  if [ ! -f $config ]
    set -g ctx "no config"
  end

  if [ (command -v kubectl) ]
    set -g ctx (kubectl config current-context 2>/dev/null)
    if [ $status -ne 0 ]
      set -g ctx "no context"
      set -g ns 'default'
    else
      set -g ns (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$ctx\")].context.namespace}")
      [ -z $ns ]; and set -g ns 'default'
    end
  end
  echo (set_color cyan)$KUBECTL_PROMPT_ICON" "(set_color white)"$ctx$KUBECTL_PROMPT_SEPARATOR$ns"

end
function awsctx 
  if [ (command -v awsctx) ]
      set -g awsctx_profile (awsctx active-context)
  end
  echo (set_color white)$awsctx_profile
end 

function gcloud_config
  if [ (command -v gcloud) ]
      set -g gcloud_project (cat ~/.config/gcloud/active_config)
  end
  echo (set_color white)"$gcloud_project"
end

function fish_right_prompt
  echo "("(kubectl_status)"/"(awsctx)"/"(gcloud_config)")"
end
