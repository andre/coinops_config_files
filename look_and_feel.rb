class AttractModeJoystick < ConfigBase
  DESCRIPTION = "Whether or not to show an animated joystick graphic in the game menus when idle. If enabled, the joystick will show every 30 seconds."
  OPTIONS = {
    enabled: "Enable the animated joystick graphic",
    disabled: "Disable the animated joystick graphic"
  }
  DEFAULT = "disabled"

  def set(val)
    if val == "enabled"
      copy "layouts/Arcades/images/joystickx.png", "layouts/Arcades/images/joystick.png"
    else
      remove "layouts/Arcades/images/joystick.png"
    end
  end

  def status
    exist?("layouts/Arcades/images/joystick.png") ? "enabled" : "disabled"
  end
end

# Old settings file: settings4.conf
class StartPosition < ConfigBase
  DESCRIPTION = "What do you want CoinOps to show when it first starts up?"
  OPTIONS = {
    random: "Starts on a random game, on a random playlist",
    consistent: "Always starts on the same game. Which game that is depends on how you're starting CoinOps (with or without playlists, consoles enabled, etc). With this setting, you can also go into settings.conf and specify a particular starting playlist."
  }
  DEFAULT = "random"

  def set(val)
    case val
    when "random"
      set_value "settings.conf", "randomStart = true"
    when "consistent"
      set_value "settings.conf", "randomStart = false"
    end
  end

  def status
    (get_value("settings.conf", "randomStart") == "true") ? "random" : "consistent"
  end
end

class AttractModeAutoscroll < ConfigBase
  DESCRIPTION = "Whether or not to scroll among games when the system sits idle - and if so, how long to wait before scrolling to the next game. If disabled, it will stay on the current game indefinitely."
  OPTIONS = {
    "30": "Scroll to a new game every 30 seconds",
    "60": "Scroll to a new game every 60 seconds",
    "90": "Scroll to a new game every 90 seconds",
    "120": "Scroll to a new game every 120 seconds",
    "195": "Scroll to a new game every 195 seconds",
    "disabled": "Do not auto-scroll to a new game"
  }
  DEFAULT = "90"

  def set(val)
    case val
    when "30"
      # copy_stuff
      remove("layouts/Arcades/attract.txt")
      set_value "settings.conf", '
        attractModeTime = 30
        attractModeNextTime = 30
      '
    when "60"
      # copy_stuff
      remove "layouts/Arcades/attract.txt"
      set_value "settings.conf", '
        attractModeTime	= 60
        attractModeNextTime = 60
      '
    when "90"
      # copy_stuff
      remove "layouts/Arcades/attract.txt"
      # in the bat files, we remove settings1.conf entirely to make the settings.conf settings take effect.
      # It's clearer to just set the values explicitly here.
      set_value "settings.conf", '
        attractModeTime	= 90
        attractModeNextTime = 90
      '
    when "120"
     #  copy_stuff
      remove "layouts/Arcades/attract.txt"
      set_value "settings.conf", '
        attractModeTime	= 120
        attractModeNextTime = 120
      '
    when "195"
      # copy_stuff
      copy("autochanger/settings.txt", "layouts/Arcades/attract.txt")
      set_value "settings.conf", '
        attractModeTime	= 195
        attractModeNextTime = 195
      '
    when "disabled"
      # copy_stuff
      remove "layouts/Arcades/attract.txt"
      set_value "settings.conf", '
      attractModeTime	= 0
      attractModeNextTime = 0
      '
    end
  end

  def status
    val = get_value "settings.conf", "attractModeTime"
    (val == "0") ? "disabled" : val
  end

  private

  # TODO: is this needed? The bats had it, but, at least in the micro build, these zzzSettings files don't exist.
  def copy_stuff
    copy "collections/zzzSettings/medium_artwork/logo/zz Attract Off.png", "collections/zzzSettings/medium_artwork/logo/zz Attract.png"
    copy "collections/zzzSettings/medium_artwork/Aura/zz Attract Off.png", "collections/zzzSettings/medium_artwork/Aura/zz Attract.png"
    copy "collections/zzzSettings/medium_artwork/marquee/zz Attract Off.png", "collections/zzzSettings/medium_artwork/marquee/zz Attract.png"
    copy "collections/zzzSettings/medium_artwork/marqueeCAB/zz Attract Off.png", "collections/zzzSettings/medium_artwork/marqueeCAB/zz Attract.png"
    copy "collections/zzzSettings/medium_artwork/video/zz Attract Off.png", "collections/zzzSettings/medium_artwork/video/zz Attract.png"
    copy "collections/zzzSettings/medium_artwork/videoPlayer/zz Attract Off.png", "collections/zzzSettings/medium_artwork/videoPlayer/zz Attract.png"
    copy "collections/zzzSettings/medium_artwork/videoSD/zz Attract Off.png", "collections/zzzSettings/medium_artwork/videoSD/zz Attract.png"
  end
