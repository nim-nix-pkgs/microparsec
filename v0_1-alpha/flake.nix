{
  description = ''A performant Nim parsing library built for humans.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-microparsec-v0_1-alpha.flake = false;
  inputs.src-microparsec-v0_1-alpha.ref   = "refs/tags/v0.1-alpha";
  inputs.src-microparsec-v0_1-alpha.owner = "schneiderfelipe";
  inputs.src-microparsec-v0_1-alpha.repo  = "microparsec";
  inputs.src-microparsec-v0_1-alpha.type  = "github";
  
  inputs."result".owner = "nim-nix-pkgs";
  inputs."result".ref   = "master";
  inputs."result".repo  = "result";
  inputs."result".dir   = "master";
  inputs."result".type  = "github";
  inputs."result".inputs.nixpkgs.follows = "nixpkgs";
  inputs."result".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-microparsec-v0_1-alpha"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-microparsec-v0_1-alpha";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}