{
	description = "NisOS from Scratch";
	
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
		hame-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix = {
			url = "github:danth/stylix/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		#gruxbox-material-schema = {
			#url = "github:MayushKumar/base16-gruvbox-material-scheme";
			#flake = false;
		#};
	};

	outputs = {self,nixpkgs,home-manager,stylix, ... }@inputs: {
		nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			#specialArgs = { inherit inputs;};
			modules = [
				stylix.nixosModules.stylix
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;

						users.meiw = import ./home.nix;
						backupFileExtension = "backup";		
					};
				}
			];
		};
	};
}
