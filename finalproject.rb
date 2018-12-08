#!/bin/ruby
require "pathname"
require "fileutils"
require "net/scp"

$user = "bc73696"
$server = "icarus.cs.weber.edu"
$serverFolder = Pathname("/home/hvalle/submit/cs3030/files/")
$custFolder = "fredData"
$custFile = ARGV[3]
$workingDir = Dir.pwd
$path = "#{$custFolder}/#{$curMonth}"

class HelpClass
    def usage()
        puts "Usage: $0 [-s sedsrc] [-a awksrc] [-i inputFile]"
        puts "Both arguments are required"
        exit(1)
    end
end


if ARGV[0] == "--help" || ARGV.empty?
    object = HelpClass.new
    object.usage
elsif ARGV[0] == "-c" && ARGV[2] == "-f"
    puts "Working on #{$workingDir}"
    puts "Checking for data structure"
    # create appropriate folders if they don't exist
    $time = Time.new
    $curMonth = $time.month
    unless File.directory?($custFolder)
        puts "Customer fredData folder is missing"
        puts "Creating folder"
        FileUtils.mkdir_p ("#{$custFolder}/#{$curMonth}")
    end
    # retrive the file via SCP and save it to the appropriate folder
    puts "Getting file from customer server"
    Net::SCP.download!("#{$server}", "#{$user}", "#{$serverFolder}/#{$custFile}",
                       "#{$custFolder}/#{$curMonth}")
    File.rename("/#{$custFolder}/#{$curMonth}/#{$custFile}", "/#{$custFolder}/#{$curMonth}/stupid.csv")
    puts "File located at..."
else
    object = HelpClass.new
    object.usage
end
