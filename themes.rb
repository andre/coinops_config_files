class MainScreenTheme < ConfigBase
  DESCRIPTION = "Change the main theme layout."
  OPTIONS = {
    arcade: "Arcade (no logo)!!!",
    arcade_logo: "Arcade with logo.",
    gameplay: "Gameplay (no logo).",
    gameplay_logo: "Gameplay with logo.",
    legends: "Legends theme.",
    lights: "Lights theme.",
    marquee: "Marquee theme.",
    reflection: "Reflection theme.",
    spin: "Full spin theme.",
    vertical: "Vertical theme.",
    wall: "Wall/cabs theme.",
    wheel: "Wheel theme.",
    wheeler: "Wheeler theme.",
    crossfade: "Crossfade theme.",
    crossfade_gameplay: "Crossfade gameplay theme."
  }
  DEFAULT = "wheeler"

  HORIZONAL_CONF = <<~EOS
    up = Keypad 8,Up,joyHat0Up,joyAxis1-,joyAxis4+
    down = Keypad 2,Down,joyHat0Down,joyAxis1+,joyAxis5+
    left = Keypad 4
    right = Keypad 6
    prevCyclePlaylist = F1,Left,joyHat0Left,joyAxis0-
    nextCyclePlaylist = F2,Right,joyHat0Right,joyAxis0+
  EOS

  VERTICAL_CONF = <<~EOS
    up = Keypad 8
    down = Keypad 2
    left = Keypad 4,Left,joyHat0Left,joyAxis0-,joyAxis4+
    right = Keypad 6,Right,joyHat0Right,joyAxis0+,joyAxis5+
    prevCyclePlaylist = F1,Up,joyHat0Up,joyAxis1-
    nextCyclePlaylist = F2,Down,joyHat0Down,joyAxis1+
  EOS

  def set(val)
    case val
    when "arcade"
      copy "layouts/Arcades/layout - 2 Attract.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "arcade_logo"
      copy "layouts/Arcades/layout - 2 Attract.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "gameplay"
      copy "layouts/Arcades/layout - 2 Gameplay.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "gameplay_logo"
      copy "layouts/Arcades/layout - 2 Gameplay.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "legends"
      copy "layouts/Arcades/layout - 2 Full.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "lights"
      copy "layouts/Arcades/layout - 2 Lights.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "marquee"
      copy "layouts/Arcades/layout - 2 Marquee.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsV.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", VERTICAL_CONF
    when "reflection"
      copy "layouts/Arcades/layout - 2 Reflection.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "spin"
      copy "layouts/Arcades/layout - 2 FullSpin.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "vertical"
      copy "layouts/Arcades/layout - 2 Vert.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsV.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", VERTICAL_CONF
    when "wall"
      copy "layouts/Arcades/layout - 2 Cabs.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "wheel"
      copy "layouts/Arcades/layout - 2 Wheel.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsV.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", VERTICAL_CONF
    when "wheeler"
      copy "layouts/Arcades/layout - 2 Wheeler.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsV.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", VERTICAL_CONF
    when "crossfade"
      copy "layouts/Arcades/layout - 2 Crossfade.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    when "crossfade_gameplay"
      copy "layouts/Arcades/layout - 2 Crossfade Gameplay.xml", "layouts/Arcades/layout - 0.xml"
      copy "layouts/Arcades/layout - 0 No Logo.xml", "layouts/Arcades/layout - 2.xml"
      copy "layouts/Arcades/layoutplaylistsH.xml", "layouts/Arcades/layoutplaylists.xml"
      set_value "controls.conf", HORIZONAL_CONF
    end
  end

  def status
    layout0 = "layouts/Arcades/layout - 0.xml"
    layout2 = "layouts/Arcades/layout - 2.xml"

    return "arcade" if files_equal?(layout0, "layouts/Arcades/layout - 2 Attract.xml") &&
      files_equal?(layout2, "layouts/Arcades/layout - 0 No Logo.xml")

    return "arcade_logo" if files_equal?(layout0, "layouts/Arcades/layout - 2 Attract.xml") &&
      files_equal?(layout2, "layouts/Arcades/layout - 0 Logo.xml")

    return "gameplay" if files_equal?(layout0, "layouts/Arcades/layout - 2 Gameplay.xml") &&
      files_equal?(layout2, "layouts/Arcades/layout - 0 No Logo.xml")

    return "gameplay_logo" if files_equal?(layout0, "layouts/Arcades/layout - 2 Gameplay.xml") &&
      files_equal?(layout2, "layouts/Arcades/layout - 0 Logo.xml")

    return "legends" if files_equal?(layout0, "layouts/Arcades/layout - 2 Full.xml")
    return "lights" if files_equal?(layout0, "layouts/Arcades/layout - 2 Lights.xml")
    return "marquee" if files_equal?(layout0, "layouts/Arcades/layout - 2 Marquee.xml")
    return "reflection" if files_equal?(layout0, "layouts/Arcades/layout - 2 Reflection.xml")
    return "spin" if files_equal?(layout0, "layouts/Arcades/layout - 2 FullSpin.xml")
    return "vertical" if files_equal?(layout0, "layouts/Arcades/layout - 2 Vert.xml")
    return "wall" if files_equal?(layout0, "layouts/Arcades/layout - 2 Cabs.xml")
    return "wheel" if files_equal?(layout0, "layouts/Arcades/layout - 2 Wheel.xml")
    return "wheeler" if files_equal?(layout0, "layouts/Arcades/layout - 2 Wheeler.xml")
    return "crossfade" if files_equal?(layout0, "layouts/Arcades/layout - 2 Crossfade.xml")
    return "crossfade_gameplay" if files_equal?(layout0, "layouts/Arcades/layout - 2 Crossfade Gameplay.xml")

    "unknown"
  end
