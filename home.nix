{ config, pkgs, ... }:

{
	home.username = "meiw";
	home.homeDirectory = "/home/meiw";
	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "sculptris";
				email = "2502068615@qq.com";
			};
		};
	};
	
	home.stateVersion = "26.05";
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use NixOS, btw";
		};
	};
	services.picom = {
		enable = true;
		backend = "glx";
	};
	programs.kitty.enable = true;
	stylix.targets.kitty.opacity.enable = true;
	stylix.targets.kitty.enable = true;
	stylix.opacity.terminal = 0.68;
	

}
