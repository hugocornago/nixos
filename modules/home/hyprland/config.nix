{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";

      monitor = [",preferred,auto,auto"];
      # autostart
      exec-once = [
        "systemctl --user import-environment &"
        "hash dbus-update-activation-environment 2>/dev/null &"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"

        "nm-applet &"
        # "poweralertd &"
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
        "waybar &"
        "swaync &"
        "~/.local/bin/poe-scroll &"
        "hyprctl setcursor Bibata-Modern-Ice 24 &"
        "swww-daemon &"

        "hyprlock"

        ## App auto start
        # "[workspace 1 silent] zen"
        # "[workspace 2 silent] kitty"
      ];

      input = {
        kb_layout = "us,us";
        kb_variant = "colemak,";
        kb_options = "caps:escape";
        numlock_by_default = true;
        follow_mouse = 0;
        float_switch_override_focus = 0;
        mouse_refocus = 0;
        sensitivity = 0;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
        };
      };

      general = {
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgb(A89984)";
        "col.inactive_border" = "0x00000000";
      };

      debug = {
        full_cm_proto = true;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = false;
        focus_on_activate = true;
        middle_click_paste = true;
      };

      dwindle = {
        force_split = 2;
        preserve_split = true;
        use_active_for_splits = true;
      };

      master = {
        new_status = "master";
      };

      decoration = {
        rounding = 0;
        # active_opacity = 0.90;
        # inactive_opacity = 0.90;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;

          offset = "0 2";
          range = 20;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];

        animation = [
          # name, enable, speed, curve, style

          # Windows
          "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
          "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
          "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
          "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
          "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
          # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
          # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      xwayland = {
        force_zero_scaling = true;
      };

      bind = [
        # show keybinds list
        "$mainMod, F1, exec, show-keybinds"

        # keybindings
        "$mainMod, Return, exec, kitty"
        "$mainMod SHIFT, Return, exec, [fullscreen] kitty"
        "$mainMod, B, exec, hyprctl dispatch exec '[workspace 2 silent] zen-beta'"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fullscreen, 1"
        "$mainMod, Space, exec, toggle_float"
        "$mainMod, R, exec, rofi -show drun || pkill rofi"
        "$mainMod, D, exec, ~/.local/bin/vesktop-hw"
        "$mainMod SHIFT, S, exec, hyprctl dispatch exec '[workspace 5 silent] SoundWireServer'"
        # "$mainMod, Escape, exec, swaylock"
        # "ALT, Escape, exec, hyprlock"
        "$mainMod SHIFT, Escape, exec, power-menu"
        "$mainMod, P, pseudo,"
        "$mainMod, X, togglesplit,"
        "$mainMod, T, exec, toggle_oppacity"
        ",F9, exec, ~/.local/autoclicker"
        # "$mainMod CTRL, E, exec, nemo"
        # "$mainMod, E, exec, hyprctl dispatch exec '[float; center; size 1111 700] nemo'"
        "$mainMod SHIFT, B, exec, toggle_waybar"
        "$mainMod, C ,exec, hyprpicker -a"
        # "$mainMod, W,exec, wallpaper-picker"
        "$mainMod, W, killactive"
        "$mainMod SHIFT, W,exec, hyprctl dispatch exec '[float; center; size 925 615] waypaper'"
        # "$mainMod, N, exec, swaync-client -t -sw"
        # "$mainMod SHIFT, W, exec, vm-start"

        # screenshot
        ",Print, exec, screenshot --copy"
        "$mainMod, Print, exec, screenshot --save"
        "$mainMod SHIFT, Print, exec, screenshot --swappy"

        # switch focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"

        # switch workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # same as above, but switch to the workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        "$mainMod CTRL, c, movetoworkspace, empty"

        # window control
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, n, movewindow, l"
        "$mainMod SHIFT, e, movewindow, d"
        "$mainMod SHIFT, i, movewindow, u"
        "$mainMod SHIFT, o, movewindow, r"

        "$mainMod CTRL, left, resizeactive, -80 0"
        "$mainMod CTRL, right, resizeactive, 80 0"
        "$mainMod CTRL, up, resizeactive, 0 -80"
        "$mainMod CTRL, down, resizeactive, 0 80"
        "$mainMod CTRL, n, resizeactive, -80 0"
        "$mainMod CTRL, e, resizeactive, 0 80"
        "$mainMod CTRL, i, resizeactive, 0 -80"
        "$mainMod CTRL, o, resizeactive, 80 0"

        "$mainMod ALT, left, moveactive,  -80 0"
        "$mainMod ALT, right, moveactive, 80 0"
        "$mainMod ALT, up, moveactive, 0 -80"
        "$mainMod ALT, down, moveactive, 0 80"
        "$mainMod ALT, n, moveactive,  -80 0"
        "$mainMod ALT, e, moveactive, 0 80"
        "$mainMod ALT, i, moveactive, 0 -80"
        "$mainMod ALT, o, moveactive, 80 0"

        # media and volume controls
        ",XF86AudioMute,exec, pamixer -t"
        ",F6,exec, ~/.local/bin/volume down 5"
        ",F7,exec, ~/.local/bin/volume up 5"
        ",F12,exec, ~/.local/bin/volume sink"
        #",XF86AudioPlay,exec, playerctl play-pause"
        #",XF86AudioNext,exec, playerctl next"
        #",XF86AudioPrev,exec, playerctl previous"
        #",XF86AudioStop,exec, playerctl stop"

        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        # clipboard manager
        "$mainMod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"
      ];

      # # binds active in lockscreen
      # bindl = [
      #   # laptop brigthness
      #   ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      #   ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      #   "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
      #   "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      # ];

      # # binds that repeat when held
      # binde = [
      #   ",XF86AudioRaiseVolume,exec, pamixer -i 2"
      #   ",XF86AudioLowerVolume,exec, pamixer -d 2"
      # ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "match:class ^(imv)$, float on"
        "match:class ^(mpv)$, float on"
        "match:class ^(zenity)$, float on"
        "match:class ^(waypaper)$, float on"
        "match:class ^(SoundWireServer)$, float on"
        "match:class ^(.sameboy-wrapped)$, float on"
        "match:class ^(org.gnome.Calculator)$, float on"
        "match:class ^(org.gnome.FileRoller)$, float on"
        "match:class ^(org.pulseaudio.pavucontrol)$, float on"

        "match:class ^(rofi)$, pin on"
        "match:class ^(waypaper)$, pin on"

        "match:class ^(Aseprite)$, tile on"

        "match:class ^(zenity)$, size 850 500"
        "match:class ^(SoundWireServer)$, size 725 330"

        "match:title ^(Volume Control)$, size 700 450"
        "match:title ^(Volume Control)$, move 40 55%"

        "match:title ^(Picture-in-Picture)$, pin on"
        "match:title ^(Picture-in-Picture)$, float on"

        "match:class ^(zen-beta)$, workspace 1"
        "match:class ^(Gimp-2.10)$, workspace 4"
        "match:class ^(Aseprite)$, workspace 4"
        "match:class ^(Audacious)$, workspace 5"
        "match:class ^(Spotify)$, workspace 5"
        "match:class ^(com.obsproject.Studio)$, workspace 8"
        "match:class ^(discord)$, workspace 10"
        "match:class ^(WebCord)$, workspace 10"
        "match:class ^(vesktop)$, workspace 10"

        "match:class ^(mpv)$, idle_inhibit focus"
        "match:class ^(zen-beta)$, match:title ^(.*YouTube.*)$, idle_inhibit focus"
        "match:class ^(zen)$, idle_inhibit fullscreen"

        "match:class ^(xdg-desktop-portal-gtk)$, dim_around on"

        "match:xwayland true, rounding 0"

        # No gaps when only
        "border_size 0, match:float 0, match:workspace w[tv1]"
        "rounding 0, match:float 0, match:workspace w[tv1]"
        "border_size 0, match:float 0, match:workspace f[1]"
        "rounding 0, match:float 0, match:workspace f[1]"
      ];

      layerrule = [
        "match:namespace rofi, dim_around on"
        "match:namespace swaync-control-center, dim_around on"
      ];

      # No gaps when only
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
    };
  };
}
