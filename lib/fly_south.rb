module FlySouth

  module Migrations
  end

  Migration = Struct.new :file, :id, :tag

  class Runner

    include Migrations

    attr_reader :versions, :current

    def initialize(versions, current)
      @versions, @current = versions.freeze, current
    end

    # returns number of successful migrations
    def migrate(delta)
      if delta == 0
        return
      elsif delta > 0 # up
        run = @versions[@current+1, delta]
      else # down
        run = @versions[@current+delta+1..@current].reverse!
      end

      begin
        run.each do |mig|
          method = :"#{mig.tag}_#{delta > 0 ? 'up' : 'down'}"
          puts "=== #{method} (#{mig.id}) ==="
          require mig.file
          if respond_to? method
            send method
            puts "> completed"
            puts ""
          else
            puts "> #{method} is not defined; ignoring\n"
            puts ""
          end
          @current += (delta <=> 0)
        end
      rescue Exception => e
        $stderr.puts "> error: #{e.inspect}"
        $stderr.puts e.backtrace.map{|l| "  #{l}"}.join "\n"
        puts ""
      end
    end
  end

end