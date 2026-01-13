class SecondScreenControlsOverlay < ConfigBase
  DESCRIPTION = "Toggle second screen controls overlay."
  OPTIONS = {enabled: "Enable overlay.", disabled: "Disable overlay."}
  DEFAULT = "disabled"

  def set(val)
    case val
    when "enabled"
      copy "layouts/Arcades/layout - 3_2.xml", "layouts/Arcades/layout - 3.xml"
    when "disabled"
      copy "layouts/Arcades/layout - 3_1.xml", "layouts/Arcades/layout - 3.xml"
    end
  end

  def status
    target = "layouts/Arcades/layout - 3.xml"
    return "enabled" if files_equal?(target, "layouts/Arcades/layout - 3_2.xml")
    return "disabled" if files_equal?(target, "layouts/Arcades/layout - 3_1.xml")
    "unknown"
  rescue Errno::ENOENT
    "unknown"
  end
end

class SecondScreenMetadata < ConfigBase
  DESCRIPTION = "Enable or disable metadata on the second screen."
  OPTIONS = {
    enabled: "Enable metadata overlay.",
    disabled: "Disable metadata overlay."
  }
  DEFAULT = "disabled"

  def set(val)
    case val
    when "enabled"
      copy "layouts/Arcades/layout - 6_2.xml", "layouts/Arcades/layout - 6.xml"
    when "disabled"
      remove "layouts/Arcades/layout - 6.xml"
    end
  end

  def status
    target = "layouts/Arcades/layout - 6.xml"
    if exist?(target) && files_equal?(target, "layouts/Arcades/layout - 6_2.xml")
      return "enabled"
    end
    "disabled"
  rescue Errno::ENOENT
    "disabled"
  end
end

class SecondScreenTimeDisplay < ConfigBase
  DESCRIPTION = "Configure time/date overlay on the second screen."
  OPTIONS = {
    time: "Show the current time only.",
    datetime: "Show both the current time and date.",
    disabled: "Do not show the time or date."
  }
  DEFAULT = "disabled"

  def set(val)
    case val
    when "time"
      copy "layouts/Arcades/layout - 5_4.xml", "layouts/Arcades/layout - 5.xml"
    when "datetime"
      copy "layouts/Arcades/layout - 5_2.xml", "layouts/Arcades/layout - 5.xml"
    when "disabled"
      remove "layouts/Arcades/layout - 5.xml"
    end
  end

  def status
    target = "layouts/Arcades/layout - 5.xml"
    if exist?(target)
      return "time" if files_equal?(target, "layouts/Arcades/layout - 5_4.xml")
      return "datetime" if files_equal?(target, "layouts/Arcades/layout - 5_2.xml")
    end
    "disabled"
  rescue Errno::ENOENT
    "disabled"
  end
end
