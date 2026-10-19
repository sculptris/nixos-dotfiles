# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{config, lib, pkgs, ... }:
#let 
	#originalConfig = builtins.readFile ./config/dwm/config.def.h;
	#themedConfig = builtins.replaceStrings
	#[
		#''static const char col_gray1[]       = "#222222";''
		#''static const char col_gray2[]       = "#444444";''
		#''static const char col_gray3[]       = "#bbbbbb";''
		#''static const char col_gray4[]       = "#eeeeee";''
		#''static const char col_cyan[]        = "#005577";''
		#''static const char *fonts[]          = { "monospace:size=10" };''
#
	#]
	#[
		#''static const char col_gray1[]       = "#${config.lib.stylix.colors.base04}";''
		#''static const char col_gray2[]       = "#${config.lib.stylix.colors.base01}";''
		#''static const char col_gray3[]       = "#${config.lib.stylix.colors.base00}";''
		#''static const char col_gray4[]       = "#${config.lib.stylix.colors.base0D}";''
		#''static const char col_cyan[]        = "#${config.lib.stylix.colors.base0D}";''
		#''static const char *fonts[]          = { "${config.stylix.fonts.monospace.name}:size=10" };''
	#]
	#originalConfig;
	#dwmConfig = pkgs.writeText "dwm-config.h" themedConfig;
#in
{ 
  stylix = { 
   enable = true;
   autoEnable = false;
   base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
   image = ./wallpaper/1111.png;
   polarity = "light";
   fonts = {
	monospace = {
		package = pkgs.nerd-fonts.jetbrains-mono;
		name = "JetBrainsMono Nerd Font";
	};
   };
  };	

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  hardware.graphics.enable = true;
  networking.hostName = "nixos-btw"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  services.displayManager.ly = {
	enable = true;
	settings = {
		animation = "matrix";
		bigclock = true;
		bigclock_seconds = true;
		clear_password = true;
	};
  };
  
  # Enable the X11 windowing system.
  services.xserver = {
	enable = true;
	autoRepeatDelay = 200;
	autoRepeatInterval = 35;
	displayManager.sessionCommands = ''
		${pkgs.feh}/bin/feh --bg-fill /home/meiw/nixos-dotfiles/wallpaper/ebksauaie.png;
	'';
	windowManager.dwm = {
		enable = true;
		package = pkgs.dwm.overrideAttrs {
			src = ./config/dwm;
		};
		#package = pkgs.dwm.override {
			#conf = dwmConfig;
		#};
	};
	
  };

  
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.meiw = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    dmenu
    feh
  ];
  nix.settings = {
	experimental-features = [ "nix-command" "flakes" ];
  	substituters = [
		"https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
		"https://cache.nixos.org/"
	];
  };
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

