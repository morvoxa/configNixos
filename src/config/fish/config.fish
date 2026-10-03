if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a xi "sudo xbps-install -Sy"
    abbr -a xs "sudo xbps-query -Rs"
    abbr -a xrm "sudo xbps-remove -Rs"
    abbr -a xcl "sudo xbps-remove -OOo"
    abbr -a cmt "$HOME/dotfiles-v1/src/commit"
end
