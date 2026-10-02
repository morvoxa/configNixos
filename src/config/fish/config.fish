if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a l "lsd -la"
    abbr -a hx "helix"
    abbr -a cmt "$HOME/configNixos/src/commit"
		devenv hook fish --no-tui | source
end
