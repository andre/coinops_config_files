class SingleMonitor < ConfigBase
  DESCRIPTION = "With this setting, you can constrain CoinOps to use only a single monitor, even if multiple monitors are connected. This is useful when you have multiple monitors but only want CoinOps to display on one of them, leaving the other(s) free for other purposes."
  OPTIONS = {
    enabled: "CoinOps will only use a single monitor, even if multiple monitors are connected.",
    disabled: "CoinOps will use multiple connected monitors if available. Secondary monitors will be taken over by CoinOps when running."
  }
  DEFAULT = "disabled"
  CATEGORY = "System"

  def set(val)
    case val
    when "enabled"
      set_conf "settings.conf", "screenOrder=0"
    when "disabled"
      set_conf "settings.conf", "screenOrder=0,1,2"
    end
  end

  def status
    (get_conf("settings.conf", "screenOrder") == "0") ? "enabled" : "disabled"
  end
end

class ZeroDelayEncoder < ConfigBase
  DESCRIPTION = "Makes a couple targeted adjustments to the system to work better with 'Zero Delay' controllers. This applies primarily to custom cabinet builds. If you have a standard XBox-type controller, or don't recognize 'Zero Delay', you can leave this configuration alone."
  OPTIONS = {
    enabled: "Works with 'Zero Delay' USB encoders.",
    disabled: "Works with kinds of controller interfaces, like PactoTech, Ipac, and most XInput controllers."
  }
  DEFAULT = "disabled"
  CATEGORY = "System"

  def set(val)
    case val
    when "enabled"
      set_conf "settings.conf", "collectionInputClear = yes"
      set_conf "settings.conf", "playlistInputClear = yes"
      set_conf "settings.conf", "jumpInputClear = yes"
    when "disabled"
      set_conf "settings.conf", "collectionInputClear = no"
      set_conf "settings.conf", "playlistInputClear = no"
      set_conf "settings.conf", "jumpInputClear = no"
    end
  end

  def status
    (get_conf("settings.conf", "collectionInputClear") == "yes") ? "enabled" : "disabled"
  end
end

# TODO: when would you recommend hardware acceleration be enabled?
class MenuHardwareAcceleration < ConfigBase
  DESCRIPTION = "Enable or disable hardware acceleration for the front end."
  OPTIONS = {
    enabled: "Turn on hardware acceleration. ",
    disabled: "Turn off hardware acceleration."
  }
  DEFAULT = "disabled"
  CATEGORY = "System"

  def set(val)
    case val
    when "enabled"
      set_conf "settings.conf", "HardwareVideoAccel=true"
    when "disabled"
      set_conf "settings.conf", "HardwareVideoAccel=false"
    end
  end

  def status
    (get_conf("settings.conf", "HardwareVideoAccel") == "true") ? "enabled" : "disabled"
  end
end

class MenuFPS < ConfigBase
  DESCRIPTION = "Set the Frames Per Second for the front end. Higher FPS will look smoother but consume more resources."
  OPTIONS = {
    "30": "Run the menu at 30 FPS.",
    "60": "Run the menu at 60 FPS.",
    "120": "Run the menu at 120 FPS."
  }
  DEFAULT = "120"
  CATEGORY = "System"

  def set(val)
    set_conf "settings.conf", "fps = #{val}"
  end

  def status
    get_conf("settings.conf", "fps") || DEFAULT
  end
end

class MenuFPSIdle < ConfigBase
  DESCRIPTION = "Set the Frames Per Second while the front end is idle."
  OPTIONS = {
    "30": "Limit idle frame rate to 30 FPS.",
    "60": "Limit idle frame rate to 60 FPS."
  }
  DEFAULT = "60"
  CATEGORY = "System"

  def set(val)
    set_conf "settings.conf", "fpsIdle = #{val}"
  end

  def status
    get_conf("settings.conf", "fpsIdle")
  end
end

# TODO: When would you advise someone to use opengl?
class VideoRendering < ConfigBase
  DESCRIPTION = "Choose the video renderer for the menu system."
  OPTIONS = {
    direct3d11: "Use the DirectX 11 renderer (modern default).",
    opengl: "Use the legacy renderer from the Direct3D/GL profile."
  }
  DEFAULT = "direct3d11"
  CATEGORY = "System"

  def set(val)
    set_conf "settings.conf", "SDLRenderDriver = #{val}"
  end

  def status
    get_conf("settings.conf", "SDLRenderDriver")
  end
end
