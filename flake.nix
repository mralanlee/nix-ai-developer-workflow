{
  description = "Simple Node.js/Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, nixpkgs-python }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
 
        pythonVersion = "3.13.4";

        # This is dev python so it doesn't collide with system python
        devPython = nixpkgs-python.packages.${system}.${pythonVersion};

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # add packages from https://search.nixos.org/packages
            nodejs_20
            nodePackages.npm
            nodePackages.typescript-language-server
            devPython
          ];

          shellHook = ''

            # Claude Code configuration
            export ANTHROPIC_MODEL="claude-sonnet-4-20250514"

            # Cleanup function for shell exit
            cleanup_mcp_servers() {
              echo "Cleaning up MCP servers..."
              claude mcp remove playwright 2>/dev/null || true
              echo "MCP servers removed"
            }

            # Register cleanup function to run on shell exit
            trap cleanup_mcp_servers EXIT


            # Add Playwright MCP server
            echo "Adding Playwright..."
            claude mcp add playwright npx @playwright/mcp@latest

            echo "Claude Code configured with model: $ANTHROPIC_MODEL"
            echo "Node version: $(python --version)"
            echo "Node version: $(node --version)"
            echo "NPM version: $(npm --version)"
          '';
        };
      }
    );
}
