#!/usr/bin/env ruby

class Package
  attr_reader :errors

  def initialize(path_to_script)
    @path_to_script = path_to_script
  end

  def generate
    raise 'Package invalid' unless valid?

    prepare_directories
    add_executable
    @generated = true
  end

  def valid?
    validate
    errors.empty?
  end

  def validate
    return (@errors = ['Not a file']) unless File.file?(@path_to_script)

    errors = []

    basename = File.basename(path)
    errors << 'Too many dots in file name' if basename.count('.') > 1
    errors << "#{path} already exists" if !generated? && File.exist?(path)
    # TODO: another validations

    @errors = errors.freeze
  end

  def generated?
    @generated
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

package = Package.new(ARGV.first)

if package.valid?
  package.generate
  puts "Generated: #{package.path}"
else
  puts "There're some errors:"
  puts
  package.errors.each { |message| puts "* #{message}" }
end
