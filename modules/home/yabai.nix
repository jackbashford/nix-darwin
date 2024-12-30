{ ... }:
{
  # Yabai needed to have the /etc/sudoers.d/yabai file removed before
  # it would play ball with the enableScriptingAddition option.
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      layout = "bsp";
      window_placement = "second_child";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      top_padding = 8;
      bottom_padding = 8;
      left_padding = 4;
      right_padding = 4;
      window_gap = 2;
    };
    extraConfig = ''
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      yabai --load-sa

      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^1Password$" manage=off
      yabai -m rule --add app="^Raycast$" manage=off

      yabai -m signal --add app='^Ghostty$' event=window_created action='yabai -m space --layout bsp'
      yabai -m signal --add app='^Ghostty$' event=window_destroyed action='yabai -m space --layout bsp'
    '';
    # yabai -m config external_bar all:26:0
  };
}
