#$:.unshift(File.dirname(__FILE__)) unless
#  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

#module Teliaxr
#  VERSION = '0.0.1'
  require 'rubygems' 
  I_KNOW_I_AM_USING_AN_OLD_AND_BUGGY_VERSION_OF_LIBXML2=1
  require 'mechanize'
  require 'nokogiri'

class PhoneInvestigator
  attr_accessor :user_id, :display_name
  def initialize(ip_address, vendor_name)
    @agent = WWW::Mechanize.new
    @url = "http://#{ip_address}"
    @page = ""
    @vendor = vendor_name
    @user_id = ""
    @display_name = ""
  end

  def start
  end
end


class MitelInvestigator < PhoneInvestigator
  def initialize(ip_address, vendor_name)
    @username = "admin"
    @password = ""
    super
  end

  def start
    %w(5224 5220 5215 5212).each do |m|
      begin
        @password = m
        @agent.basic_auth(@username, @password)
        @page = @agent.get @url
        break
      rescue => e
      end
    end

    @page = @agent.click(@page.links.select {|l| l.text =~/Quick Start/}.first)
    form = @page.forms.first
    @user_id =  form['userId']
    @display_name = form['userDisName']
    return true
  end
end

class PolycomInvestigator < PhoneInvestigator
  def initialize(ip_address, vendor_name)
    @username = "Polycom"
    @password = "123"
    super
  end

  def start
    @page = @agent.get @url
    @page = @agent.click(@page.links.select {|l| l.text =~/Line/}.first)
    form = @page.forms.first
    #puts @vendor
    @display_name = form['reg.1.displayName']
    @user_id =  form['reg.1.auth.userId']
    return true
  end
end




class PhoneInvestigatorFactory
  def self.build(ip_address, vendor_name)
    if vendor_name == "Mitel"
     return MitelInvestigator.new(ip_address, vendor_name)
    elsif vendor_name == "Polycom"
     return PolycomInvestigator.new(ip_address, vendor_name)
    end
  end
end

#mitel = PhoneInvestigatorFactory.build("172.101.1.119", "Mitel")
#mitel.start
#
#puts mitel.display_name
#puts mitel.user_id
#
#puts

#polycom =  PhoneInvestigatorFactory.build("172.101.1.13", "Polycom")
#polycom.start

#puts polycom.display_name
#puts polycom.user_id
