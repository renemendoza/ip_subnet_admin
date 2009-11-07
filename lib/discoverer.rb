require "rubygems"
require "net/ping/icmp"


class Discoverer

  attr_accessor :result

  def initialize(addr_list, usr, arping_path, iface, run_as_root=false)
    @addresses = addr_list
    @usr = usr
    @iface= iface
    @arping_path = arping_path
    @result = {} 
    addr_list.each {|a| @result[a] = {:mac => ""}  }
    @threads = []
    @run_as_root = run_as_root
  end

  def run
    @addresses.each {|ip|
    @threads << Thread.new(ip) do |ip|
      if @run_as_root
        @result[ip][:mac] = %x[ #{@arping_path} -f -I #{@iface} -c 2 #{ip}].split("\n")[1][/(\w\w:){5}(\w\w)/] || "unknown"
      else
        @result[ip][:mac] = %x[sudo -u #{@usr} #{@arping_path} -f -I #{@iface} -c 2 #{ip}].split("\n")[1][/(\w\w:){5}(\w\w)/] || "unknown"
      end
       
    end
    }
    @threads.each {|th| th.join}
    return self
  end

  def identify_macs(vendors)
    @result.each {|dev|
      sel_vendor = vendors.select {|vendor| dev.last[:mac] =~ /#{vendor[:mac_prefix]}/ }.first

      dev.last[:vendor_id] = sel_vendor.nil? ? nil : sel_vendor[:vendor_id]
      dev.last[:vendor_name] = (dev.last[:mac] == "unknown") ? "unknown" : sel_vendor.nil? ? "other" : sel_vendor[:name]
    }
    @result = @result.sort {|a,b| a.first.split(".").last.to_i  <=> b.first.split(".").last.to_i}
    
    return self

  end

end


#unknown -> gray
