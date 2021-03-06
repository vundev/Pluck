require 'rubygems'
require 'bundler'
require 'bundler/setup'

require 'rake/clean'
require 'flashsdk'
require 'asunit4'

##
# Set USE_FCSH to true in order to use FCSH for all compile tasks.
#
# You can also set this value by calling the :fcsh task 
# manually like:
#
#   rake fcsh run
#
# These values can also be sent from the command line like:
#
#   rake run FCSH_PKG_NAME=flex3
#
# ENV['USE_FCSH']         = true
# ENV['FCSH_PKG_NAME']    = 'flex4'
# ENV['FCSH_PKG_VERSION'] = '1.0.14.pre'
# ENV['FCSH_PORT']        = 12321

$framework_version = '\'1.1.0\''

##############################
# Debug

# Compile the debug swf
mxmlc "bin/Pluck-debug.swf" do |t|
  t.input = "src/Pluck.as"
  t.static_link_runtime_shared_libraries = true
  t.debug = true
  t.define_conditional << 'CONFIG::debug,true -define=CONFIG::version,' + $framework_version
end

desc "Compile and run the debug swf"
flashplayer :run => "bin/Pluck-debug.swf"

##############################
# Test

library :asunit4

# Compile the test swf
mxmlc "bin/Pluck-test.swf" => :asunit4 do |t|
  t.input = "src/PluckRunner.as"
  t.static_link_runtime_shared_libraries = true
  t.source_path << 'test'
  t.debug = true
  t.define_conditional << 'CONFIG::debug,true -define=CONFIG::version,' + $framework_version
end

desc "Compile and run the test swf"
flashplayer :test => "bin/Pluck-test.swf"

##############################
# SWC

compc "bin/Pluck.swc" do |t|
  t.static_link_runtime_shared_libraries = true
  t.source_path << 'src'
  t.include_sources << 'src/pluck/'
  t.define_conditional << 'CONFIG::debug,false -define=CONFIG::version,' + $framework_version
end

desc "Compile the SWC file"
task :swc => 'bin/Pluck.swc'

##############################
# DOC

desc "Generate documentation at doc/"
asdoc 'doc' do |t|
  t.doc_sources << "src"
  t.exclude_sources << "src/PluckRunner.as"
  t.define_conditional << 'CONFIG::debug,false -define=CONFIG::version,' + $framework_version
end

##############################
# DEFAULT
task :default => :run

