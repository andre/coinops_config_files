class GamePreviewSound < ConfigBase
  DESCRIPTION = "Do you want to hear game sounds along with video in the previews?"
  OPTIONS = {
    enabled: "You will hear sounds from the game previews as you scroll through the game list, and as the system sits idle.",
    disabled: "You will not hear any game sounds during the game previews."
  }
  DEFAULT = "enabled"

  def set(val)
    case val
    when "enabled"
      set_value "settings.conf", "MuteVideo = no"
    when "disabled"
      set_value "settings.conf", "MuteVideo = yes"
    end
  end

  def status
    val = get_value("settings.conf", "MuteVideo").downcase 
    val == "no" ? "enabled" : "disabled"
  end
end

class MixTape < ConfigBase
  DESCRIPTION = "What list of songs to play during attract mode. Tracks are curated by the CoinOPS team."
  OPTIONS = {
    default: "Africa, Eye of the Tiger, Man in the Mirror",
    glam: "Here I Go Again, Living on a Prayer, Rocket",
    beats: "Be My Lover, Stike it Up, Rythm is a Dancer",
    "80s": "Careless Whisper, Jessie's Girl, Take on Me"
  }
  DEFAULT = "default"

  # TODO: this could be made much tighter by just naming the folders consistently with the option keys, or by taking input the same as the folder names
  # Or by reading out of the music/ directory for the available values ...
  def set(val)
    case val
    when "default"
      set_value "settings.conf", %q[musicPlayer.folder = ./music/MixTape (ARISE)]
    when "glam"
      set_value "settings.conf", %q[musicPlayer.folder = ./music/MixTape (Glam Rock)]
    when "beats"
      set_value "settings.conf", %q[musicPlayer.folder = ./music/MixTape (Beats)]
    when "80s"
      set_value "settings.conf", %q[musicPlayer.folder = ./music/MixTape (The 80s)]
    end
  end

  def status
    val = get_value("settings.conf", "musicPlayer.folder")
    if val.include?("ARISE")
      "default"
    elsif val.include?("Glam Rock")
      "glam"
    elsif val.include?("Beats")
      "beats"
    elsif val.include?("The 80s")
      "80s"
    else
      "unknown"
    end
  end
end

class MixTapePlay < ConfigBase
  DESCRIPTION = "When do you want the Mixtape music to play? It can play in the game selection menu, during gameplay, both or neither."
  OPTIONS = {
    menu: "music is played in the game selection menu only.",
    game: "music is played during gameplay only.",
    both: "Music plays while in the menu, and continues to play when you launch a game.",
    none: "No music is played at any time."
  }
  DEFAULT = "menu"

  def set(val)
    case val
    when "menu"
      set_value "settings.conf", '
            musicPlayer.enabled = true
            musicPlayer.playInGame = false'
    when "game"
      set_value "settings.conf", '"
            musicPlayer.enabled = false
            musicPlayer.playInGame = true
            musicPlayer.playInGameVol = 100'
    when "both"
      set_value "settings.conf", '
            musicPlayer.enabled = true
            musicPlayer.playInGame = true
            musicPlayer.playInGameVol = 100'
    when "none"
      set_value "settings.conf", '
            musicPlayer.enabled = false
            musicPlayer.playInGame = false'
    end
  end

  def status
    enabled = get_value("settings.conf", "musicPlayer.enabled") == "true"
    play_in_game = get_value("settings.conf", "musicPlayer.playInGame") == "true"

    if enabled && !play_in_game
      "menu"
    elsif !enabled && play_in_game
      "game"
    elsif enabled && play_in_game
      "both"
    else
      "none"
    end
  end
end


