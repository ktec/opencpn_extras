#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'

doc = Nokogiri::XML(File.read("./list.html"))
xslt = Nokogiri::XSLT(File.read('./stylesheet.xslt'))



#puts xslt.transform(doc, ['key', 'value'])
puts xslt.transform(doc)
