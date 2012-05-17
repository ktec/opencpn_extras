#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'

doc = Nokogiri::XML(File.read("./stations_by_program.kml"))
xslt = Nokogiri::XSLT(File.read('./stylesheet.xslt'))

#puts xslt.transform(doc, ['key', 'value'])
puts xslt.transform(doc)
