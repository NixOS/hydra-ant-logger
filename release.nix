{ nixpkgs ? ../../src/nixpkgs }:

let

  jobs = rec {

    build =
      { src ? {outPath = ./.; rev = 1234;}
      , officialRelease ? false
      }:

      with import nixpkgs { system = "i686-linux"; };

      let version = "2010.2" + (if officialRelease then "" else "-r"+toString src.rev) ;
      in
      releaseTools.antBuild {
        name = "hydra-ant-logger";
        inherit src;
        antProperties = [
          { name = "version"; value = version; }
        ];        
        inherit jre ant;
        buildInputs = [jre ant]; 
        jars = [ "hydra-ant-logger-${version}.jar" ];
      };

    };


in jobs
