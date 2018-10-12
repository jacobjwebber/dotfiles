# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget vim
    wget firefox
    wget chromium
    
    #haskellPackages.xmonadContrib
    #haskellPackages.xmonadExtras
    ghc
    cabal-install
    ocaml
    opam
    gnum4
    unzip
    gcc
    clang
    tree
    binutils-unwrapped
    racket
    python3

    killall
    

    dmenu
    xscreensaver
    xclip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  #services.xserver.layout = "gb";
  #services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  #services.xserver.libinput.enable = true;

  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    gnome3 = {
      tracker.enable = false; # I don't use tracker
      gnome-keyring.enable = true;
    };
    
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "gb";
      libinput.enable = true;

      # Gnome desktop
      # * Slightly more familiar than KDE for people who are used to working with Ubuntu
      # * Gnome3 works out of the box with xmonad
      desktopManager = {
        gnome3.enable = true;
        default = "gnome3";
      };
  
      # Enable XMonad Desktop Environment. (Optional)
      windowManager = {
        xmonad.enable = true; 
        xmonad.enableContribAndExtras = true;
      };
    };
  };

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  # Allow nonfree
  nixpkgs.config.allowUnfree = true;
  
  # Bash prompt
  programs.bash.promptInit =
  ''
  # Provide a nice prompt if the terminal supports it.
if [ "$TERM" != "dumb" -o -n "$INSIDE_EMACS" ]; then
  PROMPT_COLOR="1;31m"
  let $UID && PROMPT_COLOR="1;32m"
  PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
  if test "$TERM" = "xterm"; then
    PS1="\[\033]2;\h:\u:\w\007\]$PS1"
  fi
fi
'';

  # Audio
  hardware.pulseaudio.enable = true;
  sound.mediaKeys = {
    enable = true;
    volumeStep = "5%";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jjw = {
    name = "jjw";
    extraGroups = [
      "wheel" "disk" "networkmanager" "systemd-journal"
    ];
    createHome = true;
    home = "/home/jjw";
    isNormalUser = true;
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
