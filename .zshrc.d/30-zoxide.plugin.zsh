: <<'END'
z foo        # cd into highest ranked directory matching foo
z foo bar    # cd into highest ranked directory matching foo and bar

z ~/foo      # z also works like a regular cd command
z foo/       # cd into relative path
z ..         # cd one level up
z -          # cd into previous directory

zi foo       # cd with interactive selection (using fzf)
END

eval "$(zoxide init zsh)"
alias cd="__zoxide_z"
