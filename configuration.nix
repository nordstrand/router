{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./grafana.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; 

  # Enable serial output
  boot.kernelParams = [
    "console=ttyS0,115200"
  ];


  networking.hostName = "router"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  xdg.sounds.enable = false;
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     thunderbird
  #   ];
  # };

  environment.systemPackages = with pkgs; [
     vim 
     git
     htop                # to see the system load
     ppp                 # for some manual debugging of pppd
     ethtool             # manage NIC settings (offload, NIC feeatures, ...)
     tcpdump             # view network traffic
     conntrack-tools     # view network connection states
  ];


  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  nordstrand = {
    grafana.enable = true;
  };

  nix = {
    gc.automatic = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  #Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

