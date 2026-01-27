class ControllerType < ConfigBase
  DESCRIPTION = "What kind of controller are you using? 'Arcade' is for cabinets with an arcade joystick and buttons. 'Gamepad' is for handheld controllers like Xbox or 8Bitdo."
  OPTIONS = {
    arcade: "For cabinets with an arcade joystick and buttons.",
    gamepad: "For handheld controllers like Xbox or 8Bitdo."
  }
  DEFAULT = "gamepad"

  SAMPLE_CFG = "emulators/mame/cfg/dstlk.cfg"

  def set(val)
    case val
    when "arcade"
      copy_matching "collections/_common/medium_artwork/SFarcadestick/*", "collections/_common/medium_artwork/controls"
      copy_matching "emulators/mame/cfgSFarcadestick/*", "emulators/mame/cfg"
    when "gamepad"
      copy_matching "collections/_common/medium_artwork/SFcontroller/*", "collections/_common/medium_artwork/controls"
      copy_matching "emulators/mame/cfgSFcontroller/*", "emulators/mame/cfg"
    end
  end

  def status
    return "arcade" if files_equal?(SAMPLE_CFG, "emulators/mame/cfgSFarcadestick/dstlk.cfg")
    "gamepad" if files_equal?(SAMPLE_CFG, "emulators/mame/cfgSFcontroller/dstlk.cfg")
  rescue Errno::ENOENT
    "gamepad"
  end
end

# Old settings file: settings12.conf
class QuitCoinops < ConfigBase
  DESCRIPTION = "Quit CoinOps via a controller button combo, or require using the ESC key on a keyboard."
  OPTIONS = {
    keyboard: "You can only exit CoinOps by pressing a key ('escape' by default) on an attached keyboard",
    kb_or_gamepad: "You can exit CoinOps with 'escape' on a keyboard, or by pressing Start + Select on your controller."
  }
  DEFAULT = "kb_or_gamepad"

  def set(val)
    case val
    when "keyboard"
      set_value "settings.conf", "controllerComboExit=false"
    when "kb_or_gamepad"
      set_value "settings.conf", "controllerComboExit=true"
    end
  end

  def status
    (get_value("settings.conf", "controllerComboExit") == "true") ? "kb_or_gamepad" : "keyboard"
  end
end
