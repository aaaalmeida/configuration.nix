My environment configurations for Linux distro [NixOS](https://nixos.wiki/wiki/Main_Page)

Remember to always commit and rebuild after an update
```
git add .
git commit
sudo nixos-rebuild switch
```

Also remember to try nix shell before install anything new. [Nix Store](https://search.nixos.org/packages)
```
nix-shell -p [package name]
```