end

class AttractModeFastScroll < ConfigBase
  DESCRIPTION = "TODO: What does attractModeFast do?"
  OPTIONS = {
    "enabled": "Fast mode enabled",
    "disabled": "Fast mode disabled"
  }
  DEFAULT = "disabled"

  def set(val)
    case val
    when "enabled"
      remove "layouts/Arcades/attract.txt"
      set_value "settings.conf", '
        attractModeFast = yes
        attractModeMinTime = 1400
        attractModeMaxTime = 4600
      '
    when "disabled"
      copy("autochanger/settings.txt", "layouts/Arcades/attract.txt")      
      set_value "settings.conf", '
        attractModeFast = no
        attractModeMinTime = 400
        attractModeMaxTime = 2600    
      '
    end
  end

  def status
    val = get_value "settings.conf", "attractModeFast"
    (val == "yes") ? "enabled" : "disabled"
  end
end


class GameMetadataDisplay < ConfigBase
  DESCRIPTION = "With this setting you can see metadata about each game (manufacturer, year, control type, number of players) displayed on the game selection menu. There are options for how much metadata to show, and where it appears on the screen. Note this setting applies to the MAIN screen (there are other settings for the 2nd/marquee screen if you have one)."
  OPTIONS = {
    none: "Do not show any game metadata.",
    some: "Just the manufacturer and year, displayed at the lower left of the game menu.",
    more: "Manufacturer, year, and control type (4-way/8-way joystick), displayed at the lower left of the game menu.",
    all_top: "Full metadata (manufacturer, year, control type, # players) displayed at the top right of the game menu.",
    all_bottom: "Full metadata (manufacturer, year, control type, # players) displayed at the bottom right of the game menu."
  }
  DEFAULT = "none"

  LAYOUTS = {
    "some" => "layouts/Arcades/layout - 6_0.xml",
    "more" => "layouts/Arcades/layout - 6_4.xml",
    "all_top" => "layouts/Arcades/layout - 6_3.xml",
    "all_bottom" => "layouts/Arcades/layout - 6_1.xml"
  }.freeze

  def set(val)
    case val
    when "some", "more", "all_top", "all_bottom"
      copy LAYOUTS[val], "layouts/Arcades/layout - 6.xml"
    when "none"
      remove "layouts/Arcades/layout - 6.xml"  
    end
  end

  def status
    layout = "layouts/Arcades/layout - 6.xml"
    if exist?(layout)
      LAYOUTS.each do |key, path|
        return key if files_equal?(layout, path)
      end
    end
    "none"
  end
end

# layouts/Arcades/layout - 5_1.xml -- time and date (main screen)
# layouts/Arcades/layout - 5_3.xml -- time only (main screen)
# layouts/Arcades/layout - 5_2.xml -- time and date (2nd screen)
# layouts/Arcades/layout - 5_4.xml -- time only (2nd screen)
class TimeAndDateDisplay < ConfigBase
  DESCRIPTION = "Display the current time and date on the game menu."
  OPTIONS = {
    time: "Show the current time only.",
    datetime: "Show both the current time and date.",
    disabled: "Do not show the time or date."
  }
  DEFAULT = "time"
  @@target = "layouts/Arcades/layout - 5.xml"

  def set(val)
    case val
    when "datetime"
      copy "layouts/Arcades/layout - 5_1.xml", @@target
    when "time"
      copy "layouts/Arcades/layout - 5_3.xml", @@target
    when "disabled"
      remove @@target
    end
  end

  def status
    if exist?(@@target)
      return "datetime" if files_equal?(@@target, "layouts/Arcades/layout - 5_1.xml")
      return "time" if files_equal?(@@target, "layouts/Arcades/layout - 5_3.xml")
    end
    return "disabled"
  end
end

class AttractModeDim < ConfigBase
  DESCRIPTION = "When enabled, the screen will dim slightly as attract mode starts autostcolling through games."
  OPTIONS = {
    enabled: "The screen will dim slightly when the system is idle and begins autostcolling through games.",
    disabled: "The screen will stay at full brightness when the system is idle."
  }
  DEFAULT = "disabled"

  @@target = "layouts/Arcades/images/attract.png"

  def set(val)
    case val
    when "enabled"
      copy "layouts/Arcades/images/attractDIM.png", @@target
    when "disabled"
      copy "layouts/Arcades/images/attractNODIM.png", @@target
    end
  end

  def status
    files_equal?("layouts/Arcades/images/attractDIM.png", @@target) ? "enabled" : "disabled"
  end
