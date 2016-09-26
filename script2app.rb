#!/usr/bin/env ruby

class Package
  def initialize(path_to_script)
    @path_to_script = path_to_script
  end

  def generate
    prepare_directories
    add_executable
  end

  def appname
    filename = File.basename(@path_to_script)
    filename.split('.').first
  end

  def path
    "#{appname}.app"
  end

  private

  def prepare_directories
    Dir.mkdir(path)
    Dir.mkdir("#{path}/Contents")
    Dir.mkdir("#{path}/Contents/MacOS")
  end

  def add_executable
    executable_path = "#{path}/Contents/MacOS/#{appname}"
    `cp #{@path_to_script} #{executable_path}`
    `chmod +x #{executable_path}`
  end
end

Package.new(ARGV.first).generate
