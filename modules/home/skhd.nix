{ ... }:
{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt - t: open -a /Applications/Ghostty.app

      alt - y: yabai -m window --toggle float

      shift + alt - h: yabai -m window --warp west
      shift + alt - j: yabai -m window --warp south
      shift + alt - k: yabai -m window --warp north
      shift + alt - l: yabai -m window --warp east

      alt - 1: yabai -m space --focus 1
      alt - 2: yabai -m space --focus 2
      alt - 3: yabai -m space --focus 3
      alt - 4: yabai -m space --focus 4
      alt - 5: yabai -m space --focus 5
      alt - 6: yabai -m space --focus 6
      alt - 7: yabai -m space --focus 7

      shift + alt - 1: yabai -m window --space 1
      shift + alt - 2: yabai -m window --space 2
      shift + alt - 3: yabai -m window --space 3
      shift + alt - 4: yabai -m window --space 4
      shift + alt - 5: yabai -m window --space 5
      shift + alt - 6: yabai -m window --space 6
      shift + alt - 7: yabai -m window --space 7

      alt - f : yabai -m window --toggle zoom-fullscreen
    '';
  };
}
