{
  description = "OS config";

  inputs = {
    nixpgs.url = "github:NixOs/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, ...}:
  let
    lib = nixpkgs.lib;
    hardware_path = (./hardware + "/${
      let dev = builtins.readFile ./cur_hardware; 
      in 
        if dev=="" then throw "'cur_hardware'has been set" 
        else dev
      }/load_hardware.nix");
  in{
    nixosConfigurations = {
      fekete = lib.nixosSystem{
        system = "x86_64-linux";
      	modules = [ 
	        ./configurations/fekete/configuration.nix
          hardware_path
        ];
      };
    };
  };
}
