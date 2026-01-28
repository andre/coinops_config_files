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

  # Below here are helpers for reading and writing config files with key-value pairs.
  # Supports both .conf files and .ini files -- they only vary by the delimiter 
  def delimiter_for(path)
    File.extname(path) == ".conf" ? "=" : " "
  end

  # Regex is used in multiple places, so it's extracted here.
  # After matching: $1 = key, $2 = value
  def line_matcher_regex(key, delimiter)
    #       Key                     Delim         Value
    /^\s*(#{Regexp.escape(key)})\s*#{Regexp.escape(delimiter)}\s*(\S+)/
  end

  # Given a path to a config file and a key, return the value as a string.
  # - .conf files use `key = value` format
  # - .ini files use `key value` format (space-delimited)
  # - Use the `delimiter:` option to override the automatic detection
  #
  # If the file doesn't exist, capture the failure in the @failures array and returns nil.
  # If the key doesn't exist, returns nil.
  def get_value(path, key, delimiter: nil)
    delimiter ||= delimiter_for(path)

    File.readlines(path).each do |line|
      line = line.strip
      next if line.empty? || line.start_with?("#") || line.start_with?(";")
            
      if line =~ line_matcher_regex(key, delimiter)
        return $2
      end
    end
    nil
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message     
  end

  # Given a path to a config file and text containing key-value pairs,
  # find or create the indicated keys with their corresponding values.
  # - .conf files use `key = value` format
  # - .ini files use `key value` format (space-delimited)
  # - Use the `delimiter:` option to override the automatic detection
  #
  # If the file doesn't exist, capture the failure in the @failures array and returns nil.
  def set_value(path, text, delimiter: nil)
    delimiter ||= delimiter_for(path)

    # Parse INPUT text to extract key value pairs
    keys_to_update = {}
    text.lines.each do |line|
      k,v = line.strip.split(/\s*#{Regexp.escape(delimiter)}\s*/, 2)  
      keys_to_update[k] = v
    end

    # STEP 1: Replace value for keys that ALREADY exist in the file
    content = File.read(path)
    matched_keys = []
    keys_to_update.each do |key, value|
      line_matcher_regex = line_matcher_regex(key, delimiter)
      if content.gsub!(line_matcher_regex, "#{key} #{delimiter} #{value}")
        matched_keys << key
      end
    end

    # STEP 2: Append key-value pairs that did NOT already exist in the file
    remaining = keys_to_update.except(*matched_keys)
    remaining.each do |key, value|
      content << "\n#{key} #{delimiter} #{value}" 
    end

    # STEP 3: Write the updated content back to the file
    File.write(path, content)
  rescue Errno::ENOENT => e
      failures << self.class.name+": "+e.message     
  end

  # Array of failure messages encountered during file operations. It's common that files don't exist, expecially across different versions of CoinOps (max, micro, etc).
  # in cases when that happens, we just capture failure here to expose them in the UI and/or log them as needed. 
  def failures
    @failures ||= []
  end

end

# Each config has its owbn class, and it should inherit from this ConfigBase class
class ConfigBase
  include ::Helpers

  # This relies on both a method and a constant that is defined in all child classes.
  def reset!
    set(default)
    self # so it's chainable
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

  def self.description
    const_defined?(:DESCRIPTION) ? const_get(:DESCRIPTION) : ""
  end

  # convenience method to call on an instance
  def description
    self.class.description
  end

  # convenience method to call on an instance
  def options
    self.class.options
  end  

  # To call on a specific class. Note that in order to get the status, an instance must be created.
  def self.to_hash(status = true)
    {
      "name" => name,
      "description" => description,
      "options" => options.transform_keys(&:to_s),
      "default" => default,
      "selected" => status ? new.status : ""
    }
  end
end

# Commands are different. All commands live in one class, and each command is a method. The Command class should inherit from this CommandBase class, 
# to have access to all the helpers plus the to_array method.
class CommandBase
  include ::Helpers

  def self.all
    descriptions = const_get(:DESCRIPTIONS)
    instance_methods(false).sort.map do |name|
      {"name" => name.to_s, "description" => descriptions[name]}
    end
  end
end
