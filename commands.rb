class Commands < CommandBase
  DESCRIPTIONS = {
    remove_settings_overlays: "Removes any settings and controls conf files that can override the main configuration files. Useful for transitioning away from old .bat files, which used settingsX.conf and controlsX.conf files to override main settings. This system now updates the main settings.conf file directly, so these override files can cause confusion.",
    fix_coinops: "DEVELOPMENT IN PROGRESS: swap in known good templates and files to attempt to reset CoinOps to a known good state.",
    mame_screen_cycle: "DEVELOPMENT IN PROGRESS: Cycle MAME's screen setting through detected monitors.",
    clear_favorites: "Clear the list of favorite games.",
    reset_favorites: "Reset favorite games to a CoinOps-supplied default list.",
    reset_last_played: "CoinOps comes with baked-in 'last played' lists. This resets them to original values.",
    reset_mame: "DEVELOPMENT IN PROGRESS: Copy in known good version mame.ini, and other resets to make MAME nice and fresh.",
    copy_retro_pc_logos: "Moves logos from RetroPC folders into a place they are needed for the main menu. Use this if you've created or unpacked an addon in the RetroPC folder."
  }
  def remove_settings_overlays
      # Remove any settings and controls confs that can override the main files
    (1..15).each { |i| remove "settings#{i}.conf" }
    (1..9).each { |i| remove "controls#{i}.conf" }
  end

  # Reset EVERYTHING to known good defaults
  def fix_coinops
    Commands::ResetMame.new.execute!
    Commands::ResetFavorites.new.execute!
    Commands::ResetLastPlayed.new.execute!

    Config::ControllerType.set(Config::ControllerType::DEFAULT)
    Config::BezelSwitcher.set(Config::BezelSwitcher::DEFAULT)
    Configs::SecondScreenControlsOverlay.new.set(Configs::SecondScreenControlsOverlay::DEFAULT)
    Configs::HighScores.new.set(Configs::HighScores::DEFAULT)
    Configs::SecondScreenTime.new.set(Configs::SecondScreenTime::DEFAULT)
    Configs::GameMetadataDisplay.new.set(Configs::GameMetadataDisplay::DEFAULT)
    Configs::TimeAndDateDisplay.new.set(Configs::TimeAndDateDisplay::DEFAULT)
    Configs::BezelSwitcher.new.set(Configs::BezelSwitcher::DEFAULT)
    Configs::Theme.new.set(Configs::Theme::DEFAULT)
    Configs::SecondScreenTheme.new.set(Configs::SecondScreenTheme::DEFAULT)
    Config::WallThemesVideos.set(Config::WallThemesVideos::DEFAULT)
    Config::LaserDiscGameArrows.new.reset!
    Configs::AttractModeJoystick.new.set(AttractModeJoystick::DEFAULT)
    Config::PlayersTwoFour.new.reset!
    Config::CPS2MarvelRoms.new.reset!
    Config::AttractModeDim.new.reset!
    Config::ScreenGlass.new.reset!
    Condig::Scanlines.new.reset!

    # Remove any settings and controls confs that can override the main files
    remove_settings_overlays

    # TODO review - are these needed?
    remove "emulators/mame/roms/neogeo/uni-bios_4_0.rom" # this file is in autochanged, but not referenced in any .bat
    copy "autochanger/forgottnorig.conf", "collections/Arcades/launchers/forgottn.conf"
    copy "autochanger/settings5_7x.conf", "autochanger/settings5_7.conf"

    # TODO: review - none of these exist in this build (Micro)
    copy_matching "autochanger/BezelConsoleLightsOut/*", "emulators/RetroArchXiso/overlays/borders"
    copy_matching "autochanger/RAConfigLightsOut/*", "emulators/RetroArchXiso/config"
    copy_matching "autochanger/BezelOther/LightsOut/*", "emulators"

    copy "collections/Arcades/medium_artwork/video/starwarsCOCKPIT.mp4", "collections/Arcades/medium_artwork/video/starwars.mp4"
    copy "collections/Arcades/medium_artwork/video/xmenu2p.mp4", "collections/Arcades/medium_artwork/video/xmenu.mp4"

    remove "layouts/Arcades/images/OVERLAYx.png"

    remove "emulators/mame/nvram/offroadt/battery"
    remove "emulators/mame/nvram/offroadt/eeprom"

    copy "layouts/Arcades/video/splash2.mp4", "layouts/Arcades/video/splash.mp4"

    # TODO: review - doesn't seem to exist in this build but I believe it does in others
    copy "layouts/Arcades/video/videofire.mp4", "layouts/Arcades/video/Intro.mp4"

    copy "layouts/Arcades/collections/_common/medium_artwork/manufacturer/Genesis_MegaDrive.png",
      "layouts/Arcades/collections/_common/medium_artwork/manufacturer/Genesis.png"
    copy "collections/Genesis/system_artwork/systemMEGADRIVE.png", "collections/Genesis/system_artwork/system.png"

    remove "collections/playCount.txt"
    remove "collections/timeSpent.txt"
    remove "settings_saved.conf"

    copy "layouts/Arcades/splashEpic.xml", "layouts/Arcades/splashYes.xml"
    copy "layouts/Arcades/splashNo.xml", "layouts/Arcades/splash.xml"

    copy "autochanger/Settings.txt", "collections/Arcades/zzzSettings.sub"
    copy "autochanger/Settings.txt", "collections/ArcadesMini/zzzSettings.sub"

    copy "collections/zzzSettings/excludeShutdown.txt", "collections/zzzSettings/exclude.txt"
    remove "collections/zzzSettings/roms/Shutdown.bat"

    copy "collections/Arcades/excludeconsoles.txt", "collections/Arcades/exclude.txt"
    %w[Arcade Arcade34 Arcade94 Arcade248].each do |collection|
      remove "collections/#{collection}/exclude.txt"
      remove "collections/#{collection}/include.txt"
    end
    copy "collections/Arcade34/includex34.txt", "collections/Arcade34/include.txt"
    copy "collections/Arcade94/includex94.txt", "collections/Arcade94/include.txt"
    copy "collections/Arcade248/includex248.txt", "collections/Arcade248/include.txt"
    copy "collections/Lightgun/includex248.txt", "collections/Lightgun/include.txt"

    copy "emulators/mame/artwork/CabHoriOFF.png", "emulators/mame/artwork/CabHori.png"
    copy "emulators/mame/artwork/CabVertOFF.png", "emulators/mame/artwork/CabVert.png"

    copy_matching "autochanger/BezelLightsOut/*", "emulators/mame/artwork"

    copy "layouts/Arcades/layoutlegends.xml", "layouts/Arcades/layout.xml"
    copy "layouts/Arcader/layoutlegends(PLAYLIST).xml", "layouts/Arcader/layout(PLAYLIST).xml"
    copy "layouts/Arcades/layout(PLAYLISTX).xml", "layouts/Arcades/layout(PLAYLIST).xml"

    copy "autochanger/Settings.txt", "layouts/Arcades/attract.txt"
    %w[logo marquee marqueeCAB marqueeGLOW video videoPlayer videoSD videoSDbezel videoAttract InsertCoin Aura].each do |folder|
      copy "collections/zzzSettings/medium_artwork/#{folder}/zz Attract On.png",
        "collections/zzzSettings/medium_artwork/#{folder}/zz Attract.png"
    end

    remove "layouts/Arcades/splash.txt"
    remove "layouts/Arcades/music/Background.mp3"

    %w[logo marquee marqueeCAB marqueeGLOW video videoPlayer videoSD videoSDbezel videoAttract InsertCoin Aura].each do |folder|
      copy "collections/zzzSettings/medium_artwork/#{folder}/zz Music On.png",
        "collections/zzzSettings/medium_artwork/#{folder}/zz Music.png"
      copy "collections/zzzSettings/medium_artwork/#{folder}/zz Musigame Off.png",
        "collections/zzzSettings/medium_artwork/#{folder}/zz Musigame.png"
      copy "collections/zzzSettings/medium_artwork/#{folder}/zz Video Off.png",
        "collections/zzzSettings/medium_artwork/#{folder}/zz Video.png"
      copy "collections/zzzSettings/medium_artwork/#{folder}/zz Split Consoles Off.png",
        "collections/zzzSettings/medium_artwork/#{folder}/zz Split Consoles.png"
    end
  end

  def mame_screen_cycle
    mame_ini = "emulators/mame/mame.ini"
    mame_exe = "emulators/mame/mame64.exe"
    raise "mame64.exe not found at #{mame_exe}" unless exist?(mame_exe)
    raise "mame.ini not found at #{mame_ini}" unless exist?(mame_ini)
    current_screen = get_value(mame_ini, "screen") || "auto"
    monitors = []
    marker_seen = false
    io = IO.popen([mame_exe, "-v", "-video", "none"], err: [:child, :out])
    begin
      io.each_line do |line|
        if line.include?("Video: Monitor")
          raw = line.split("=").last.to_s.strip.delete('"')
          name = raw.split.first
          monitors << name if name && !name.empty?
        end
        if line.include?("Starting No Driver Loaded")
          marker_seen = true
          break
        end
      end
    ensure
      begin
        Process.kill("KILL", io.pid)
      rescue
        nil
      end
      begin
        Process.wait(io.pid)
      rescue
        nil
      end
    end
    raise "No displays found from mame -v output" if monitors.empty?
    raise 'Did not detect "Starting No Driver Loaded" from mame -v output' unless marker_seen
    current_screen = monitors.first if current_screen == "auto"
    index = monitors.index(current_screen) || 0
    next_screen = monitors[(index + 1) % monitors.length]
    set_value mame_ini, "screen  #{next_screen}"
  end

  def clear_favorites
    Dir.glob("collections/*").each do |collection_path|
      playlists_dir = File.join(collection_path, "playlists")
      FileUtils.mkdir_p(playlists_dir)
      File.write(File.join(playlists_dir, "favorites.txt"), "")
    end
  end

  def reset_favorites
    %w[Arcades Arcader Arcade Arcade34 Arcade94 Arcade248 Lightgun].each do |name|
      src = "collections/#{name}/favoritesbackup.txt"
      dest = "collections/#{name}/playlists/favorites.txt"
      FileUtils.mkdir_p(File.dirname(dest))
      copy(src, dest) if exist?(src)
    end
  end

  def reset_last_played
    copy "autochanger/lastplayed.txt", "collections/Arcades/playlists/lastplayed.txt"
    %w[Arcade ArcadeMini Arcade34 Arcade94 Arcade248 Lightgun].each do |collection|
      copy "collections/#{collection}/lastplayedx10.txt", "collections/#{collection}/playlists/lastplayed.txt"
    end
  end

  def reset_mame
    copy "autochanger/mame16x9.ini", "emulators/mame/mame.ini" # this serves as the cannonical good version of mame.ini
    copy_matching "emulators/mame/cfgbackup/*", "emulators/mame/cfg"
    copy_matching "emulators/mame/cfgorigbackup/*", "emulators/mame/cfgorig"
    copy_matching "emulators/mame/nvrambackup/*", "emulators/mame/nvram"
  end

  def copy_retro_pc_logos
    copy_matching "collections/RetroPC/medium_artwork/logo/*", "collections/_common/medium_artwork/logo"
  end
end
