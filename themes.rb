class MainScreenTheme < ConfigBase
  DESCRIPTION = "Change the main theme layout."
  APPLY = :retrofe_reload
  OPTIONS = {
    arcade: "Arcade (no logo)!!!",
    arcade_logo: "Arcade with logo.",
    alaska: "Alaska theme.",
    aura: "Aura theme.",
    cabinet: "Cabinet theme.",
    gameplay: "Gameplay (no logo).",
    gameplay_logo: "Gameplay with logo.",
    legends: "Legends theme.",
    lights: "Lights theme.",
    marquee: "Marquee theme.",
    marquees: "Marquees theme.",
    reflection: "Reflection theme.",
    spin: "Full spin theme.",
    vertical: "Vertical theme.",
    wall: "Wall/cabs theme.",
    wheel: "Wheel theme.",
    wheeler: "Wheeler theme.",
    crossfade: "Crossfade theme.",
    crossfade_gameplay: "Crossfade gameplay theme.",
    deluxe_80s: "Deluxe 80s theme.",
    deluxe_90s: "Deluxe 90s theme.",
    deluxe_arcade: "Deluxe arcade theme.",
    deluxe_cabinet: "Deluxe cabinet theme.",
    deluxe_evolution: "Deluxe evolution theme.",
    deluxe_marquee: "Deluxe marquee theme.",
    deluxe_poster: "Deluxe poster theme.",
    deluxe_slider: "Deluxe slider theme.",
    deluxe_spin: "Deluxe spin theme.",
    deluxe_spinner: "Deluxe spinner theme.",
    deluxe_wheeler: "Deluxe wheeler theme.",
    quick_spin_cabinet: "Quick spin cabinet theme.",
    quick_spin_evolution: "Quick spin evolution theme.",
    quick_spin_wheeler: "Quick spin wheeler theme."
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
      apply_theme layout: "layouts/Arcades/layout - 2 Attract.xml"
    when "arcade_logo"
      apply_theme layout: "layouts/Arcades/layout - 2 Attract.xml",
        logo: "layouts/Arcades/layout - 0 Logo.xml"
    when "alaska"
      apply_theme layout: "layouts/Arcades/layout - 2 Alaska.xml"
    when "aura"
      apply_theme layout: "layouts/Arcades/layout - 2 Aura.xml"
    when "cabinet"
      apply_theme layout: "layouts/Arcades/layout - 2 Cab.xml", vertical: true
    when "gameplay"
      apply_theme layout: "layouts/Arcades/layout - 2 Gameplay.xml"
    when "gameplay_logo"
      apply_theme layout: "layouts/Arcades/layout - 2 Gameplay.xml",
        logo: "layouts/Arcades/layout - 0 Logo.xml"
    when "legends"
      apply_theme layout: "layouts/Arcades/layout - 2 Full.xml"
    when "lights"
      apply_theme layout: "layouts/Arcades/layout - 2 Lights.xml"
    when "marquee"
      apply_theme layout: "layouts/Arcades/layout - 2 Marquee.xml", vertical: true
    when "marquees"
      apply_theme layout: "layouts/Arcades/layout - 2 Marquees.xml", vertical: true
    when "reflection"
      apply_theme layout: "layouts/Arcades/layout - 2 Reflection.xml"
    when "spin"
      apply_theme layout: "layouts/Arcades/layout - 2 FullSpin.xml"
    when "vertical"
      apply_theme layout: "layouts/Arcades/layout - 2 Vert.xml", vertical: true
    when "wall"
      apply_theme layout: "layouts/Arcades/layout - 2 Cabs.xml"
    when "wheel"
      apply_theme layout: "layouts/Arcades/layout - 2 Wheel.xml", vertical: true
    when "wheeler"
      apply_theme layout: "layouts/Arcades/layout - 2 Wheeler.xml", vertical: true
    when "crossfade"
      apply_theme layout: "layouts/Arcades/layout - 2 Crossfade.xml"
    when "crossfade_gameplay"
      apply_theme layout: "layouts/Arcades/layout - 2 Crossfade Gameplay.xml"
    when "deluxe_80s"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe 80s.xml"
    when "deluxe_90s"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe 90s.xml"
    when "deluxe_arcade"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Lounge.xml"
    when "deluxe_cabinet"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Smoke.xml"
    when "deluxe_evolution"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Evo.xml", vertical: true
    when "deluxe_marquee"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Marquees Right.xml", vertical: true
    when "deluxe_poster"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Poster.xml"
    when "deluxe_slider"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Slider.xml", vertical: true
    when "deluxe_spin"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Spin.xml"
    when "deluxe_spinner"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Spinner.xml", vertical: true
    when "deluxe_wheeler"
      apply_theme layout: "layouts/Arcades/layout - 2 Deluxe Wall.xml", vertical: true
    when "quick_spin_cabinet"
      apply_theme layout: "layouts/Arcades/layout - 2 qsCab.xml", vertical: true,
        settings1_source: "autochanger/settings1xxty.conf", preserve_settings0: true
    when "quick_spin_evolution"
      apply_theme layout: "layouts/Arcades/layout - 2 qsEvo.xml", vertical: true,
        settings1_source: "autochanger/settings1xxty.conf", preserve_settings0: true
    when "quick_spin_wheeler"
      apply_theme layout: "layouts/Arcades/layout - 2 qsWheeler.xml", vertical: true,
        settings1_source: "autochanger/settings1xxty.conf", preserve_settings0: true
    end
  end

  def apply_theme(layout:, logo: "layouts/Arcades/layout - 0 No Logo.xml", vertical: false, settings1_source: nil, preserve_settings0: false)
    copy layout, "layouts/Arcades/layout - 0.xml"
    copy logo, "layouts/Arcades/layout - 2.xml"
    copy "layouts/Arcades/layoutplaylists#{vertical ? "V" : "H"}.xml", "layouts/Arcades/layoutplaylists.xml"
    set_value "controls.conf", vertical ? VERTICAL_CONF : HORIZONAL_CONF

    if preserve_settings0
      remove "settings0.conf"
      copy "settings1.conf", "settings0.conf" if exist?("settings1.conf")
    end

    if settings1_source
      copy settings1_source, "settings1.conf"
    else
      remove "settings1.conf"
    end
  end

  def status
    layout0 = "layouts/Arcades/layout - 0.xml"
    layout2 = "layouts/Arcades/layout - 2.xml"

    return "arcade" if files_equal?(layout0, "layouts/Arcades/layout - 2 Attract.xml") &&
      files_equal?(layout2, "layouts/Arcades/layout - 0 No Logo.xml")

    return "arcade_logo" if files_equal?(layout0, "layouts/Arcades/layout - 2 Attract.xml") &&
      files_equal?(layout2, "layouts/Arcades/layout - 0 Logo.xml")

    return "alaska" if files_equal?(layout0, "layouts/Arcades/layout - 2 Alaska.xml")
    return "aura" if files_equal?(layout0, "layouts/Arcades/layout - 2 Aura.xml")
    return "cabinet" if files_equal?(layout0, "layouts/Arcades/layout - 2 Cab.xml")

    return "gameplay" if files_equal?(layout0, "layouts/Arcades/layout - 2 Gameplay.xml") &&
      files_equal?(layout2, "layouts/Arcades/layout - 0 No Logo.xml")

    return "gameplay_logo" if files_equal?(layout0, "layouts/Arcades/layout - 2 Gameplay.xml") &&
      files_equal?(layout2, "layouts/Arcades/layout - 0 Logo.xml")

    return "legends" if files_equal?(layout0, "layouts/Arcades/layout - 2 Full.xml")
    return "lights" if files_equal?(layout0, "layouts/Arcades/layout - 2 Lights.xml")
    return "marquee" if files_equal?(layout0, "layouts/Arcades/layout - 2 Marquee.xml")
    return "marquees" if files_equal?(layout0, "layouts/Arcades/layout - 2 Marquees.xml")
    return "reflection" if files_equal?(layout0, "layouts/Arcades/layout - 2 Reflection.xml")
    return "spin" if files_equal?(layout0, "layouts/Arcades/layout - 2 FullSpin.xml")
    return "vertical" if files_equal?(layout0, "layouts/Arcades/layout - 2 Vert.xml")
    return "wall" if files_equal?(layout0, "layouts/Arcades/layout - 2 Cabs.xml")
    return "wheel" if files_equal?(layout0, "layouts/Arcades/layout - 2 Wheel.xml")
    return "wheeler" if files_equal?(layout0, "layouts/Arcades/layout - 2 Wheeler.xml")
    return "crossfade" if files_equal?(layout0, "layouts/Arcades/layout - 2 Crossfade.xml")
    return "crossfade_gameplay" if files_equal?(layout0, "layouts/Arcades/layout - 2 Crossfade Gameplay.xml")
    return "deluxe_80s" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe 80s.xml")
    return "deluxe_90s" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe 90s.xml")
    return "deluxe_arcade" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Lounge.xml")
    return "deluxe_cabinet" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Smoke.xml")
    return "deluxe_evolution" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Evo.xml")
    return "deluxe_marquee" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Marquees Right.xml")
    return "deluxe_poster" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Poster.xml")
    return "deluxe_slider" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Slider.xml")
    return "deluxe_spin" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Spin.xml")
    return "deluxe_spinner" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Spinner.xml")
    return "deluxe_wheeler" if files_equal?(layout0, "layouts/Arcades/layout - 2 Deluxe Wall.xml")
    return "quick_spin_cabinet" if files_equal?(layout0, "layouts/Arcades/layout - 2 qsCab.xml")
    return "quick_spin_evolution" if files_equal?(layout0, "layouts/Arcades/layout - 2 qsEvo.xml")
    return "quick_spin_wheeler" if files_equal?(layout0, "layouts/Arcades/layout - 2 qsWheeler.xml")

    "unknown"
  end
end

class SecondScreenTheme < ConfigBase
  DESCRIPTION = "Configure the second screen marquee layout."
  APPLY = :retrofe_reload
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
    "animated_swipe_16x9" => {layout: "layouts/Arcades/layout 2nd animated screen - Animated 16x9 no Fire.xml", animate: true},
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