end

class WallThemesVideos < ConfigBase
  DESCRIPTION = "Toggle wall themes between attract-mode videos and gameplay videos."
  OPTIONS = {
    gameplay: "Use gameplay variants of wall themes.",
    attract: "Use attract-mode variants of wall themes."
  }
  DEFAULT = "attract"

  def set(val)
    case val
    when "gameplay"
      copy_matching "autochanger/WallsGameplay/*", "layouts/Arcades"
    when "attract"
      copy_matching "autochanger/WallsAttract/*", "layouts/Arcades"
    end
  end

  def status
    files_equal?("layouts/Arcades/layout - 2 Reflection.xml", "autochanger/WallsGameplay/layout - 2 Reflection.xml") ? "gameplay" : "attract"
  end
end

class BezelSwitcher < ConfigBase
  DESCRIPTION = "With MAME games, you can switch bezels in-game."
  OPTIONS = {
    gamepad: "Click your gamepad's left AND right thumbsticks at the same time to switch bezels in-game.",
    keyboard: "Z and X keys switch bezels in-game",
    disabled: "You can't switch bezels in-game. You can still select bezels here."
  }
  DEFAULT = "gamepad"

  def set(val)
    case val
    when "gamepad"
      set_value "emulators/mame/plugin.ini", "viewswitch 1"
      make_cfg_for_mame_roms <<-EOS
        [{"switch":
          {"Bezel":"JOYCODE_1_BUTTON7",
          "Bezel2":"JOYCODE_1_BUTTON8"}
        }]
      EOS
    when "keyboard"
      set_value "emulators/mame/plugin.ini", "viewswitch 1"
      make_cfg_for_mame_roms <<-EOS
        [{"switch":
          {"Bezel":"KEYCODE_Z",
            "Bezel2":"KEYCODE_X"}
        }]
      EOS
    when "disabled"
      set_value "emulators/mame/plugin.ini", "viewswitch 0"
    end
  end

  def status
    first_cfg = Dir.glob("emulators/mame/viewswitch/*.cfg").first
    if !first_cfg || get_value("emulators/mame/plugin.ini", "viewswitch") == "0"
      "disabled"
    else
      cfg_contents = File.read(first_cfg)
      if cfg_contents.include?("JOYCODE")
        "gamepad"
      elsif cfg_contents.include?("KEYCODE")
        "keyboard"
      end
    end
  end

  # "emulators/mame/viewswitch/" # destination directory
  def make_cfg_for_mame_roms(content)
    roms = Dir.entries("emulators/mame/roms/").reject { |name| name.start_with?(".") }.map { |name| File.basename(name, ".*") }.sort
    roms.each do |rom|
      File.open("emulators/mame/viewswitch/" + rom + ".cfg", "w") do |f|
        f.puts(content)
      end
    end
  end
end

