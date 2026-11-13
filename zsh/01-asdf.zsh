export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export ASDF_CONFIG_FILE="$(dirname $0)/config/.asdfrc"

fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# Keep JAVA_HOME in sync with the asdf java version
[[ -r "${ASDF_DATA_DIR:-$HOME/.asdf}/plugins/java/set-java-home.zsh" ]] && \
  source "${ASDF_DATA_DIR:-$HOME/.asdf}/plugins/java/set-java-home.zsh"

# Install asdf plugins and pin the default (home) versions.
# Run manually after a fresh install or when changing versions below;
# installing on every shell start makes the shell hang silently.
function setup-asdf() {
  local -a tools=(
    "java temurin-27.0.1+0 https://github.com/halcyon/asdf-java.git"
    "nodejs 22.14.0 https://github.com/asdf-vm/asdf-nodejs.git"
    "pnpm 10.5.2"
    "gradle 9.9.1 https://github.com/rfrancis/asdf-gradle.git"
    "python 3.13.2"
    "awscli 2.24.19"
    "terraform"
    "sops"
    "age"
  )
  local entry name version url
  for entry in "${tools[@]}"; do
    read -r name version url <<< "$entry"
    echo "==> $name ${version:-(plugin only)}"
    asdf plugin list | grep -qx "$name" || asdf plugin add "$name" $url || return 1
    [[ -z "$version" ]] && continue
    asdf install "$name" "$version" || return 1
    asdf set --home "$name" "$version" || return 1
  done
}
