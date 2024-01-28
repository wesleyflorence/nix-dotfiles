{ config, pkgs, ... }@args:

let
  username = args.user or "wesley";
  homeDirectory = args.homeDir or "/home/wesley";
  nvimDir = "${config.home.homeDirectory}/.config/dotfiles/nvim";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    #pkgs.neovim
    tmux
    #TODO needs symlinked to ~/Applications on Mac, maybe nix-darwin is needed
    kitty
    nix-search-cli
    fd
    bottom

    # fonts
    #TODO font not found when launching kitty
    fira-code-nerdfont

    # LaTeX
    texlive.combined.scheme-full
    entr
    zathura
    pandoc

    #TODO 1password?

    # Some Golang specific stuff I should move later
    go_1_21
    gofumpt
    gotools
    iferr
    quicktype
    revive
    flyctl
    tailwindcss
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wesley/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = { }; # This doesnt seem to work with gnome

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # ZSH
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

  initExtra = ''
    unsetopt beep                               # don't beep
    setopt hist_reduce_blanks                   # remove superfluous blanks
    source $HOME/.config/zsh/my_functions.zsh   # custom funcs
    source $HOME/.config/zsh/private_env.zsh    # secrets
    '' + (if pkgs.stdenv.isDarwin then ''
      # On MacOS this will help prevent updates from disabling Nix
      [[ ! $(command -v nix) && -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]] && source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    '' else ""
    );

    dotDir = ".config/zsh";

    shellAliases = { vim = "nvim"; };

    history = {
      size = 1000000;
      save = 1000000;
      ignoreDups = true;
      extended = true;
      share = true;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    prezto = {
      editor.keymap = "vi";
      enable = true;
      prompt.theme = "pure";
    };

    plugins = with pkgs; [{
      name = "zsh-abbr";
      src = fetchFromGitHub {
        owner = "olets";
        repo = "zsh-abbr";
        rev = "7caa26bf11009c144752f4f6dc6c6cde39da99b8";
        sha256 = "iKL2vn7TmQr78y0Bn02DgNf9DS5jZyh6uK9MzYTFZaA=";
      };
      file = "zsh-abbr.plugin.zsh";
    }];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs;
      [
        # This is more reliable than the builtin
        vimPlugins.nvim-treesitter.withAllGrammars
      ];

    extraPackages = with pkgs; [
      # languages
      nodejs
      cargo # for nix lsp

      # LSP
      nixfmt
      nil
    ];
  };

  # Creating a symlink to ~/.config/nvim so we can use normal lua
  xdg.configFile = {
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink nvimDir;
      recursive = true;
    };
  };
}