class ScreenGlass < ConfigBase
  DESCRIPTION = "Choose the bezel glass effect."
  OPTIONS = {
    disabled: "Standard glass-less bezels.",
    scuffed: "Scuffed glass look.",
    blurred: "Reflective glass with a blurred effect.",
    first_person: "Reflective glass with a first-person style reflection.",
    sharp: "Reflective glass with a sharp reflection."
  }
  DEFAULT = "scuffed"

  # These commented out ones are referenced in the BAT, but the directories don't exist in this build
  BEZEL_PATHS = [
    "emulators/mame/artwork"
    # "emulators/mame/artworkcocktail",
    # "emulators/mame/artworkvert",
    # "emulators/mame/artworkvert9x16"
  ].freeze

  def set(val)
    case val
    when "disabled"
      BEZEL_PATHS.each do |path|
        copy "autochanger/Bezel.png", "#{path}/DefaultBezelH.png"
        copy "autochanger/BezelV.png", "#{path}/DefaultBezelV.png"
      end
    when "scuffed"
      BEZEL_PATHS.each do |path|
        copy "autochanger/BezelLightGlass.png", "#{path}/DefaultBezelH.png"
        copy "autochanger/BezelVLightGlass.png", "#{path}/DefaultBezelV.png"
      end
    when "blurred"
      BEZEL_PATHS.each do |path|
        copy "autochanger/ReflectiveGlass/HBlur.png", "#{path}/DefaultBezelH.png"
        copy "autochanger/ReflectiveGlass/VBlur.png", "#{path}/DefaultBezelV.png"
      end
    when "first_person"
      BEZEL_PATHS.each do |path|
        copy "autochanger/ReflectiveGlass/HPerson.png", "#{path}/DefaultBezelH.png"
        copy "autochanger/ReflectiveGlass/VPerson.png", "#{path}/DefaultBezelV.png"
      end
    when "sharp"
      BEZEL_PATHS.each do |path|
        copy "autochanger/ReflectiveGlass/H.png", "#{path}/DefaultBezelH.png"
        copy "autochanger/ReflectiveGlass/V.png", "#{path}/DefaultBezelV.png"
      end
    end
  end

  def status
    return "disabled" if files_equal?("emulators/mame/artwork/DefaultBezelH.png", "autochanger/Bezel.png")
    return "scuffed" if files_equal?("emulators/mame/artwork/DefaultBezelH.png", "autochanger/BezelLightGlass.png")
    return "blurred" if files_equal?("emulators/mame/artwork/DefaultBezelH.png", "autochanger/ReflectiveGlass/HBlur.png")
    return "first_person" if files_equal?("emulators/mame/artwork/DefaultBezelH.png", "autochanger/ReflectiveGlass/HPerson.png")
    "sharp" if files_equal?("emulators/mame/artwork/DefaultBezelH.png", "autochanger/ReflectiveGlass/H.png")
  end

  private
end

class Scanlines < ConfigBase
  DESCRIPTION = "Scanlines provide an analog, retro look to gameplay. This affects when you're actually playing the game, not the game menu."
  OPTIONS = {
    normal: "Standard scanline shaders.",
    blooming: "Blooming scanlines and glow presets.",
    disabled: "Disable scanline shaders (LCD-style)."
  }
  DEFAULT = "normal"

  def set(val)
    case val
    when "normal"
      copy "autochanger/CRTcurve.ini", "emulators/mame/ini/presets/raster.ini"
      copy "autochanger/vector.ini", "emulators/mame/ini/presets/vector.ini"
      copy "autochanger/vector-mono.ini", "emulators/mame/ini/presets/vector-mono.ini"
      copy "autochanger/ArcCabView.json", "emulators/mame/bgfx/chains/ArcCabView/ArcCabView.json"
      copy "autochanger/ArcCabView_Neo304.json", "emulators/mame/bgfx/chains/ArcCabView/ArcCabView_Neo304.json"
    when "blooming"
      copy "autochanger/CRTcurveGlow.ini", "emulators/mame/ini/presets/raster.ini"
      copy "autochanger/vectorGlow.ini", "emulators/mame/ini/presets/vector.ini"
      copy "autochanger/vector-monoGlow.ini", "emulators/mame/ini/presets/vector-mono.ini"
      copy "autochanger/ArcCabViewBloom.json", "emulators/mame/bgfx/chains/ArcCabView/ArcCabView.json"
      copy "autochanger/ArcCabView_Neo304Bloom.json", "emulators/mame/bgfx/chains/ArcCabView/ArcCabView_Neo304.json"
    when "disabled"
      copy "autochanger/CRTsharp.ini", "emulators/mame/ini/presets/raster.ini"
      copy "autochanger/vectorLCD.ini", "emulators/mame/ini/presets/vector.ini"
      copy "autochanger/vector-monoLCD.ini", "emulators/mame/ini/presets/vector-mono.ini"
      copy "autochanger/ArcCabViewNoScan.json", "emulators/mame/bgfx/chains/ArcCabView/ArcCabView.json"
      copy "autochanger/ArcCabView_Neo304NoScan.json", "emulators/mame/bgfx/chains/ArcCabView/ArcCabView_Neo304.json"
    end
  end

  def status
    raster = "emulators/mame/ini/presets/raster.ini"
    return "normal" if files_equal?(raster, "autochanger/CRTcurve.ini")
    return "blooming" if files_equal?(raster, "autochanger/CRTcurveGlow.ini")
    return "disabled" if files_equal?(raster, "autochanger/CRTsharp.ini")
  end
end

