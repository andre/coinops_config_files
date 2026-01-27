# this module proides a few helpers common to both Configs and Commands. It gets included in both
# ConfigBase and CommandBase for access where it's needed
#
module Helpers
  def remove(path)
    FileUtils.rm(path) if File.exist?(path)
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message     
  end

  def copy(src, dest)
    FileUtils.cp(src, dest)
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message   
  end

  # copy all the files matching the glob passed in src. Example:
  # copy_matching("autochange/WallsAttract/*", "layouts/Arcades")
  def copy_matching(src, dest)
    FileUtils.cp_r Dir.glob(src), dest
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message     
  end

  def exist?(path)
    File.exist?(path)
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message     
  end

  # given two paths, check if the files are equal via MD5 checksum
  # Will throw a Errno::ENOENT if either file doesn't exist
  def files_equal?(path1, path2)
    Digest::MD5.file(path1).hexdigest == Digest::MD5.file(path2).hexdigest
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message 
  end

  # given a path to a .conf file with `key = value` format, plus a key, return the value as a string.
  # if the key doesn't exist, return nill
  def get_conf(path, key)
    File.readlines(path).each do |line|
      line = line.strip
      next if line.empty? || line.start_with?("#")

      parts = line.split("=", 2)
      if parts.length == 2 && parts[0].strip == key
        return parts[1].strip
      end
    end
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message
  end

  # given a path to a .conf file with `key = value` format, plus "text" with any number of `key = value` pairs,
  # find or create the indicated keys in the file with their corresponding values. If any of the keys don't exist, just create them.
  def set_conf(path, text)
    # Parse input text to extract key-value pairs
    updates = {}
    text.lines.each do |line|
      line =~ /^\s*(.+?)\s*=\s*(.+)\s*$/
      updates[$1] = $2 if $1
    end

    # Read file and replace matching keys
    content = File.read(path)
    matched_keys = []
    updates.each do |key, value|
      if content.gsub!(/^\s*#{Regexp.escape(key)}\s*=.*$/, "#{key} = #{value}")
        matched_keys << key
      end
    end

    # handle any key/values that didn't get taken care of above
    remaining = updates.except(*matched_keys)
    content << remaining.map { |k, v| "#{k} = #{v}\n" }.join

    File.write(path, content)
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message     
  end

  # given a path to a .ini file with `key  value` format, plus a key, return the value as a string
  #
  # if they key isn't found, return nil
  def get_ini(path, key)
    File.readlines(path).each do |line|
      line = line.strip
      next if line.empty? || line.start_with?("#") || line.start_with?(";")

      if line =~ /^\s*(\S+)\s+(.+)$/
        return $2.strip if $1 == key
      end
    end
    nil
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message     
  end

  # given a path to a .conf file with `key value` format, plus "text" with any number of `key value` pairs,
  # find or create the indicated keys in the file with their corresponding values. If any of the keys don't exist, just create them.
  #
  def set_ini(path, text)
    # Parse input text to extract key value pairs (key followed by whitespace then value)
    updates = {}
    text.lines.each do |line|
      line =~ /^\s*(\S+)\s+(.+)\s*$/
      updates[$1] = $2.strip if $1
    end

    # Read file and replace matching keys
    content = File.read(path)
    matched_keys = []
    updates.each do |key, value|
      if content.gsub!(/^\s*#{Regexp.escape(key)}\s+.*$/, "#{key} #{value}")
        matched_keys << key
      end
    end

    # handle any key/values that didn't get taken care of above
    remaining = updates.except(*matched_keys)
    content << remaining.map { |k, v| "#{k} #{v}\n" }.join

    File.write(path, content)
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message     
  end

  def failures
    @failures ||= []
  end

end

class ConfigBase
  include ::Helpers

  # This relies on both a method and a constant that is defined in all child classes.
  def reset!
    set(default)
    self
  end

  def self.default
    const_defined?(:DEFAULT) ? const_get(:DEFAULT) : ""
  end

  def default
    self.class.default
  end

  def self.options
    const_defined?(:OPTIONS) ? const_get(:OPTIONS) : {}
  end

  def options
    self.class.options
  end

  def self.description
    const_defined?(:DESCRIPTION) ? const_get(:DESCRIPTION) : ""
  end

  def description
    description
  end

  def self.to_hash(status = true)
    {
      "name" => name,
      "description" => description,
      "options" => options.transform_keys(&:to_s),
      "default" => default,
      "selected" => status ? new.status : ""
    }
  end

  def self.to_array
    ConfigBase.subclasses.sort_by { |c| c.name }.map do |c|
      {
        "name" => c.name,
        "description" => c.description,
        "options" => c.options.transform_keys(&:to_s),
        "default" => c.default
      }
    end
  end
end

class CommandBase
  include ::Helpers

  def self.to_array
    descriptions = const_get(:DESCRIPTIONS)
    instance_methods(false).sort.map do |name|
      {"name" => name.to_s, "description" => descriptions[name]}
    end
  end
end
