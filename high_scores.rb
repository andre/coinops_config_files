class HighScores < ConfigBase
  DESCRIPTION = "Control high score display behavior."
  OPTIONS = {
    disabled: "Hide high scores.",
    dynamic_iscored_cycle: "iScored cycles on/off.",
    dynamic_iscored_cycle_second: "iScored cycles on/off on 2nd display.",
    dynamic_iscored_cycle_second_thin: "iScored cycles on/off on thin 2nd display.",
    dynamic_local_cycle: "Local scores cycle on/off.",
    dynamic_local_cycle_second: "Local scores cycle on/off on 2nd display.",
    dynamic_local_cycle_second_thin: "Local scores cycle on/off on thin 2nd display.",
    iscored_always_second: "iScored always shown on 2nd display.",
    iscored_always_second_thin: "iScored always shown on thin 2nd display.",
    iscored_persist_on_load_second: "iScored persists on 2nd display at game load.",
    local_always_second: "Local scores always shown on 2nd display.",
    local_always_second_thin: "Local scores always shown on thin 2nd display.",
    local_persist_on_load_second: "Local scores persist on 2nd display at game load.",
    no_scores_persist_on_load: "No high scores shown, persists at game load."
  }
  DEFAULT = "disabled"
  CATEGORY = "Look & Feel"

  LAYOUTS = {
    "disabled" => {layout: "layouts/Arcades/layout - 4 None.xml", controls: true},
    "dynamic_iscored_cycle" => {layout: "layouts/Arcades/layout - 4_4.xml", controls: true},
    "dynamic_iscored_cycle_second" => {layout: "layouts/Arcades/layout - 4_7.xml", controls: true},
    "dynamic_iscored_cycle_second_thin" => {layout: "layouts/Arcades/layout - 4_17.xml", controls: true},
    "dynamic_local_cycle" => {layout: "layouts/Arcades/layout - 4_5.xml", controls: true},
    "dynamic_local_cycle_second" => {layout: "layouts/Arcades/layout - 4_6.xml", controls: true},
    "dynamic_local_cycle_second_thin" => {layout: "layouts/Arcades/layout - 4_16.xml", controls: true},
    "iscored_always_second" => {layout: "layouts/Arcades/layout - 4_9.xml", controls: true},
    "iscored_always_second_thin" => {layout: "layouts/Arcades/layout - 4_19.xml", controls: true},
    "iscored_persist_on_load_second" => {layout: "layouts/Arcades/layout - 4_3.xml", controls: false},
    "local_always_second" => {layout: "layouts/Arcades/layout - 4_8.xml", controls: true},
    "local_always_second_thin" => {layout: "layouts/Arcades/layout - 4_18.xml", controls: true},
    "local_persist_on_load_second" => {layout: "layouts/Arcades/layout - 4_2.xml", controls: false},
    "no_scores_persist_on_load" => {layout: "layouts/Arcades/layout - 4_1.xml", controls: false}
  }.freeze

  def set(val)
    config = LAYOUTS[val]
    return unless config

    copy(config[:layout], "layouts/Arcades/layout - 4.xml")

    write_controls(config[:controls])
    conf_value = (val == "disabled") ? "false" : "true"
    set_conf "settings.conf", "globalHiscoresEnabled = #{conf_value}"
  end

  def status
    layout_file = "layouts/Arcades/layout - 4.xml"
    entry = LAYOUTS.find do |_, cfg|
      files_equal?(layout_file, cfg[:layout])
    rescue Errno::ENOENT
      false
    end
    entry ? entry.first : "unknown"
  end

  private

  def write_controls(mode)
    case mode
    when :joy
      set_conf "settings.conf", <<~CONF
        toggleCollectionInfo = joyButton2
        toggleBuildInfo = joyButton1
        letterDown = N,joyButton4
        letterUp = M,joyButton5
      CONF
    else
      set_conf "settings.conf", <<~CONF
        toggleCollectionInfo = null
        toggleBuildInfo = null
        letterDown = null
        letterUp = null
      CONF
    end
  end
end
