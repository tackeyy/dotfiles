# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

case ${OSTYPE} in
  # macOS
  darwin*)
    source ~/.zprofile.macos
    ;;
  linux*)
    source ~/.zprofile.linuxos
    ;;
esac
