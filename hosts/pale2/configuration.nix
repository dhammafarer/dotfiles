# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_9;

  # boot.kernelParams = [ "snd-intel-dspcfg.dsp_driver=2" ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = {
    #sync.enable = true;
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };


  networking.hostName = "pale2"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Taipei";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_TW.UTF-8";
    LC_IDENTIFICATION = "zh_TW.UTF-8";
    LC_MEASUREMENT = "zh_TW.UTF-8";
    LC_MONETARY = "zh_TW.UTF-8";
    LC_NAME = "zh_TW.UTF-8";
    LC_NUMERIC = "zh_TW.UTF-8";
    LC_PAPER = "zh_TW.UTF-8";
    LC_TELEPHONE = "zh_TW.UTF-8";
    LC_TIME = "zh_TW.UTF-8";
  };

  services.tailscale.enable = true;

  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
    };

    desktopManager.gnome.enable = true;

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };

  services.displayManager.defaultSession = "none+awesome";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.enableAllFirmware = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.support32Bit = false;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pl = {
    isNormalUser = true;
    description = "pl";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBFOyIzj48/XjyTC9B6HL7oxkIcGtxNgCaSpje+lldrlqb1Vmo2KGdlkHFSSDYkvOYzNgoE9ywKi7kYrvUXJ4SXhtqKu1VmYzYY8o2/aCgMY3Y1qmgCAvDsgec1imL3mCdCO447Iim+ckmlrAboSK8zBEGvBrEI2PMKLAStFf6zycJ4vJA94778GxpcA25g6mp/WHsKp1QvELLl/mL3I9z+SDoCSR7BK2vu6xgQfuJP+BepKzlHpZlpZF4OkGi9VAEsNxjSV0QbFTsL0Q04hrySzGi39b0eRe1AvWo/jFCtzS9BqM78NI4Ii8PP3PL3UUXgctqDwiLhSZaYVvFMR13LjJW1W1qe1KXbum6Q4+/YlWAaJ9322035aZRq0NzQgmZbC6wvcQDBVQru6NcZy1nnCGwJ77mLPm+nM+XIA5JzsBNCnMVVpa/tmC28fPbe0Z6tkJNeU53sCv5rQDg/kVagrZ2RP5Renf4PzJx8ps8ew8Q31nKXZcZ/Qb1eBFgqVubmvUGXC1C6RlfhkWOX/0oBsp7nI9nDeqa7wNJBJ29TMr/LQ6m1ZzblFZY91n2EsSGxM7RbBWTY2FS6xwXgM+AIdBNrU1Kn6F2mhlcuzGSbfQnLCEtr5HRxItJSu6XGx11Ps79yXHWbFai84V9777Xz8WftAeRoEcBixDrNXJmsw== cardno:15_196_430"
    ];
  };

  users.groups.ygt.gid = 1000;
  users.users.ygt = {
    group = "ygt";
    isNormalUser = true;
    description = "ygt";
    extraGroups = [ "users" "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBFOyIzj48/XjyTC9B6HL7oxkIcGtxNgCaSpje+lldrlqb1Vmo2KGdlkHFSSDYkvOYzNgoE9ywKi7kYrvUXJ4SXhtqKu1VmYzYY8o2/aCgMY3Y1qmgCAvDsgec1imL3mCdCO447Iim+ckmlrAboSK8zBEGvBrEI2PMKLAStFf6zycJ4vJA94778GxpcA25g6mp/WHsKp1QvELLl/mL3I9z+SDoCSR7BK2vu6xgQfuJP+BepKzlHpZlpZF4OkGi9VAEsNxjSV0QbFTsL0Q04hrySzGi39b0eRe1AvWo/jFCtzS9BqM78NI4Ii8PP3PL3UUXgctqDwiLhSZaYVvFMR13LjJW1W1qe1KXbum6Q4+/YlWAaJ9322035aZRq0NzQgmZbC6wvcQDBVQru6NcZy1nnCGwJ77mLPm+nM+XIA5JzsBNCnMVVpa/tmC28fPbe0Z6tkJNeU53sCv5rQDg/kVagrZ2RP5Renf4PzJx8ps8ew8Q31nKXZcZ/Qb1eBFgqVubmvUGXC1C6RlfhkWOX/0oBsp7nI9nDeqa7wNJBJ29TMr/LQ6m1ZzblFZY91n2EsSGxM7RbBWTY2FS6xwXgM+AIdBNrU1Kn6F2mhlcuzGSbfQnLCEtr5HRxItJSu6XGx11Ps79yXHWbFai84V9777Xz8WftAeRoEcBixDrNXJmsw== cardno:15_196_430"
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  # yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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

  virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    awesome
    git
    gitui
    gnupg
    neovim
    picom
    rsync
    sxhkd
    wget
    xorg.xrandr
    xorg.xmodmap
    xscreensaver
    zsh
    docker-compose
    pavucontrol
    sof-firmware
    alsa-firmware
    alsa-lib
    alsa-oss
    alsa-tools
    alsa-topology-conf
    alsa-ucm-conf
    alsa-plugins
    alsa-utils
    libnotify
  ];
}
