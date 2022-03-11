#!/bin/bash
# Although it is put to the end, the lines coming before assume TPM is installed or
# at least is to be

TMUXCONFFILE="$HOME""/.tmux.conf"

if [ ! -z $1 ]; then
  echo "Custom tmux config file provided"
  TMUXCONFFILE="$1"
fi

if [ -f $1 ]; then
  BAKDATE=$(date '+%Y-%m-%d_%H-%M-%S')
  BACKFILENAME="${TMUXCONFFILE}""__""${BAKDATE}"
  echo "The config file seems to already exists, backing it up as""${BACKFILENAME}"
  mv ${TMUXCONFFILE} ${BACKFILENAME}
  echo
fi

declare -a CONFLINES=()
# Tmux Theme Packs
if [ -d ~/.tmux-themepack ]; then
  echo "The Themepack files were detected on the system, proceeding to reclone"
  rm -rf ~/.tmux-themepack
fi
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
echo

# Enabling Mouse mode
CONFILNES+=("# Enabling Mouse mode")
CONFLINES+=("set -g mouse on")

# Some basic plugins
CONFLINES+=("# Some basic plugins ...")
CONFLINES+=("set -g @plugin 'tmux-plugins/tpm'")
CONFLINES+=("set -g @plugin 'tmux-plugins/tmux-sensible'")

# Theme pack config append to  tmux conf file
CONFLINES+=("# Tmux Themepack Block Cyan Profile")
CONFLINES+=("set -g @plugin 'jimeh/tmux-themepack'")
CONFLINES+=("set -g @themepack 'powerline/block/cyan'")

# Tmux Resurect
CONFLINES+=("# Tmux Resurrect and Continuum")
CONFLINES+=("set -g @plugin 'tmux-plugins/tmux-resurrect'")

# Tmux Continuum
CONFLINES+=("set -g @plugin 'tmux-plugins/tmux-continuum'")

# Cloning Tmux Plugin Manager
if [ -d ~/.tmux/plugins/tpm ]; then
  echo "The TPM files were detected on the system, proceeding to reclone"
  rm -rf ~/.tmux/plugins/tpm
fi
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo

# TPM Bottom file config
CONFLINES+=("# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)")
CONFLINES+=("run -b '~/.tmux/plugins/tpm/tpm'")

echo "Writing to file: ${TMUXCONFFILE}"
for CONFLINE in "${CONFLINES[@]}"; do
  echo "$CONFLINE" >> $TMUXCONFFILE
done

echo "Sourcing the config file ..."
tmux source $TMUXCONFFILE
echo "done"