end

class SecondScreenTheme < ConfigBase
  DESCRIPTION = "Configure the second screen marquee layout."
  OPTIONS = {
    "animated_swipe_16x9_fire" => "Animated marquee on a 16x9 screen with fire backdrop.",
    "animated_swipe_16x9" => "Animated marquee on a 16x9 screen without fire backdrop.",
    "animated_swipe_thin" => "Animated marquee on a thin screen.",
    "animated_fade_16x9_fire" => "Animated marquee with crossfade on a 16x9 screen with fire backdrop.",
    "animated_fade_16x9" => "Animated marquee with crossfade on a 16x9 screen without fire backdrop.",
    "animated_fade_thin" => "Animated marquee with crossfade on a thin screen.",
    "static_swipe_16x9_fire" => "Static marquee on a 16x9 screen with fire backdrop.",
    "static_swipe_16x9" => "Static marquee on a 16x9 screen without fire backdrop.",
    "static_swipe_thin" => "Static marquee on a thin screen.",
    "static_fade_16x9_fire" => "Static marquee with crossfade on a 16x9 screen with fire backdrop.",
    "static_fade_16x9" => "Static marquee with crossfade on a 16x9 screen without fire backdrop.",
    "static_fade_thin" => "Static marquee with crossfade on a thin screen.",
    :blank => "Blank second screen."
  }
  DEFAULT = "blank"

  LAYOUTS = {
    "animated_swipe_16x9_fire" => {layout: "layouts/Arcades/layout 2nd animated screen - Animated 16x9.xml", animate: true},
    "animated_swipe_16x9" => {layout: "layouts/Arcades/layout 2nd animated screen - Animated 16x9 No Fire.xml", animate: true},
    "animated_swipe_thin" => {layout: "layouts/Arcades/layout 2nd animated screen - Animated.xml", animate: true},
    "animated_fade_16x9_fire" => {layout: "layouts/Arcades/layout 2nd animated screen CF - Animated 16x9.xml", animate: true},
    "animated_fade_16x9" => {layout: "layouts/Arcades/layout 2nd animated screen CF - Animated 16x9 no Fire.xml", animate: true},
    "animated_fade_thin" => {layout: "layouts/Arcades/layout 2nd animated screen CF - Animated.xml", animate: true},
    "static_swipe_16x9_fire" => {layout: "layouts/Arcades/layout 2nd screen - Animated 16x9.xml", animate: true},
    "static_swipe_16x9" => {layout: "layouts/Arcades/layout 2nd screen - Animated 16x9 no Fire.xml", animate: false},
    "static_swipe_thin" => {layout: "layouts/Arcades/layout 2nd screen - Animated.xml", animate: false},
    "static_fade_16x9_fire" => {layout: "layouts/Arcades/layout 2nd screen CF - Animated 16x9.xml", animate: true},
    "static_fade_16x9" => {layout: "layouts/Arcades/layout 2nd screen CF - Animated 16x9 no Fire.xml", animate: false},
    "static_fade_thin" => {layout: "layouts/Arcades/layout 2nd screen CF - Animated.xml", animate: false},
    "blank" => {layout: "layouts/Arcades/layout 2nd screen - None.xml", animate: false}
  }.freeze

  def set(val)
    config = LAYOUTS[val]
    return unless config

    copy(config[:layout], "layouts/Arcades/layout - 1.xml")
    arcader_layout = config[:layout].gsub("Arcades", "Arcader")
    copy(arcader_layout, "layouts/Arcader/layout - 1.xml") if exist?(arcader_layout)

    set_value "settings.conf", "animateDuringGame = #{config[:animate] ? "true" : "false"}"
  end

  def status
    layout_file = "layouts/Arcades/layout - 1.xml"
    entry = LAYOUTS.find do |_, cfg|
      files_equal?(layout_file, cfg[:layout])
    rescue Errno::ENOENT
      false
    end
    entry ? entry.first : "unknown"
  end
end
