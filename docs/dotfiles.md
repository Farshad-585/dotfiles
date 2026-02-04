Dotfiles Management (Bare Git Repository Method)This guide documents the "Bare Repository" technique for tracking dotfiles (configurations) directly in the Home directory without symlinks.1. Initial Setup (Current Machine)Run these commands to initialize the tracking system on your current machine.Initialize the "Brain" (Bare Repo)# 1. Create the hidden folder for the git repository
git init --bare $HOME/.cfg

# 2. Create the alias for the current session
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# 3. Configure the "Safety Switch" (Ignore all files by default)
config config --local status.showUntrackedFiles no
Make the Alias PermanentAdd the alias to your shell configuration so it works in new terminal windows.echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc
Connect to GitHubconfig remote add origin <YOUR_GITHUB_REPO_URL>
config push -u origin main
2. Daily UsageUse the config command exactly like git.Check status: config statusTrack a new file: config add .zshrcSave changes: config commit -m "Update zshrc"Upload to GitHub: config pushUnstage a mistake: config restore --staged <filename>3. New Machine Setup (Restoration)Use these steps to apply your configurations to a brand new laptop.Prerequisites:Git is installed.SSH access to GitHub is configured.Step-by-Step Restore# 1. Clone the bare repository into the hidden folder
git clone --bare <YOUR_GITHUB_REPO_URL> $HOME/.cfg

# 2. Define the alias temporarily
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# 3. Apply configurations (Checkout)
config checkout
Troubleshooting "Checkout" ConflictsIf config checkout fails with an error like:error: The following untracked working tree files would be overwritten by checkout: .zshrcThis means the new OS already created a default version of that file. You must delete or move it:rm .zshrc
config checkout
Finalize SetupOnce checkout succeeds, hide the untracked files again:config config --local status.showUntrackedFiles no
Restart your terminal to load your restored .zshrc.
