{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ../common
  ]

  # User account.
  users.users.ahnafrafi = {
    isNormalUser = true;
    description = "Ahnaf Rafi";
    extraGroups = [ "networkmanager" "wheel" ];
  };


  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Programs:
  # Regreet greeter for greetd.
  programs.regreet.enable = true;

  # Hyprland compositor.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; [
    foot
    kitty
    waybar
    hyprpaper
    pcmanfm
  ];

  # List of services.
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable dbus.
      services.dbus.enable = true;
  services.dbus.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable CPU temperature management by thermald
  services.thermald.enable = true;

  # Enable tlp powermanagement
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      # Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };
}
