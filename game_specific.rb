class LaserDiscGameArrows < ConfigBase
  DESCRIPTION = "Show in-game helper arrows for Dragon's Lair and Space Ace (and potentially other laser disk in the future). When enabled, you'll see the specific move you need to make flashed on the screen."
  OPTIONS = {
    enabled: "Show the arrows (makes games much easier).",
    disabled: "Don't show the arrows (makes games harder, but more authentic to the original experience)."
  }
  DEFAULT = "enabled"

  def set(val)
    case val
    when "enabled"
      copy "collections/Arcade/launchers/Dragons Lair with Helper.conf", "collections/Arcade/launchers/Dragons Lair.conf"
      copy "collections/Arcade/launchers/Space Ace with Helper.conf", "collections/Arcade/launchers/Space Ace.conf"
    when "disabled"
      copy "collections/Arcade/launchers/Dragons Lair no Helper.conf", "collections/Arcade/launchers/Dragons Lair.conf"
      copy "collections/Arcade/launchers/Space Ace no Helper.conf", "collections/Arcade/launchers/Space Ace.conf"
    end
  end

  def status
    dragons_helper = begin
      files_equal?(
        "collections/Arcade/launchers/Dragons Lair.conf",
        "collections/Arcade/launchers/Dragons Lair with Helper.conf"
      )
    rescue
      false
    end

    dragons_helper ? "enabled" : "disabled"
  end
end

# TODO: What's the gist of the different ROM sets?
class CPS2MarvelRoms < ConfigBase
  DESCRIPTION = "Choose which CPS2 Marvel ROM set to Use."
  OPTIONS = {
    standard: "Use the standard CPS2 Marvel ROMs.",
    boss: "Use the boss-hack CPS2 Marvel ROMs."
  }
  DEFAULT = "boss"

  def set(val)
    case val
    when "standard"
      copy_matching "autochanger/CPS2 Marvel Non Boss Hack Roms/*", "emulators/mame/roms"
    when "boss"
      copy_matching "autochanger/CPS2 Marvel Boss Hack Roms/*", "emulators/mame/roms"
    end
  end

  def status
    files_equal?("emulators/mame/roms/msh.zip", "autochanger/CPS2 Marvel Boss Hack Roms/msh.zip") ? "boss" : "standard"
  rescue
    "unknown"
  end
end

class PlayersTwoFour < ConfigBase
  DESCRIPTION = "For a handful of specific games, launch 4-player versions or 2-player versions. You should only set to 4-player if you have a cabinet or setup with enough controllers. The games are: tmnt22pu tmnt2po ssridersabd simpsons2p centiped."
  OPTIONS = {
    "2p": "Use 2-player versions of these specific games.",
    "4p": "Use 4-player versions of these specific games. Only use if you have enough controllers."
  }
  DEFAULT = "2p"

  def set(val)
    case val
    when "2p"
      %w[Arcade Arcade34 Arcade94 Arcade248].each do |collection|
        %w[tmnt22pu tmnt2po ssridersabd simpsons2p centiped].each do |file|
          remove "collections/#{collection}/launchers/#{file}.conf"
        end
      end
    when "4p"
      %w[Arcade Arcade34 Arcade94 Arcade248].each do |collection|
        %w[tmnt22pu tmnt2po ssridersabd simpsons2p].each do |file|
          copy "autochanger/Player2P4P/#{file}.conf", "collections/#{collection}/launchers/#{file}.conf"
        end
      end
    end
  end

  def status
    exist?("collections/Arcade/launchers/tmnt22pu.conf") ? "4p" : "2p"
  end
end
