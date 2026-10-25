# git, set up through Home Manager options instead of a raw file.
# (Both styles are fine: options when Home Manager has a module, a linked file otherwise.)
{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Salosch"; # ← your name for commits
      user.email = "Salim_Yildirim@gmx.de"; # ← your email (use GitHub's no-reply address if the repo is public)
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # GitHub CLI. Also makes `git push` to GitHub use the login from `gh auth login`.
  programs.gh.enable = true;
}
