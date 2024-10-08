# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
imports = [ # Include the results of the hardware scan.
./hardware-configuration.nix
];

# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Enable unfree packages
nixpkgs.config.allowUnfree = true;
nixpkgs.config.allowUnfreePredicate = true;

# Enable experimental features
nix.settings.experimental-features = [
"nix-command"
"flakes"
];

# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
vscode
git
opera
android-studio
nodejs_22
jdk21_headless
python3
spotify  
neofetch
tmux
htop
zenith
];

# Enable bluetooth
hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = false; # power up default bluetooth controller on boot

# Enable networking
networking.networkmanager.enable = true;

# tmux (terminal splitter) configuration 
programs.tmux = {
enable = true;
extraConfig = ''
	set -g @plugin 'tmux-plugins/tmp'
	set -g @plugin 'dracula/tmux'

	set -g @dracula-show-left-icon "aaalmeida"
	set -g @dracula-show-fahrenheit false
	set -g @dracula-show-location false

	run '~/.tmux/plugins/tpm/tpm' 
'';
};  

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.aaalmeida = {
isNormalUser = true;
description = "aaalmeida";
extraGroups = [ "networkmanager" "wheel" ];
packages = with pkgs; [
kdePackages.kate
#  thunderbird
];
};

# Enable the KDE Plasma Desktop Environment.
services.displayManager.sddm.enable = true;
services.desktopManager.plasma6.enable = true;

# Set your time zone.
time.timeZone = "America/Sao_Paulo";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

i18n.extraLocaleSettings = {
LC_ADDRESS = "pt_BR.UTF-8";
LC_IDENTIFICATION = "pt_BR.UTF-8";
LC_MEASUREMENT = "pt_BR.UTF-8";
LC_MONETARY = "pt_BR.UTF-8";
LC_NAME = "pt_BR.UTF-8";
LC_NUMERIC = "pt_BR.UTF-8";
LC_PAPER = "pt_BR.UTF-8";
LC_TELEPHONE = "pt_BR.UTF-8";
LC_TIME = "pt_BR.UTF-8";
};

# Configure keymap
# brazilian keyboard abnt2
# allow accent keys
services.xserver = {
enable = true;
xkb.layout = "br";
xkb.variant = "abnt2";
};

# Enable CUPS to print documents.
services.printing.enable = true;

# Enable autodiscovery of network printers
services.avahi = {
enable = true;
nssmdns4 = true;
openFirewall = true;
};

# Ajust touchpad scrolling
services.libinput.touchpad.naturalScrolling = true;

# Enable sound with pipewire.
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
enable = true;
alsa.enable = true;
alsa.support32Bit = true;
pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
};

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "24.05"; # Did you read the comment?

}
