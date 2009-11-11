require "rubygems"
require "net/ping/icmp"
require 'config/environment.rb'


class Discoverer

  attr_accessor :result

  def initialize(network)
    @addresses = network.address_list
    @iface= network.interface

    @usr = APP_CONFIG[:pwdless_user]
    @arping_path = APP_CONFIG[:arping_path]
    @run_as_root = APP_CONFIG[:run_as_root]

    @result = {} 
    @addresses.each {|a| @result[a] = {:mac => ""}  }
    network.devices.each {|d| 
      @result[d.ip_address] = { :name => d.name, :host => d.host, :ip_address => d.ip_address, :vendor_name => d.vendor.name, :vendor_id => d.vendor.id, :mac_address => d.mac_address } 
    }


    @threads = []
  end

  def run
    @addresses.each {|ip|
    @threads << Thread.new(ip) do |ip|
      if @run_as_root
        var =  %x[ #{@arping_path} -f -I #{@iface} -c 2 #{ip}].split("\n")
        if var.size < 2 
          @result[ip][:mac_address] = "unknown" 
        else
          @result[ip][:mac_address] =  var[1][/(\w\w:){5}(\w\w)/] 
        end
        #@result[ip][:mac] = %x[ #{@arping_path} -f -I #{@iface} -c 2 #{ip}].split("\n")[1][/(\w\w:){5}(\w\w)/] || "unknown"
        
        #raise "#{@result[ip][:mac]}"
       # = %x[ #{@arping_path} -f -I #{@iface} -c 2 #{ip}].split("\n")[1][/(\w\w:){5}(\w\w)/] || "unknown"
      else
        @result[ip][:mac_address] = %x[sudo -u #{@usr} #{@arping_path} -f -I #{@iface} -c 2 #{ip}].split("\n")[1][/(\w\w:){5}(\w\w)/] || "unknown"
      end
       
    end
    }
    @threads.each {|th| th.join}
    return self
  end

  def identify_macs
    vendors = Vendor.vendors_list
    @result.each {|dev|
      sel_vendor = vendors.select {|vendor| dev.last[:mac_address] =~ /#{vendor[:mac_prefix]}/ }.first

      dev.last[:vendor_id] = sel_vendor.nil? ? nil : sel_vendor[:vendor_id]
      dev.last[:vendor_name] = (dev.last[:mac_address] == "unknown") ? "unknown" : sel_vendor.nil? ? "other" : sel_vendor[:name]
    }
    @result = @result.sort {|a,b| a.first.split(".").last.to_i  <=> b.first.split(".").last.to_i}
    
    return self

  end

end


#puts Vendor.all.inspect

#unknown -> gray
