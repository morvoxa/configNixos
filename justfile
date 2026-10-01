default:
		@just --list
os:
		sudo nixos-rebuild switch --flake .
