#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_FILE="$HOME/.dotfiles-profile"

boldYellow='\033[1;33m'
boldGrn='\033[1;32m'
boldRed='\033[1;31m'
boldCyan='\033[1;36m'
reset='\033[0m'

create_msg() { echo -e "[ ${boldGrn}CREATE${reset} ] $@"; }
exists_msg() { echo -e "[ ${boldYellow}EXISTS${reset} ] $@"; }
unlink_msg() { echo -e "[ ${boldRed}UNLINK${reset} ] $@"; }
info_msg()   { echo -e "[ ${boldCyan}INFO${reset}   ] $@"; }

# Base CLI items (included in all profiles)
CLI_ITEMS=(
  ".gitignore"
  ".gitconfig"
  ".bashrc"
  ".bash_aliases"
  ".bash_colors"
  ".zshrc"
  ".zshenv"
  ".zsh_aliases"
  ".tmux.conf"
  ".gemini/SYSTEM.md"
  ".gemini/GEMINI.md"
  ".config/nvim"
  ".config/yay"
  ".bin/gitstatus"
  ".bin/colortheme"
  ".bin/pokemon"
  ".bin/yayupdates"
)

# Desktop items (added to CLI items for default profile)
DESKTOP_ITEMS=(
  ".config/alacritty"
  ".config/sway"
  ".config/swayidle"
  ".config/waybar"
  ".config/dunst"
  ".config/wireplumber"
  ".config/fontconfig"
  ".bin/screenlock.sh"
  ".bin/bettertext.sh"
)

# macOS items (added to CLI items for mac profile)
MAC_ITEMS=(
  ".config/alacritty"
  ".config/aerospace"
)

# Union of all managed items across profiles
ALL_MANAGED_ITEMS=(
  "${CLI_ITEMS[@]}"
  "${DESKTOP_ITEMS[@]}"
  "${MAC_ITEMS[@]}"
)

# Remove duplicates from ALL_MANAGED_ITEMS
read -r -d '' -a ALL_MANAGED_ITEMS < <(printf '%s\n' "${ALL_MANAGED_ITEMS[@]}" | sort -u && printf '\0')

get_profile_items() {
  local prof=$1
  case "$prof" in
    cli)
      printf '%s\n' "${CLI_ITEMS[@]}"
      ;;
    default)
      printf '%s\n' "${CLI_ITEMS[@]}" "${DESKTOP_ITEMS[@]}"
      ;;
    mac)
      for item in "${CLI_ITEMS[@]}" "${MAC_ITEMS[@]}"; do
        if [[ "$item" != ".config/yay" ]]; then
          echo "$item"
        fi
      done
      ;;
    *)
      echo "Unknown profile: $prof" >&2
      echo "Available profiles: default, cli, mac" >&2
      exit 1
      ;;
  esac
}

makelink() {
  local lname=$1
  local src="$DOTFILES_DIR/$lname"
  local dest="$HOME/$lname"

  if [[ ! -e "$src" ]]; then
    return 0
  fi

  if [[ ! -e "$dest" && ! -L "$dest" ]]; then
    local parent_dir="${dest%/*}"
    if [[ ! -d "$parent_dir" ]]; then
      mkdir -p "$parent_dir"
    fi
    ln -s "$src" "$dest"
    create_msg "$dest -> $src"
  elif [[ -L "$dest" ]]; then
    local current_target
    current_target="$(readlink "$dest")"
    if [[ "$current_target" == "$src" ]]; then
      exists_msg "$dest"
    else
      ln -sf "$src" "$dest"
      create_msg "$dest -> $src (updated target)"
    fi
  else
    exists_msg "$dest (regular file/dir, skipping)"
  fi
}

unlink_item() {
  local lname=$1
  local src="$DOTFILES_DIR/$lname"
  local dest="$HOME/$lname"

  if [[ -L "$dest" ]]; then
    local current_target
    current_target="$(readlink "$dest")"
    if [[ "$current_target" == "$src" || "$current_target" == "$DOTFILES_DIR/$lname" ]]; then
      rm "$dest"
      unlink_msg "$dest"
    fi
  fi
}

show_status() {
  local active="unknown"
  if [[ -f "$PROFILE_FILE" ]]; then
    active="$(cat "$PROFILE_FILE")"
  fi
  info_msg "Active profile: $active"
  echo "Available profiles:"
  echo "  - default  : Linux Wayland desktop (Sway, Waybar, Alacritty, CLI tools)"
  echo "  - cli      : Headless / CLI-only setup (Shell, Neovim, Tmux, CLI tools)"
  echo "  - mac      : macOS setup (Shell, Neovim, Tmux, Alacritty, AeroSpace)"
}

# Subcommands
case "$1" in
  status|info)
    show_status
    exit 0
    ;;
  list)
    echo "Available profiles: default, cli, mac"
    exit 0
    ;;
  -h|--help|help)
    echo "Usage: $0 [profile|status|list]"
    echo "Profiles: default (default), cli, mac"
    exit 0
    ;;
esac

# Determine target profile
TARGET_PROFILE="$1"
if [[ -z "$TARGET_PROFILE" ]]; then
  if [[ -f "$PROFILE_FILE" ]]; then
    TARGET_PROFILE="$(cat "$PROFILE_FILE")"
  else
    TARGET_PROFILE="default"
  fi
fi

# Validate and get items for target profile
read -r -d '' -a TARGET_ITEMS < <(get_profile_items "$TARGET_PROFILE" && printf '\0')

info_msg "Applying profile: $TARGET_PROFILE"

# Build associative map for fast membership check
declare -A IS_TARGET_ITEM
for item in "${TARGET_ITEMS[@]}"; do
  IS_TARGET_ITEM["$item"]=1
done

# Unlink managed items that do not belong to the target profile
for item in "${ALL_MANAGED_ITEMS[@]}"; do
  if [[ -z "${IS_TARGET_ITEM[$item]}" ]]; then
    unlink_item "$item"
  fi
done

# Create links for target profile
for item in "${TARGET_ITEMS[@]}"; do
  makelink "$item"
done

# Configure git global excludesfile if .gitignore exists
if [[ -e "$HOME/.gitignore" ]]; then
  git config --global core.excludesfile "$HOME/.gitignore"
fi

# Ensure ~/.bin/dotprofile symlink exists so profile switcher is in $PATH
if [[ -d "$HOME/.bin" ]]; then
  ln -sf "$DOTFILES_DIR/makelinks.sh" "$HOME/.bin/dotprofile"
fi

# Persist active profile
echo "$TARGET_PROFILE" > "$PROFILE_FILE"
info_msg "Profile '$TARGET_PROFILE' applied successfully."
