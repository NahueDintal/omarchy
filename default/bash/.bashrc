#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|
#
# -----------------------------------------------------
# ML4W bashrc loader
# -----------------------------------------------------

# DON'T CHANGE THIS FILE

# You can define your custom configuration by adding
# files in ~/.config/bashrc
# or by creating a folder ~/.config/bashrc/custom
# with copies of files from ~/.config/bashrc
# You can also create a .bashrc_custom file in your home directory
# -----------------------------------------------------

# -----------------------------------------------------
# Load modular configarion
# -----------------------------------------------------

# for f in ~/.config/bashrc/*; do
#     if [ ! -d $f ]; then
#         c=`echo $f | sed -e "s=.config/bashrc=.config/bashrc/custom="`
#         [[ -f $c ]] && source $c || source $f
#     fi
# done

# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------

# if [ -f ~/.bashrc_custom ]; then
#     source ~/.bashrc_custom
# fi

# ====================
# CONFIGURACIÓN BÁSICA
# ====================
export EDITOR=nvim
export VISUAL=nvim

# Historial mejorado
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# Opciones interactivas
shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell
shopt -s globstar

# ====================
# AUTOCOMPLETADO AVANZADO
# ====================
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Configuración de autocompletado
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "set bell-style none"

# Completado para comandos comunes
if [ -f /usr/share/bash-completion/completions/git ]; then
  . /usr/share/bash-completion/completions/git
fi

# Config de Tmux
tmux source ~/.tmux/tmux.conf

# Auto-iniciar tmux de forma inteligente
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  # Si hay sesiones, conectarse a la primera disponible
  if tmux list-sessions &>/dev/null; then
    exec tmux attach
  else
    # Si no hay sesiones, crear una nueva
    exec tmux new -s Tmux
  fi
fi

# ====================
# ALIAS ÚTILES
# ====================
alias ls='ls --color=auto'
alias ll='ls -lAh'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
alias actualy='yes s | sudo pacman -Syu'
alias v='nvim'
alias pullall='~/.config/scriptpropios/pullAll.sh'
alias wifi='nmtui'
alias ..='cd ..'
alias sqlserver='docker exec -it sqlserver-dev /bin/bash'
alias c='clear'
alias ping1='ping 1.1.1.1'
alias ping8='ping 8.8.8.8'

# ====================
# FUNCIONES PERSONALES
# ====================
# Buscar en historial con flechas
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Navegaciòn rápida
up() {
  local d=""
  local limit="$1"
  for ((i = 1; i <= limit; i++)); do
    d="../$d"
  done
  cd "$d" || echo "Error: no se pudo cambiar al directorio"
}

# ====================
# STARSHIP PROMPT
# ====================
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# Optimización para Starship
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export STARSHIP_CACHE="$HOME/.cache/starship"
mkdir -p "$STARSHIP_CACHE"

# Acelera la comprobación de git
export STARSHIP_CONFIG_GIT_DISCOVERY_LIMIT=1
