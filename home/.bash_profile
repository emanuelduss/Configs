#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# SSH Agent Configuration
SSH_AGENT_VARS="$HOME/.ssh/ssh-agent-vars"
if [[ ! "$SSH_AUTH_SOCK" ]]
then
  . "$SSH_AGENT_VARS" &>/dev/null
fi
ssh-add -l &>/dev/null
RC="$?"
if [[ "$RC" == 2 ]]
then
  ssh-agent > "$SSH_AGENT_VARS"
  . "$SSH_AGENT_VARS" &>/dev/null
fi
