{ nixpkgs ? ../nixpkgs }:

let

  jobs = rec {

    build =
      { src ? {outPath = ./.; rev = 1234;}
      , officialRelease ? false
      }:

      with import nixpkgs { system = "i686-linux"; };

      let version = "2010.3" + (if officialRelease then "" else "-r"+toString src.rev) ;
      in
      releaseTools.antBuild {
        name = "hydra-ant-logger";
        inherit src;
        antProperties = [
          { name = "version"; value = version; }
        ];        
        jars = [ "hydra-ant-logger-${version}.jar" ];
        preConfigure = ''
          mkdir lib
        '';
      };

    };


in jobs