class BezelStyle < ConfigBase
  DESCRIPTION = "This is an in-game setting. Choose your preferred bezel style for MAME games."
  OPTIONS = {
    artwork: "Bezels have unique art for each game. Reflections work with this bezel style.",
    uniform: "One uniform retro gray bezel for all games. Reflections work with this bezel style.",
    disabled: "No bezels graphics or artwork. Area around the screen is black. Reflections don't work with this bezel style, since there's no bezel for reflection."
  }
  DEFAULT = "artwork"

  def set(val)
    case val
    when "artwork"
      copy "autochanger/horizontFB.ini", "emulators/mame/horizont.ini"
      copy "autochanger/verticalFB.ini", "emulators/mame/vertical.ini"
    when "uniform"
      copy "autochanger/horizont.ini", "emulators/mame/horizont.ini"
      copy "autochanger/vertical.ini", "emulators/mame/vertical.ini"
    when "disabled"
      copy "autochanger/horizontdisable.ini", "emulators/mame/horizont.ini"
      copy "autochanger/verticaldisable.ini", "emulators/mame/vertical.ini"
    end    
  end

  def status
    file = "emulators/mame/horizont.ini"
    return "artwork" if files_equal?(file, "autochanger/horizontFB.ini")
    return "uniform" if files_equal?(file, "autochanger/horizont.ini")
    return "disabled" if files_equal?(file, "autochanger/horizontdisable.ini")
  end
end


class BezelCropping < ConfigBase
  DESCRIPTION = "This applies only to games with horizontally oriented screens. It controls whether the gameplay expands to take up as much of the screen as possible (that's bezel cropping), or whether the gameplay is a bit smaller so the bezel artwork is visible in its entirety (that's 'full' bezel)."
  OPTIONS = {
    full: "The entire bezel is visible, and the game screen is slightly smaller to make room for the bezel. Use this if you want to see the entire bezel graphic.",
    cropped: "The game screen is maximized, so less of the bezel is visible. The bezel is also darker in this variation, since emphasis is on the game itself."
  }
  DEFAULT = "cropped"

  def set(val)
    case val
    when "full"
      set_value "emulators/mame/mame.ini", "view   Bezel2"
      # update_game_cfg_files('view="Bezel2"', 'view="Bezel"')
    when "cropped"
      set_value "emulators/mame/mame.ini", "view  auto"
      # update_game_cfg_files('view="Bezel"', 'view="Bezel2"')
    end
  end

  def status
    (get_value("emulators/mame/mame.ini", "view") == "Bezel2") ? "full" : "cropped"
  end

  private

  # The bats do this, but I'm not sure if it's necessary or not. The operation takes a while
  # update_game_cfg_files('view="Bezel2"', 'view="Bezel"')
  def update_game_cfg_files(from, to)
    Dir.glob("emulators/mame/cfg/*.cfg").each do |file|
      content = File.read(file)
      next unless content.include?(from)
      updated = content.gsub(from, to)
      File.write(file, updated) if updated != content
    end
  end
end

# Cropped Lights out: 		   copy ..\autochanger\mame16x9.ini .\..\emulators\mame\mame.ini
# view                      auto
# video                     auto
# bgfx_screen_chains        default
# hlsl_enable               1

# No cropping dusk:   		   copy ..\autochanger\mame16x9bezel2.ini .\..\emulators\mame\mame.ini
# view                      Bezel2
# video                     auto
# bgfx_screen_chains        default
# hlsl_enable               1

# reflective cropped lights out: copy ..\autochanger\mamereflect16x9.ini .\..\emulators\mame\mame.ini
# view                      auto
# video                     bgfx
# bgfx_screen_chains        ArcCabView
# hlsl_enable               0

# reflective no cropping dusk:   copy ..\autochanger\mamereflect16x9bezel2.ini .\..\emulators\mame\mame.ini
# view                      Bezel2
# video                     bgfx
# bgfx_screen_chains        ArcCabView
# hlsl_enable               0

class BezelReflectivity < ConfigBase
  DESCRIPTION = "When enabled, you'll see a subtle reflection around the edge of the 'screen' while playing a game. It's only noticeable when game graphics extend to the edges of the screen."
  OPTIONS = {
    enabled: "The bezel shows a subtile reflection of graphics on the game screen.",
    disabled: "No reflection is visible."
  }
  DEFAULT = "disabled"

  def set(val)
    case val
    when "enabled"
      set_value "emulators/mame/mame.ini", "
      video  bgfx
      bgfx_screen_chains        ArcCabView
      hlsl_enable               0
      "
    when "disabled"
      set_value "emulators/mame/mame.ini", "
      video   auto
      bgfx_screen_chains        default
      hlsl_enable               1
      "
    end
  end

  def status
    (get_value("emulators/mame/mame.ini", "video") == "bgfx") ? "enabled" : "disabled"
  end
end
