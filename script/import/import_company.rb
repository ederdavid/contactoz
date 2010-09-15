#!/usr/local/bin/ruby -w

#require File.dirname(__FILE__) + '/../../config/environment'
require 'rubygems'
require 'fastercsv-1.5.3'

 def import
     FasterCSV.foreach('/Users/tina/Desktop/contact/script/import/NL.csv') do |row|
     c=Company.new
        c.company_name=row[0]
        c.company_state=row[1]
        c.company_city=row[2]
        c.company_address=row[3]
        c.colonia=row[4]
        c.company_postcode=row[5]
        c.company_phone=row[6]
        c.company_fax=row[7]
        c.company_site=row[8]
        c.giro=row[9]
        c.scian=row[10]
        c.employee_number=row[11]
        c.revenue=row[12]
        c.year_started=row[13]
     if c.save
        put 'success'	
     end
   end



